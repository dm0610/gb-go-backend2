#!/bin/bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.43.0 
find $GITHUB_WORKSPACE/  -name "go.mod" | find $PWD -name "go.mod" | rev |cut -c7- | rev > gomods
cat gomods | while read line 
do
   export APP_DB_USERNAME=techuser
   export APP_DB_PASSWORD=techuser
   export APP_DB_NAME=products
   export TEST_DB_USERNAME=$APP_DB_USERNAME
   export TEST_DB_PASSWORD=$APP_DB_PASSWORD
   export TEST_DB_NAME=$APP_DB_NAME
   export MY_PATH=$line 
   cd $MY_PATH  && go test .
done
