#!/bin/zsh
# Memory in use, Activity Monitor style: app (anonymous - purgeable) + wired + compressed
total=$(sysctl -n hw.memsize)
pct=$(vm_stat | awk -v total=$total '
  /page size of/          {ps=$8}
  /Anonymous pages/       {anon=$3}
  /Pages purgeable/       {purg=$3}
  /Pages wired down/      {wired=$4}
  /occupied by compressor/{comp=$5}
  END {printf "%d", (anon-purg+wired+comp)*ps*100/total}')
printf 'RAM %s%%' $pct
