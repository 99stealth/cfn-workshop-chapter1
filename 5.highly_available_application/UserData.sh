#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum install git golang -y
if [ $? == 0 ]; then
    echo "Packages installed successfully"
else
    echo "Package installation is failed"
fi

git clone https://github.com/99stealth/cfn-workshop-backend.git
if [ $? == 0 ]; then
    echo "Repository cloned successfully"
else
    echo "Repository clone is failed"
fi

cd cfn-workshop-backend

export GOPATH=/cfn-workshop-backend
export GOCACHE=/cfn-workshop-backend

go get github.com/go-sql-driver/mysql
go get github.com/gorilla/mux

go build -o cfn-workshop-backend-server
if [ $? == 0 ]; then
    echo "Application has been successfully built"
else
    echo "Application build is failed"
fi

./cfn-workshop-backend-server &