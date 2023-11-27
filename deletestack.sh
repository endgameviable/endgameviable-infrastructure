# cloudformation won't delete non-empty buckets
# have to manually put in the names of the actual buckets here sigh
aws s3 rm s3://endgameviable2024-artifactbucket-bvaucfwqkfaq --recursive --quiet
aws s3 rm s3://endgameviable2024-jsonbucket-c5f3mhhfyhxk --recursive --quiet
aws s3 rm s3://endgameviable2024-markdownbucket-5vhsvo8ncpg8 --recursive --quiet
aws cloudformation delete-stack --stack-name endgameviable2024 --profile default
