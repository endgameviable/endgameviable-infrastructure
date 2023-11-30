eval "$(<.env)"
aws cloudformation create-stack --stack-name $STACKNAME --template-body file://./endgameviable2024.yaml --capabilities CAPABILITY_IAM --profile default
echo "don't forget that you'll need to set the Amplify service role to the new one created!"
