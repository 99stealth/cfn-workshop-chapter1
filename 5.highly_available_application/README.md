# Let's wrap it up
We already deployed such resources as:
- S3 Buckets
- EC2 Instance
- RDS Instance

But that's not enough for highly available applications.

![CFN Workshop Infrastructure](.img/infrastructure-overview.png)
Ok, let's pull all the stuff together and create something really great.

## Follow-up activities
There are two more repositories which are created for this workshop:
- [Golang backend application](https://github.com/99stealth/cfn-workshop-backend)
- [Frontend application](https://github.com/99stealth/cfn-workshop-frontend)

You are already familiar with a frontend application as you were working with it in `Chapter 3`.

Now your final task sounds like:
1. Create a RDS instance with MySQL (Actually you did that in `Chapter 4`)
2. Create a S3 Bucket in a Web Hosting mode (Actually you did that in `Chapter 3`)
3. Create a Classic LoadBalancer
4. Instead of single EC2 instance which you were creating in `Chapter 2` you need to create AutoScaling Group with at least 2 instances
5. Attach AutoScaling Group to LoadBalancer
6. Instances from AutoScaling group should have assigned Role which allows access to:
   - s3:GetObject
   - s3:DeleteObject
   - s3:PutObject
   - s3:ListBucket
7. When instance starts it should:
   -  Build Golang application and run it. Snippet of code which does it is [HERE](UserData.sh)   
   - Extend the UserData by checking that DB exists. If it does then nothing to do otherwise it should create DB `cfn_workshop` and table `user`
   - Extend the UserData by getting files from [Frontend application](https://github.com/99stealth/cfn-workshop-frontend). Change `127.0.0.1:8000` by LoadBalancer hostname and put them to S3 bucket.

8. Website's link should be available in the `Output` of stack

## How to verify that application works in a right way
1. Go to the web page and fill the form
2. If you didn't get any error then go to MySQL database and check if data you provided exists

## Congratulations :tada:
That's all. I hope you enjoyed the workshop. Feel free to fork it and please let me know if there is anything that you would like to change in this course.

Thank you!