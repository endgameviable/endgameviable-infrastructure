eval "$(<.env)"
aws cloudformation update-stack --stack-name $STACKNAME --template-body file://./templates/backend.yaml --capabilities CAPABILITY_IAM --profile default
