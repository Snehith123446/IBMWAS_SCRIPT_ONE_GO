#!/bin/bash
set -e
source ./setUpValues.txt

#Enter the name of the cluster
clusterName=cluster-001

clusterName=cluster-001 >> jmsSetUp.txt
#Enter the cluster member name on the first node
clusterMember01=clusNode1-JVM-

#Enter the cluster member name on the seci node
clusterMember02=ClusNode2-JVM-

#Enter no of servers needed on each node
noOfServersOnEachNode=2

incr=1
echo "AdminTask.createCluster('[-clusterConfig [-clusterName $clusterName -preferLocal true]]')" > clusterCreation.py
echo "AdminConfig.save()" >> clusterCreation.py
echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=localhostCellManager01,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=localhostCell01,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> clusterCreation.py
##Creating First member 
echo "AdminConfig.save()" >> clusterCreation.py
echo "AdminTask.createClusterMember('[-clusterName $clusterName -memberConfig [-memberNode $node1 -memberName $clusterMember01"${incr}" -memberWeight 2 -genUniquePorts true -replicatorEntry false] -firstMember [-templateName default -nodeGroup DefaultNodeGroup -coreGroup DefaultCoreGroup -resourcesScope cluster]]')" >> clusterCreation.py
echo "AdminConfig.save()" >> clusterCreation.py
while [ $noOfServersOnEachNode -ge $incr ]
do

if [ $incr != 1 ] 
then
	echo "AdminTask.createClusterMember('[-clusterName $clusterName -memberConfig [-memberNode $node1 -memberName $clusterMember01"${incr}" -memberWeight 2 -genUniquePorts true -replicatorEntry false]]')" >> clusterCreation.py
echo "AdminConfig.save()" >> clusterCreation.py
fi

echo "AdminTask.createClusterMember('[-clusterName $clusterName -memberConfig [-memberNode $node2 -memberName $clusterMember02"${incr}" -memberWeight 2 -genUniquePorts true -replicatorEntry false]]')" >> clusterCreation.py

echo "AdminConfig.save()" >> clusterCreation.py
echo "AdminConfig.reset()" >> clusterCreation.py
incr=`expr $incr + 1`
done


##starting the servers which are on the cluster

echo "AdminClusterManagement.startSingleCluster(\"${clusterName}\")" >> clusterCreation.py

./connectWsadmin.sh clusterCreation.py                                                      
