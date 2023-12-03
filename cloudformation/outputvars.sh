STACKNAME=endgameviable231203
echo EGV_RESOURCE_EVENT_QUEUE=$(aws cloudformation describe-stacks --stack-name $STACKNAME-resource --output text | grep EventQueue | awk '{print $NF}') > .env.local
echo EGV_RESOURCE_STATE_TABLE=$(aws cloudformation describe-stacks --stack-name $STACKNAME-resource --output text | grep StateTable | awk '{print $NF}') >> .env.local
echo EGV_RESOURCE_JSON_BUCKET=$(aws cloudformation describe-stacks --stack-name $STACKNAME-build --output text | grep JSONBucket | awk '{print $NF}') >> .env.local
echo EGV_RESOURCE_SEARCH_TABLE=$(aws cloudformation describe-stacks --stack-name $STACKNAME-build --output text | grep SearchTable | awk '{print $NF}') >> .env.local
cat .env.local
