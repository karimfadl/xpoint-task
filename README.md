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
We can improve this solution by using some automation tools, While our Cloudformation stack need AMI and Subnet, So we Can use Packer to create a special AMI and Terraform to create a VPC with subnet.
### Run Packer to Create a special AMI for our stack.
```
cd Packer
packer build packer-template.json
```
Copy AMI ID output and Add it in our Cloudformation stack json file.
### Run Terraform to create a new VPC with Subnets.
```
cd Terraform
terraform init
terraform plan
terraform apply
```
Copy Public subnet output and Add it in our Cloudformation stack json file.

