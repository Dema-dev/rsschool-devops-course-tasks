# rsschool-devops-course-tasks

## Use IAM roles to connect GitHub Actions to actions in AWS

### Step 1: Create an OIDC provider in your account

To create an OIDC provider for GitHub (AWS CLI):
You can add GitHub as an IdP in your account with a single AWS CLI command. For the value —thumbprint-list, you will use the GitHub OIDC thumbprint d89e3bd43d5d909b47a18977aa9d5ce36cee184c.

```
aws iam create-open-id-connect-provider ‐‐url 
"https://token.actions.githubusercontent.com" ‐‐thumbprint-list 
"d89e3bd43d5d909b47a18977aa9d5ce36cee184c" ‐‐client-id-list 
'sts.amazonaws.com'
```

### Step 2: Create an IAM role and scope the trust policy

1. Create and save a JSON file with the example policy to your local computer with the file name trustpolicyforGitHubOIDC.json. Paste this information.

Allow your unique GitHub organization, repository, and branch to assume the role. This example trusts the GitHub organization _aws-samples_, the repository named _EXAMPLEREPO_, and the branch named _ExampleBranch_. Update the Federated ARN with the GitHub IdP ARN that you copied previously.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "<arn:aws:iam::111122223333:oidc-provider/token.actions.githubusercontent.com>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo: <aws-samples/EXAMPLEREPO>:ref:refs/heads/<ExampleBranch>",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```
You can get Federated ARN, using aws command - 

```
aws iam list-open-id-connect-providers
```
and it shows output like this

```
{
    "OpenIDConnectProviderList": [
        {
            "Arn": "arn:aws:iam::913524930772:oidc-provider/token.actions.githubusercontent.com"
        }
    ]
}
```

2. Run the following command to create the role

```
aws iam create-role --role-name GitHubAction-AssumeRoleWithAction --assume-role-policy-document file://C:\policies\trustpolicyforGitHubOIDC.json
```

### Step 3: Assign a minimum level of permissions to the role

For this example, you won’t add permissions to the IAM role, but will assume the role and call STS GetCallerIdentity to demonstrate a GitHub action that assumes the AWS role.

If you’re interested in performing additional actions in your account, you can add permissions to the role you created, GitHubAction-AssumeRoleWithAction. Common actions for workflows include calling AWS Lambda functions or pushing files to an Amazon Simple Storage Service (Amazon S3) bucket. For more information about using IAM to apply permissions, see Policies and permissions in IAM.

If you’d like to do a test, you can add permissions as outlined by these blog posts: Complete CI/CD with AWS CodeCommit, AWS CodeBuild, AWS CodeDeploy, and AWS CodePipeline or Techniques for writing least privilege IAM policies.

### Step 4: Create a GitHub action to invoke the AWS CLI

GitHub actions are defined as methods that you can use to automate, customize, and run your software development workflows in GitHub. The GitHub action that you create will authenticate into your account as the role that was created in Step 2: Create the IAM role and scope the trust policy.

To create a GitHub action to invoke the AWS CLI:

Create a basic workflow file, such as main.yml, in the .github/workflows directory of your repository. This sample workflow will assume the GitHubAction-AssumeRoleWithAction role, to perform the action aws sts get-caller-identity. Your repository can have multiple workflows, each performing different sets of tasks. After GitHub is authenticated to the role with the workflow, you can use AWS CLI commands in your account.

2. Paste the following example workflow into the file

```
# This is a basic workflow to help you get started with Actions
name: Connect to an AWS role from a GitHub repository

# Controls when the action will run. Invokes the workflow on push events but only for the main branch
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

env:
  
  AWS_REGION : "us-east-1" #Change to reflect your Region

# Permission can be added at job level or workflow level    
permissions:
      id-token: write   # This is required for requesting the JWT
      contents: read    # This is required for actions/checkout
jobs:
  AssumeRoleAndCallIdentity:
    runs-on: ubuntu-latest
    steps:
      - name: Git clone the repository
        uses: actions/checkout@v3
      - name: configure aws credentials
        uses: aws-actions/configure-aws-credentials@v1.7.0
        with:
          role-to-assume: arn:aws:iam::1111111111111:role/GithubActionsRole #change to reflect your IAM role’s ARN
          role-session-name: GitHub_to_AWS_via_FederatedOIDC
          aws-region: ${{ env.AWS_REGION }}
      # Hello from AWS: WhoAmI
      - name: Sts GetCallerIdentity
        run: |
          aws sts get-caller-identity
```

3. Modify the workflow to reflect your AWS account information:
AWS_REGION: Enter the AWS Region for your AWS resources.
role-to-assume: Replace the ARN with the ARN of the AWS GitHubAction role that you created previously.
In the example workflow, if there is a push or pull on the repository’s “main” branch, the action that you just created will be invoked.

After that push code and your github action starts work.


