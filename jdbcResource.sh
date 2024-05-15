#!/bin/sh
set -e
source ./JDBC/jdbc.txt

#J2C authentication
#db2username=db2inst1
#db2password=sarasu10
echo "AdminTask.createAuthDataEntry('[-alias DB2Alias -user $db2username -password $db2password -description "db2 configuration"]')" > ./JDBC/j2Cauthentication.py
echo "AdminConfig.save()" >> ./JDBC/j2Cauthentication.py
./connectWsadmin.sh ./JDBC/j2Cauthentication.py


#Creating JDBC provider

#clusterName=cluster
#Enter the classpath for db2jcc.jar and db2jcc_license_cu.jar file
#db2jcc=/was9/db2jcc.jar
#db2jcc_license_cu=/was9/db2jcc_license_cu.jar
#Enter the native path(Installation path) of db2
#nativePath=/opt/ibm/db2/V11.1
echo "AdminTask.createJDBCProvider('[-scope Cluster=$clusterName \
-databaseType DB2 \
-providerType \"DB2 Universal JDBC Driver Provider\" \
-implementationType \"Connection pool data source\" \
-name \"DB2 Universal JDBC Driver Provider\" \
-description \"One-phase commit DB2 JCC provider that supports JDBC 3.0. Data sources that use this provider support only 1-phase commit processing, unless you use driver type 2 with the application server for z/OS. If you use the application server for z/OS, driver type 2 uses RRS and supports 2-phase commit processing.\" \
-classpath [$db2jcc $db2jcc_license_cu] \
-nativePath [$nativePath] \
]')" > ./JDBC/jdbcResource.py
echo "AdminConfig.save()" >> ./JDBC/jdbcResource.py
./connectWsadmin.sh ./JDBC/jdbcResource.py

#Creating data source with existing JDBC Driver

echo "print AdminConfig.list('JDBCProvider', AdminConfig.getid( '/Cell:localhostCell01/'))" > ./JDBC/providerList.py
#echo "print(AdminConfig.list('JDBCProvider', AdminConfig.getid( '/Cell:localhostCell01/ServerCluster:cluster/')))" > providerList.py
./connectWsadmin.sh ./JDBC/providerList.py | grep "DB2 Universal JDBC Driver Provider" > ./JDBC/providerList.txt 
jdbc_provider_name=$(<./JDBC/providerList.txt)


echo $jdbc_provider_name


echo "AdminTask.createDatasource('$jdbc_provider_name', '[-name "${name}" -jndiName "${dataJndi}" -dataStoreHelperClassName com.ibm.websphere.rsadapter.DB2UniversalDataStoreHelper -containerManagedPersistence true -componentManagedAuthenticationAlias localhostCellManager01/DB2Alias -configureResourceProperties [[databaseName java.lang.String "${databaseName}"] [driverType java.lang.Integer 4] [serverName java.lang.String "${serverName}"] [portNumber java.lang.Integer "${portNumber}"]]]')" > ./JDBC/dataSource.py
echo "AdminConfig.save()" >> ./JDBC/dataSource.py
#echo "AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=$dmgrNodeName,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=$cellName,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')" >> ./JDBC/dataSource.py
./connectWsadmin.sh ./JDBC/dataSource.py
