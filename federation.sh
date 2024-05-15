#!/bin/bash

set -e 

source ./setUpValues.txt


${WAS_HOME}/profiles/AppSrv01/bin/addNode.sh $hostname ${soap} -username $adminUserName -password $adminPassword
${WAS_HOME}/profiles/AppSrv02/bin/addNode.sh $hostname ${soap}  -username $adminUserName -password $adminPassword

