#!/bin/bash


set -e
source ./setUpValues.txt


## If you want change the default values or assign any values update in the file ./setUpValues.txt file 


echo "Creating DMGR profile"
${WAS_HOME}/bin/manageprofiles.sh -create -templatePath ${WAS_HOME}/profileTemplates/dmgr/ -enableAdminSecurity true -adminUserName $adminUserName -adminPassword $adminPassword -hostName $hostname

echo "Creating AppSrv01 profile"
${WAS_HOME}/bin/manageprofiles.sh -create -templatePath ${WAS_HOME}/profileTemplates/default/ -enableAdminSecurity true -adminUserName $adminUserName -adminPassword $adminPassword -hostName $hostname

echo "Creating AppSrv02 profile"
${WAS_HOME}/bin/manageprofiles.sh -create -templatePath ${WAS_HOME}/profileTemplates/default/ -enableAdminSecurity true -adminUserName $adminUserName -adminPassword $adminPassword -hostName $hostname

echo "Starting the Dmgr profile manager"
${WAS_HOME}/profiles/Dmgr01/bin/startManager.sh 

if [ $? == 0 ]
then
	echo "Scuessfully completed excution of script"
fi
#echo "Federating Dmgr profile with AppSrv01 and AppSrv02"
#${WAS_HOME}/profiles/AppSrv01/bin/addNode.sh $hostName 8879 -username $adminUserName -password $adminPassword
#${WAS_HOME}/profiles/AppSrv02/bin/addNode.sh $hostName 8879 -username $adminUserName -password $adminPassword


##################################################################################################

#echo "Creation of servers"


