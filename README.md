# xpoint-task
## Task
### Create CloudFormation templates for:
 1. A LaunchTemplate
    * Use a t3.micro instance size
 3. ASG that uses the launch template

### Create a script that takes a -n & -s or -h parameter
 1. The -h parameter should emit a useful help message
 2. The -n parameter is a base name to use for the created artifacts
 3. The -s parameter should set the number of instances on the ASG

For example, passing “awesome” as the name parameter should create an ASG with a name like “awesome-ASG” You may use any language to write the script.

## Solution
You Can directly open `CloudFormation` folder and run the following
```
cd CloudFormation
./cf-asg.sh -n awesome -s 2
aws cloudformation create-stack --stack-name awesome-stack --template-body file://awesome_launch_template.json
aws cloudformation create-stack --stack-name awesome-asg-stack --template-body file://awesome_asg_template.json
```

## Bonus
