# Deploy your first EC2 instance with CloudFormation

Open the `ec2-instance.yaml` and check how it looks like. Yes, that's enough for deploying single EC2 instance. So, let's do. I hope you remember how to do that.

#### :warning: In case you need to use some other AMI or same AMI but in different region
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

## Let's check the instance
Now when your stack in `CREATE_COMPLETE` status go to `EC2` console and check that your instance is on its place.
Now when instance is created you may find its IP address and try to connect to it. Ah, hold on, but you don't have a `ssh key`.

## Let's work with Parameters
