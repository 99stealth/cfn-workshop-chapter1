# RDS instance with MySQL
Let's imagine that you got a CloudFormation template with hardcoded values. It means that you are not able to reuse it again if you decide to create another DB with the same template.

In this chapter you will do everything without any instruction.

## Follow-up activities
1. Databases are most critical infrastructure elements, so you should preserve data loss:
    - Need to provide possibility to make a snapshot after stack (and also DB) removal
2. Need to provide posibility to reuse the template, therefore, you need to provide such `Parameters` as:
    - MasterUsername
    - MasterUserPassword (Should not be visible)
    - AllocatedStorage
    - CIDRIP (Should allow to pass only CIDR in format `x.x.x.x/x`)
    - EngineVersion (Only versions which are available on AWS)
    - DBInstanceClass (Up to 5 allowed instance types)
    - DBName
    - Add at least one more from https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html#cfn-rds-dbinstance-dbsecuritygroups
3. Need to provide `Outputs` for further convenience:
    - RDS instance connection string like `mysql -u root -h 127.0.0.1 -p`, but with instance name instead `127.0.0.1`