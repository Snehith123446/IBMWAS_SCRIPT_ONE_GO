AdminTask.createSIBJMSConnectionFactory('cluster-001(cells/localhostCell01/clusters/cluster-001|cluster.xml)', '[-type queue -name qcf -jndiName jndi/qcf -description -category -busName BUS01 -nonPersistentMapping ExpressNonPersistent -readAhead Default -tempQueueNamePrefix -target -targetType BusMember -targetSignificance Preferred -targetTransportChain -providerEndPoints -connectionProximity Bus -authDataAlias -containerAuthAlias -mappingAlias -shareDataSourceWithCMP false -logMissingTransactionContext false -manageCachedHandles false -xaRecoveryAuthAlias -persistentMapping ReliablePersistent -consumerDoesNotModifyPayloadAfterGet false -producerDoesNotModifyPayloadAfterSet false]')
AdminTask.createSIBJMSQueue('cluster-001(cells/localhostCell01/clusters/cluster-001|cluster.xml)', '[-name queue -jndiName jms/queue -description -deliveryMode Application -readAhead AsConnection -busName BUS01 -queueName _SYSTEM.Exception.Destination.cluster.000-BUS01 -scopeToLocalQP false -producerBind false -producerPreferLocal true -gatherMessages false]') 
AdminConfig.save()
AdminConfig.reset()
