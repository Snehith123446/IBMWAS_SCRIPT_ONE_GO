AdminTask.addSIBusMember('[-bus BUS01 -cluster cluster-001 -enableAssistance true -policyName HA -fileStore -logSize 100 -logDirectory /was9 -minPermanentStoreSize 200 -maxPermanentStoreSize 500 -unlimitedPermanentStoreSize false -permanentStoreDirectory /was9 -minTemporaryStoreSize 200 -maxTemporaryStoreSize 500 -unlimitedTemporaryStoreSize false -temporaryStoreDirectory /was9 ]')
AdminConfig.save()
AdminConfig.reset()
AdminTask.listSIBuses()
