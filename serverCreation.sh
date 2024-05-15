#!/bin/bash
set -e

source setWasEnv.sh  #Taking global declared variables
source ./setUpValues.txt
noOfServers=2   ## Enter no of servers needed on each node 
incr=1
rm -rf ./servers.py
touch ./servers.py
while [ $noOfServers -ge $incr ] 
do 
echo "AdminTask.createApplicationServer('"${node1}"', '[-name JVM-1${incr} -templateName default -genUniquePorts true ]')" >> ./servers.py
echo "AdminConfig.save()" >> ./servers.py
echo "AdminTask.createApplicationServer('"${node2}"', '[-name JVM-2${incr} -templateName default -genUniquePorts true ]')" >> ./servers.py
echo "AdminConfig.save()" >> ./servers.py
incr=`expr $incr + 1`
done
echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node="${hostname}"CellManager01,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell="${hostname}"Cell01,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> ./servers.py
echo "AdminConfig.reset()" >> ./servers.py
./connectWsadmin.sh ./servers.py

