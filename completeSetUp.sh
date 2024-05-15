#!/bin/bash
set -e

source ./setUpValues.txt 
##Creation of profile script

./profilesCreation.sh

#Federating the AppSrv profiles to the Dmgr 

./federation.sh


#Creating the servers 

./serverCreation.sh

#creation of cluster Env 

./clusterCreation.sh

#Deploying an JMS application

./applicationDeployment.sh

#Creating an jdbc data source

./jdbcResource.sh

#configuration of JMS BUS and Resource

./busCreationWithResources.sh


${WAS_HOME}/profiles/AppSrv01/bin/stopNode.sh -username ${adminUserName} -password ${adminPassword}
${WAS_HOME}/profiles/AppSrv01/bin/syncNode.sh ${hostname} ${soap} -username ${adminUserName} -password ${adminPassword}
${WAS_HOME}/profiles/AppSrv02/bin/stopNode.sh -username ${adminUserName} -password ${adminPassword}
${WAS_HOME}/profiles/AppSrv02/bin/syncNode.sh ${hostname} ${soap} -username ${adminUserName} -password ${adminPassword}


${WAS_HOME}/profiles/Dmgr01/bin/stopManager.sh -username ${adminUserName} -password ${adminPassword}
${WAS_HOME}/profiles/Dmgr01/bin/startManager.sh


${WAS_HOME}/profiles/AppSrv01/bin/startNode.sh
${WAS_HOME}/profiles/AppSrv02/bin/startNode.sh
