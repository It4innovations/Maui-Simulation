#!/bin/bash
function block() { until showstats --host=$HOST --port=$PORT 2>/dev/null > /dev/null; do sleep 1; done }
function clear_node() {
  JOB=$(checknode --host=$HOST --port=$PORT $1 | sed -n 's/JobList:[\t ]\+\([0-9]\+\)/\1/p')
  if [ ! -z $JOB ]
  then
    echo "Removed job $JOB from node $1"
    canceljob --host=$HOST --port=$PORT $JOB
  fi
}
sim_start=$(showstats -v --port=$PORT | sed -n 's/current.*(\([0-9]\+\))/\1/p')
off=$((($sim_start - 1486539500) / 5 - 1)) # Align to simulation time step
echo "Simulation: 5 1486539500 $sim_start $off"
setres --host=$HOST --port=$PORT -s 09:00:00_02/21/2017 -d 29880 ALL # 1487667600
schedctl --host=$HOST --port=$PORT -s $((2449-$off))I # 1486551471
block
clear_node r2i4n3
setres --host=$HOST --port=$PORT -s 10:57:51_02/08/2017 -n ^r2i4n3$ ^r2i4n3$ # 1486551471
schedctl --host=$HOST --port=$PORT -s $((2620-$off))I # 1486552326
block
releaseres --host=$HOST --port=$PORT ^r2i4n3$.0
schedctl --host=$HOST --port=$PORT -s $((3382-$off))I # 1486556136
block
# continue...
