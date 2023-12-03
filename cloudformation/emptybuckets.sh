# CloudFormation won't delete non-empty buckets.
# Be careful with this, it just deletes them no questions asked.
# But since we have these scripts to recreate everything from scratch,
# it wouldn't be a big loss anyway.
if [ $# -eq 0 ]; then
  echo "Usage: $0 <prefix>"
  exit 1
fi

echo "Listing buckets"
aws s3api list-buckets --query "Buckets[?starts_with(Name, '$1')].Name" --output text | tr '\t' '\n' | while read -r bucket_name; do
  echo "Going to empty the bucket $bucket_name"
done
echo "Okay to empty those buckets? ^C now if not."
read

aws s3api list-buckets --query "Buckets[?starts_with(Name, '$1')].Name" --output text | tr '\t' '\n' | while read -r bucket_name; do
  echo "Emptying $bucket_name"
  #aws s3 rm s3://$bucket_name --recursive --quiet
done
