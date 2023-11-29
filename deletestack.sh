eval "$(<.env)"
aws cloudformation delete-stack --stack-name $STACKNAME --profile default
