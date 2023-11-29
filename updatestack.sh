eval "$(<.env)"
aws cloudformation update-stack --stack-name $STACKNAME --template-body file://./endgameviable2024.yaml --capabilities CAPABILITY_IAM --profile default
