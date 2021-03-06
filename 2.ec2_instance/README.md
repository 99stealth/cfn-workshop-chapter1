# Deploy your first EC2 instance with CloudFormation

Open the `ec2-instance.yaml` and check how it looks like. Yes, that's enough for deploying single EC2 instance. So, let's do. I hope you remember how to do that.
_________________
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
In order to get AMI IDs for all regions run next code snippet in your terminal
```
for aws_region in us-east-1 us-east-2 us-west-1 us-west-2 eu-west-1 eu-west-2 eu-west-3 eu-central-1 eu-north-1 ap-northeast-2 ap-northeast-1 ap-southeast-2 ap-southeast-1 ca-central-1 ap-south-1 sa-east-1; do image_id=$(aws ec2 describe-images --region $aws_region --owners amazon --filters 'Name=name,Values=amzn-ami-hvm-????.??.?.????????-x86_64-gp2' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'); echo $aws_region $image_id; done
```
_________________
## Let's check the instance
Now when your stack in `CREATE_COMPLETE` status go to `EC2` console and check that your instance is on its place.
Now when instance is created you may find its IP address and try to connect to it. Ah, hold on, but you don't have a `ssh key`.

## Let's fix the SSH Key issue and work with Parameters in the meantime
1. You need to have already existing SSH key
2. Now open `ec2-instance.yaml` and add `Parameters` section with next content on the top of template
```yaml
  SSHKey:
    Type: AWS::EC2::KeyPair::KeyName
    Description: Choose a SSH key from the list of your keys
    ConstraintDescription: This field cannot be empty
```
3. Also, you need to specify where you want to use parameter `SSHKey`. In our case we use it with single instance. So, add next line to the end of `EC2Instance` resource
```yaml
      KeyName: !Ref SSHKey
```
4. Now you can update CloudFormation stack. 
   - Go to CloudFormation console
   - Choose stack and press `Update` button
   - Find the `ec2-instance.yaml` template on your computer
   - Go Next -> Next -> Next... :)
5. If you see status `UPDATE_COMPLETE` then you can go to the EC2 console, get instance IP address and try to connect to an instance via SSH.

## Follow-up activities
1. Check other parameters which you can use with [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-instance.html) resource
2. Add UserData to your instance which will install
   - git
   - golang
   - htop
3. Add Parameter which will allow you to choose `InstanceType` between `t2.micro, t2.small, t3.micro, t2.small`
4. Add Parameter which will allow you to choose VPC and Subnet where to deploy an instance
5. Add `Mapping` section with AMI maps for each AWS Region.