#!/bin/bash
source setWasEnv.sh
source ./setUpValues.txt
soapPort=${soap}
adminUserName=${adminUserName}
adminPassword=${adminPassword}
hostname=${hostname}

path=${1}

${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "${hostname}" -port "${soapPort}" -username "${adminUserName}" -password "${adminPassword}"  -f ${path}
