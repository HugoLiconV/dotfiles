#!/bin/zsh
zmodload zsh/datetime
# Current weather from wttr.in, cached so the status bar never blocks on the network
# Usage: weather.sh [-i minutes] [-f] [-l location] [-L] [-q]
#   -i  minutes between fetches (default 30)
#   -f  Fahrenheit (default Celsius)
#   -l  fixed location (default: IP geolocation)
#   -L  show location
#   -q  hide errors
interval=30 unit=m location= show_location=false quiet=false
while getopts 'i:fl:Lq' opt; do
  case $opt in
    i) interval=$OPTARG ;;
    f) unit=u ;;
    l) location=$OPTARG ;;
    L) show_location=true ;;
    q) quiet=true ;;
  esac
done

# One cache per option set, so different configs don't clobber each other
key=$(print -r -- "$unit|$location|$show_location" | md5 -q)
cache=${TMPDIR:-/tmp}/herdr-weather-$key
stamp=$cache.stamp err=$cache.err lock=$cache.lock

fetch() {
  local resp
  # --fail drops the body on unknown locations, which may otherwise leak your geoip location
  if ! resp=$(curl -fsSL -m 5 "https://wttr.in/${location// /%20}?format=%C:%t:%l&$unit" 2>&1); then
    [[ $resp == *404* ]] && print -n 'Unknown Location' >$err || print -n 'Weather Unavailable' >$err
    return
  fi
  local cond=${(L)resp%%:*} rest=${resp#*:}
  local temp=${${rest%%:*}/+/} place=${rest#*:}
  [[ ${place//[^,]/} == ,, ]] && place=${place%,*}  # drop country

  local icon
  case $cond in
    *thunder*)                 icon=$'' ;;
    *snow*|*sleet*|*blizzard*) icon=$'' ;;
    *rain*|*shower*|*drizzle*) icon=$'' ;;
    *fog*|*mist*|*haze*)       icon=$'' ;;
    *partly*)                  icon=$'' ;;
    *cloud*|*overcast*)        icon=$'' ;;
    *)                         icon=$'' ;;
  esac

  local out="$icon $temp"
  $show_location && out+=" $place"
  print -n -- $out >$cache.tmp && mv $cache.tmp $cache && rm -f $err
}

# Refresh in the background when stale; the stamp marks attempts so failures don't retry every tick
last=$(stat -f %m $stamp 2>/dev/null || echo 0)
if (( EPOCHSECONDS - last >= interval * 60 )) && mkdir $lock 2>/dev/null; then
  touch $stamp
  ( fetch; rmdir $lock ) &>/dev/null &!
fi

if [[ -s $cache ]]; then
  cat $cache
elif ! $quiet && [[ -s $err ]]; then
  cat $err
fi
