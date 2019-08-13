# CloudFormation for CloudFormation purposes

As you already know using S3 as a storage for your CFn templates is a good practice since you cannot upload template with size more than `51,200 bytes` using CLI or API (more details you can find [HERE](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-console-create-stack-template.html)). So let's create your first resource with CloudFormation.

## Enough borring talks, let's deploy :rocket:
Try to deploy template `s3_for_cfn_templates.yaml`. If you don't know how to do that then use next tips:
- Go to your `AWS Console`
- Find CloudFormation in `Services` list and go to it
- Press `Create stack` button
- Switch radio button to `Upload a template file` in Specify template block and press `Choose file` button
- Find template on your computer and press `Next`
- Specify `Stack name`, it may be anything you would like. For example, `s3-for-cloud-formation-templates`. Press `Next`
- And press `Next` again
- Press `Create stack`

## Looks like you have a problem :grimacing:
Looks like your deployment has been failed. Ok let's make some change:
Change line `5`:
```yaml
      BucketName: cfn-templates
```
To:
```yaml
      BucketName: !Sub '${AWS::AccountId}-cfn-templates'
```
Delete old stack from CloudFormation and start procedure again

## Verification
Now when your stack in `CREATE_COMPLETE` status you may go to S3 service and check the name of your new S3 bucket

## Conclusions
- Try to understand what has actually happened
- Now you need to understand what are:
  - Pseudo functions
  - Intrinsic functions
  - Condition functions

