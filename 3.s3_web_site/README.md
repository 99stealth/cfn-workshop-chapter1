# Let's deploy Web Site hosting

## Constraints for parameters

You may have no `Parameters` if you are using CloudFormation only to make your life easier, but if you are working in the team then you need to parametrize templates. But what if your teammates are not really familiar with things which are going on inside the template during deployment process? For example, newcomers may not be familiar with naming convention in your infrastructure. In this chapter, we will overview now to defend conventions from human mistakes.

In the `s3-web-site.yaml` you can find the parameter `SiteName` which allows you to name the S3 bucket which is used for web page hosting. It is good practice to name S3 bucket in accordance to name which you want to assign to the website in Route53. So, let's preserve the template from mistakes. 

### Minimal lenght of a parameter
It is logical that the Full Qualified Domain Name (FQDN) lenght can't be shorter than 4 symbols, for example, `i.io` or `c.co`.
So, try to assign `MinLength` to `SiteName` parameter.
```yaml
    MinLength: 4
```
And add constraint description
```yaml
    ConstraintDescription: Name should be longer than 4 characters
```
Now try to deploy the template, and in `SiteName` field specify, for example, `i.a`.
```
Parameter SiteName failed to satisfy constraint: Name should be longer than 4 characters
```

### Allowed pattern of a parameter
Ok, let's imagine that in your company you need to create number of S3 hosted websites, like
```
example.com
www.example.com
my.example.com
staging.example.com
```
As you can see FQDN consists of three parts separated by dots. So, let's define `AllowedPattern` for the `SiteName` parameter:
```yaml
    AllowedPattern: (\w+(-?\w)*\.)+[\w]{2,}
```
And change `ConstraintDescription` to:
```yaml
ConstraintDescription: Name should be longer than 4 characters and an FQDN should be like example.com or www.example.com
```

## Output for convenience
Ok, you have created website, but what is the URL of the site? Let CloudFormation show it for you. Add the Output section:
```yaml
Outputs:
  WebsiteURL:
    Value: !GetAtt [S3BucketWeb, WebsiteURL]
    Description: URL for website hosted on S3
  S3BucketSecureURL:
    Value: !Join ['', ['https://', !GetAtt [S3BucketWeb, DomainName]]]
    Description: Name of S3 bucket to hold website content
```

## Upload a content to your website
In order to verify that everything was deployed successfully and website hosting works perfectly upload some web content there. Specially for this workshop I have created git repository with html/css content. Clone it by:
```
git clone git@github.com:99stealth/cfn-workshop-frontend.git
```
Go to the directory you cloned
```
cd cfn-workshop-frontend
```
Sync the content
```
aws s3 sync . s3://${BUCKET_NAME} --exclude ".git/*"
```

:clap: Now check your web site

## Follow-up activities
1. Parametrize `IndexDocument` and `ErrorDocument` using `AllowedPattern`
2. Add Parameter `Environment` with 3 allowed values `production`, `staging`, `development`. Add the environment to the beginning of the `BucketName`
3. Create `Fn::If` statement for development, staging, production environments
   - If `Environment` is `production` it should be reachable from anywhere
   - If `Environment` is `staging` it should be reachable only from your IP address
   - If `Environment` is `development` it should not be deployed at all
