eval "$(<.env)"
echo EGV_RESOURCE_EVENT_QUEUE=$(aws cloudformation describe-stacks --stack-name $STACKNAME --output text | grep EventQueue | awk '{print $NF}')
echo EGV_RESOURCE_JSON_BUCKET=$(aws cloudformation describe-stacks --stack-name $STACKNAME --output text | grep JSONBucket | awk '{print $NF}')
echo EGV_RESOURCE_SEARCH_TABLE=$(aws cloudformation describe-stacks --stack-name $STACKNAME --output text | grep SearchTable | awk '{print $NF}')
echo EGV_RESOURCE_STATE_TABLE=$(aws cloudformation describe-stacks --stack-name $STACKNAME --output text | grep StateTable | awk '{print $NF}')
