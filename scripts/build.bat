@echo off

rem apollo config db info
set apollo_config_db_url="jdbc:mysql://192.168.6.225:3306/ApolloConfigDB?characterEncoding=utf8"
set apollo_config_db_username="root"
set apollo_config_db_password="123456"

rem apollo portal db info
set apollo_portal_db_url="jdbc:mysql://192.168.6.225:3306/ApolloPortalDB?characterEncoding=utf8"
set apollo_portal_db_username="root"
set apollo_portal_db_password="123456"

rem apollo config db info
rem set apollo_config_db_url="jdbc:mysql://rm-wz9l3xdq1skwrh5b8.mysql.rds.aliyuncs.com:3306/ApolloConfigDB?characterEncoding=utf8"
rem set apollo_config_db_username="leon"
rem set apollo_config_db_password="Frxs123s5$"

rem apollo portal db info
rem set apollo_portal_db_url="jdbc:mysql://rm-wz9l3xdq1skwrh5b8.mysql.rds.aliyuncs.com:3306/ApolloPortalDB?characterEncoding=utf8"
rem set apollo_portal_db_username="leon"
rem set apollo_portal_db_password="Frxs123s5$"

rem apollo config db info
rem set apollo_config_db_url="jdbc:mysql://rm-wz9nmhre7dedw83hx.mysql.rds.aliyuncs.com:3306/ApolloConfigDB?characterEncoding=utf8"
rem set apollo_config_db_username="frxsleon123"
rem set apollo_config_db_password="Frxs@yx4Java-2018"

rem apollo portal db info
rem set apollo_portal_db_url="jdbc:mysql://rm-wz9nmhre7dedw83hx.mysql.rds.aliyuncs.com:3306/ApolloPortalDB?characterEncoding=utf8"
rem set apollo_portal_db_username="frxsleon123"
rem set apollo_portal_db_password="Frxs@yx4Java-2018"

rem meta server url, different environments should have different meta server addresses
set dev_meta="http://192.168.6.221:8112"
set fat_meta="http://someIp:8112"
set uat_meta="http://172.18.61.148:8112"
set pro_meta="http://10.168.1.115"

set META_SERVERS_OPTS=-Ddev_meta=%dev_meta% -Dfat_meta=%fat_meta% -Duat_meta=%uat_meta% -Dpro_meta=%pro_meta%

rem =============== Please do not modify the following content =============== 
rem go to script directory
cd "%~dp0"

cd ..

rem package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

call mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=%apollo_config_db_url% -Dspring_datasource_username=%apollo_config_db_username% -Dspring_datasource_password=%apollo_config_db_password%

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

call mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=%apollo_portal_db_url% -Dspring_datasource_username=%apollo_portal_db_username% -Dspring_datasource_password=%apollo_portal_db_password% %META_SERVERS_OPTS%

echo "==== building portal finished ===="

pause
