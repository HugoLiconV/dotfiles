#!/bin/zsh
# CPU usage averaged across cores
ncpu=$(sysctl -n hw.ncpu)
pct=$(ps -A -o %cpu= | awk -v n=$ncpu '{s+=$1} END {printf "%d", s/n}')
printf 'CPU %s%%' $pct
