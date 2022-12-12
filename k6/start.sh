#!/bin/sh
# K6_PROMETHEUS_RW_TREND_STATS="avg,min,med,max,p(90),p(95)" 
# K6_PROMETHEUS_RW_TREND_STATS="max" 
K6_EXEC_PATH=/Users/jack/workspaces/kubeops/demoandpoc/k6/k6
TESTID=$(date '+%Y%m%d%H%M%S')
_INTERVAL=${INTERVAL-60}
while true
do
    $K6_EXEC_PATH run -q -i 1 /teset/test.js -o xk6-prometheus-rw --tag pronoea=true --tag testid=$TESTID $@
    echo "sleep ${_INTERVAL} ....."
    sleep $_INTERVAL
done
