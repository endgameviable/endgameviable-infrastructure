eval "$(<.env)"
aws cloudformation update-stack --stack-name $STACKNAME --template-body file://./templates/resources.yaml --capabilities CAPABILITY_IAM --profile default
