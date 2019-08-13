# Deploy your first EC2 instance with CloudFormation
Currently in the `ec2-instance.yaml` template we use `ami-035b3c7efe6d061d5` AMI which exists only in `us-east-1` region. 

In order to get newest AMI image for your EC2 instance in your default region run next command in your terminal:
```
aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn-ami-hvm-????.??.?.????????-x86_64-gp2' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
```
In the output you got the AMI ID which you may use in your CloudFormation template to deploy your EC2 instance

In case you want to get AMI for different region just specify `--region` flag in our command. For example, if you want to get AMI for `us-west-1` (N. California) just run:
```
aws ec2 describe-images --region us-west-1 --owners amazon --filters 'Name=name,Values=amzn-ami-hvm-????.??.?.????????-x86_64-gp2' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
```