#!/bin/bash

set -e
source setWasEnv.sh

adminUserName=wasadmin    ##Admin  username 
adminPassword=sarasu10    ##Admin  password
DmgrProfileName=Dmgr01
incr=2
profilesList=$(${WAS_HOME}/bin/manageprofiles.sh -listProfiles)
profilesArray=', ' read -r -a profileArray <<< $(echo "$profilesList" | grep -oP '\[\K[^]]*' | awk -v RS=',' '{print $1}')
 	  

while true; do
    for name in "${profileArray[@]}"; do
        if [ "${name}" == "${DmgrProfileName}" ]; then
            DmgrProfileName="Dmgr${incr}"
            incr=$((incr + 1))
        fi
    done
    break
done
#Creation of Dmgr profile
${WAS_HOME}/bin/manageprofiles.sh -create  -profileName "${DmgrProfileName}" -templatePath ../profileTemplates/dmgr/ -enableAdminSecurity true -adminUserName "${adminUserName}" -adminPassword "${adminPassword}" -hostName "${hostname}"

#soapPort=8879
SOAP_PORT=$(grep -oP 'Management SOAP connector port: \K\d+' "${WAS_HOME}"/profiles/${DmgrProfileName}/logs/AboutThisProfile.txt)


: '
#creation of AppServer Profile
${WAS_HOME}/bin/manageprofiles.sh -create  -templatePath ../profileTemplates/default/ -enableAdminSecurity true -adminUserName "${adminUserName}" -adminPassword "${adminPassword}" -hostName "${hostname}"

##starting the Dmgr profile
${WAS_HOME}/profiles/Dmgr01/bin/startManager.sh

#Federating the Appserver profile To Dmgr profile
${WAS_HOME}/profiles/AppSrv01/bin/addNode.sh "${hostname}" "${soapPort}" -username "${adminUserName}"  -password "${adminPassword}"
'
