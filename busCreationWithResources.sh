#!/bin/sh

#busname=Bus
#dmgrNodeName=localhostCellManager01
#cellName=localhostCell01
set -e
source ./jmsSetUp.txt

echo "AdminTask.createSIBus('[-bus $busname -busSecurity true -scriptCompatibility 6.1 ]')" > ./JMS/busCreation.py
echo "AdminTask.getSecurityDomainForResource('[-resourceName SIBus=$busname -getEffectiveDomain false]')" >> ./JMS/busCreation.py
echo "AdminTask.modifySIBus('[-bus $busname -busSecurity true -permittedChains SSL_ENABLED ]')" >> ./JMS/busCreation.py
echo "AdminTask.listSIBuses()" >> ./JMS/busCreation.py
echo "AdminConfig.save()" >> ./JMS/busCreation.py
echo "AdminConfig.reset()" >> ./JMS/busCreation.py
echo "AdminTask.listSIBuses()" >> JMS/busMembers.py
#echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=$dmgrNodeName,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=$cellName,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> busCreation.py

./connectWsadmin.sh ./JMS/busCreation.py

#clusterName=cluster
#logDirectoryPath=/was9/
#permanentStoreDirectoryPath=/was9/
#temporaryStoreDirectory=/was9/




echo "AdminTask.addSIBusMember('[-bus $busname -cluster $clusterName -enableAssistance true -policyName HA -fileStore -logSize 100 -logDirectory $logDirectoryPath -minPermanentStoreSize 200 -maxPermanentStoreSize 500 -unlimitedPermanentStoreSize false -permanentStoreDirectory $permanentStoreDirectoryPath -minTemporaryStoreSize 200 -maxTemporaryStoreSize 500 -unlimitedTemporaryStoreSize false -temporaryStoreDirectory $temporaryStoreDirectory ]')" > JMS/busMembers.py
echo "AdminConfig.save()" >> JMS/busMembers.py
echo "AdminConfig.reset()"  >> JMS/busMembers.py
echo "AdminTask.listSIBuses()" >> JMS/busMembers.py
./connectWsadmin.sh JMS/busMembers.py

#clusterName=cluster
#connectionFactoryName=connectionFactory
#jndiName=Jms/cf
#busname=Bus
echo "AdminTask.createSIBJMSConnectionFactory('$clusterName(cells/$cellName/clusters/$clusterName|cluster.xml)', '[-type queue -name $connectionFactoryName -jndiName $jndiName -description -category -busName $busname -nonPersistentMapping ExpressNonPersistent -readAhead Default -tempQueueNamePrefix -target -targetType BusMember -targetSignificance Preferred -targetTransportChain -providerEndPoints -connectionProximity Bus -authDataAlias -containerAuthAlias -mappingAlias -shareDataSourceWithCMP false -logMissingTransactionContext false -manageCachedHandles false -xaRecoveryAuthAlias -persistentMapping ReliablePersistent -consumerDoesNotModifyPayloadAfterGet false -producerDoesNotModifyPayloadAfterSet false]')" > ./JMS/jmsResource.py

#queueJNDI=Jms/q
echo "AdminTask.createSIBJMSQueue('$clusterName(cells/$cellName/clusters/$clusterName|cluster.xml)', '[-name queue -jndiName $queueJNDI -description -deliveryMode Application -readAhead AsConnection -busName $busname -queueName _SYSTEM.Exception.Destination.cluster.000-$busname -scopeToLocalQP false -producerBind false -producerPreferLocal true -gatherMessages false]') " >> ./JMS/jmsResource.py
echo "AdminConfig.save()" >> ./JMS/jmsResource.py
echo "AdminConfig.reset()" >> ./JMS/jmsResource.py
#echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=$dmgrNodeName,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=$cellName,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> jmsResource.py 
./connectWsadmin.sh ./JMS/jmsResource.py

