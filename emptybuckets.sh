# CloudFormation won't delete non-empty buckets.
# Be careful with this, it just deletes them no questions asked.
# But since we have these scripts to recreate everything from scratch,
# it wouldn't be a big loss anyway.
eval "$(<.env)"
aws s3api list-buckets --output text | awk '{print $NF}' | grep ^$STACKNAME | while read -r bucket_name; do
  echo "About to empty the bucket $bucket_name"
  aws s3 rm s3://$bucket_name --recursive --quiet
done
