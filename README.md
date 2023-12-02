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

If necessary:

```
# Update CloudFormation stack
./updatestack.sh

# Delete CloudFormation stack
./deletestack.sh
```

Ensure default AWS credentials (`~/.aws/credentials`) have permission to run `aws cloudformation`.

To trigger the content build pipeline, e.g.:

```
aws codepipeline start-pipeline-execution --name endgameviable2024-contentPipeline-xxx
```

(Get the pipeline name from the AWS Console.)
