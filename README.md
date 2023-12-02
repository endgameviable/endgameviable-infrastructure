Repeatable steps to build endgameviable2024 infrastructure on AWS.

Was originally going to use Terraform but ended up trying a CloudFormation template. Might still go to terraform someday,
because then I could (theoretically) build the tech stack on AWS,
Google Cloud, or Azure.

I'm currently using AWS Amplify to host the Next.js application,
which unfortunately cannot be scripted into a template and has
to be setup manually. That also means I can't setup the CloudFront
distribution manually either, because it needs the Amplify domain.

```
# Install aws-cli tools
brew install awscli

# Validate CloudFormation template
./validate.sh

# Create CloudFormation stack.
# Creates the aws resources needed for the rest of the services.
./createstack.sh
```

If necessary, during development:

```
# Update CloudFormation stack after changing the template
./updatestack.sh

# Delete CloudFormation stack if you need to start over
./deletestack.sh
```

Don't forget, after deleting and re-creating a stack, you'll have to update the service role in Amplify, and the logging bucket in any CloudFront distributions.

TODO: It occurs to me that I should have different stacks for long-term resources like log buckets and service roles, versus ephemeral resources like build pipelines and data buckets.

Ensure default AWS credentials (`~/.aws/credentials`) have permission to run `aws cloudformation`.

To trigger the content build pipeline, e.g.:

```
aws codepipeline start-pipeline-execution --name endgameviable2024-contentPipeline-xxx
```

(Get the pipeline name from the AWS Console.)

## Manual Deployment Steps

After creating the CloudFormation stack, in the AWS Console:

### Create an IAM role to access resources from server-side runtime

Export credentials to be set as environment variables in the Amplify app.

TODO: Want to create this user in the CloudFormation template, but will still have to export credentials manually I imagine.

### Create an Amplify application

Has to be done manually, boo :(

Select `amplifyServiceRole` from the CloudFormation resource stack as the service account.

Set environment variables manually:

- EGV_RUNTIME_ACCESS_KEY_ID
- EGV_RUNTIME_SECRET_ACCESS_KEY
- EGV_USER_MASTODON_API_TOKEN
- EGV_USER_FILE_CONCURRENCY (if needed, default is 100)
- NEXT_PUBLIC_COMMENTBOX_APPID (if needed, will be exposed to browser)

### Create a Certificate

Used for the CloudFront distribution

### Create a CloudFront distribution

Select the Amplify domain as the origin.

Select the log bucket from the resource stack as the logging destination.

### Create an A domain record

nextjs.endgameviable.com -> cloudfront distribution domain

### Query access logs with Athena

Query access logs in Athena by creating a table that uses the CloudFront logs as a data source. (You have to setup yet another S3 bucket first for Athena query results.)

From https://docs.aws.amazon.com/athena/latest/ug/cloudfront-logs.html

```
CREATE EXTERNAL TABLE IF NOT EXISTS default.cloudfront_logs (
  `date` DATE,
  time STRING,
  x_edge_location STRING,
  sc_bytes BIGINT,
  c_ip STRING,
  cs_method STRING,
  cs_host STRING,
  cs_uri_stem STRING,
  sc_status INT,
  cs_referrer STRING,
  cs_user_agent STRING,
  cs_uri_query STRING,
  cs_cookie STRING,
  x_edge_result_type STRING,
  x_edge_request_id STRING,
  x_host_header STRING,
  cs_protocol STRING,
  cs_bytes BIGINT,
  time_taken FLOAT,
  x_forwarded_for STRING,
  ssl_protocol STRING,
  ssl_cipher STRING,
  x_edge_response_result_type STRING,
  cs_protocol_version STRING,
  fle_status STRING,
  fle_encrypted_fields INT,
  c_port INT,
  time_to_first_byte FLOAT,
  x_edge_detailed_result_type STRING,
  sc_content_type STRING,
  sc_content_len BIGINT,
  sc_range_start BIGINT,
  sc_range_end BIGINT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
LOCATION 's3://endgameviable2024-resources-logbucket-1gpiueyiotnlz/cloudwatch/'
TBLPROPERTIES ( 'skip.header.line.count'='2' )
```

Replace the LOCATION with the actual bucket name from the CloudFormation resource stack.

Query recent logs with e.g.:

```
SELECT "date", "time", sc_status, cs_method, cs_bytes, cs_uri_stem, cs_uri_query
FROM cloudfront_logs 
WHERE NOT starts_with(cs_uri_stem, '/_next')
LIMIT 20;
```

It seems to order by timestamp descending by default, yay.

Fyi rows matching `starts_with(cs_uri_query, '_rsc')` are Next.js prefetch queries, not humans actually clicking on links. See https://nextjs.org/docs/app/api-reference/components/link#prefetch. I don't really see the advantage of prefetching for a blog site, so I don't use the `<Link>` components.

