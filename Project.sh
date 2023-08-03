#!/bin/bash
function InstallPackege() {
    local packageName=${1}
    apt-get install -y ${packageName}
    if [[ $? != 0 ]]
    then
        echo "apt-get ${packageName} not installed successfull"
        echo -e "\033[0;31m fail massege"
        exit 1
    fi
}
function mavenTarget() {
    local mavencommand=${1}
    mvn ${mavencommand}
    if [[ $? != 0 ]]
then 
    echo "{mavencommand} not run"
    echo -e "\033[0;31m fail massege"
    exit 1
fi
    
}
if [[ $UID != 0 ]] 
then
    echo "you are not a root user"
     echo -e "\033[0;31m fail massege"
     exit 1
fi

apt-get update
if [[ $? != 0 ]]
then
    echo "apt-get update not updated"
    echo -e "\033[0;31m fail massege"
    exit 1
fi

InstallPackege maven
InstallPackege tomcat9
mavenTarget test
mavenTarget packege

if cp -rf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war
if [[ $? == 0 ]]
then 
    echoi "file run successfully"
    echo -e "\033[0;32m success massege"
else 
    echo "file not run successfully"
    echo -e "\033[0;31m fail massege"
    exit 1
fi