eval "$(<.env)"
aws cloudformation delete-stack --stack-name $STACKNAME --profile default
echo "don't forget that the Amplify service role will also be deleted!"
