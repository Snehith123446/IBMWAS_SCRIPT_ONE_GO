#!/bin/bash

set -e

source application.txt

echo "AdminApp.install('$applicationPath', '[ -nopreCompileJSPs -distributeApp -nouseMetaDataFromBinary -nodeployejb -appname SendJmsMessageEar -createMBeansForResources -noreloadEnabled -nodeployws -validateinstall warn -noprocessEmbeddedConfig -filepermission .*\.dll=755#.*\.so=755#.*\.a=755#.*\.sl=755 -noallowDispatchRemoteInclude -noallowServiceRemoteInclude -asyncRequestDispatchType DISABLED -nouseAutoLink -noenableClientModule -clientMode isolated -novalidateSchema -MapModulesToServers [[ SendJmsMessage SendJmsMessage.war,WEB-INF/web.xml WebSphere:cell=$cellName,cluster=$clusterName ]] -MapWebModToVH [[ SendJmsMessage SendJmsMessage.war,WEB-INF/web.xml default_host ]]]' )" > Appjms.py
echo "AdminConfig.save()" >> Appjms.py
echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=$dmgrNodeName,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=$cellName,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> Appjms.py
./connectWsadmin.sh Appjms.py
echo "JMS application has been deployed on the cluster $clusterName"

