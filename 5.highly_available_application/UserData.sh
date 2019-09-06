 #!/bin/bash -x
 exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
 yum install git golang mysql57 -y
 if [ $? == 0 ]; then
     echo "Packages installed successfully"
 else
     echo "Package installation is failed"
     exit 1
 fi
 git clone https://github.com/99stealth/cfn-workshop-backend.git
 if [ $? == 0 ]; then
     echo "Repository cloned successfully"
 else
     echo "Repository clone is failed"
     ecit 1
 fi
 cd cfn-workshop-backend
 mysql --user=${DbUser} -h ${DbHost} --password='${DbPasswd}' -e "SELECT 1 FROM cfn_workshop.user" 2>/dev/null || mysql --user=${DbUser} -h ${DbHost} --password='${DbPasswd}' < db_and_table.sql 2>/dev/null
 echo dbName=${DbName} > .env
 echo dbPort=${DbPort} >> .env 
 echo dbUser=${DbUser} >> .env
 echo dbPasswd=${DbPasswd} >> .env 
 echo dbHost=${DbHost} >> .env
 export GOPATH=/cfn-workshop-backend
 export GOCACHE=/cfn-workshop-backend
 go get github.com/go-sql-driver/mysql
 go get github.com/gorilla/mux
 go build -o cfn-workshop-backend-server
 if [ $? == 0 ]; then
     echo "Application has been successfully built"
 else
     echo "Application build is failed"
     exit 1
 fi
 ./cfn-workshop-backend-server &