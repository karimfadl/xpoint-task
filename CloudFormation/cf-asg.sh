#!/bin/bash

# Function to create a Launch Template CloudFormation template
generate_launch_template() {
    cat <<EOL > "${1}_launch_template.json"
{
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "${1}LaunchTemplate": {
            "Type": "AWS::EC2::LaunchTemplate",
            "Properties": {
                "LaunchTemplateName": "${1}-LaunchTemplate",
                "LaunchTemplateData": {
                    "InstanceType": "t3.micro",
                    "ImageId": "ami-06b21ccaeff8cd686"  # Replace with a suitable AMI ID for your region
                }
            }
        }
    }
}
EOL
}

# Function to create an ASG CloudFormation template
generate_asg_template() {
    cat <<EOL > "${1}_asg_template.json"
{
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "${1}AutoScalingGroup": {
            "Type": "AWS::AutoScaling::AutoScalingGroup",
            "Properties": {
                "AutoScalingGroupName": "${1}-ASG",
                "LaunchTemplate": {
                    "LaunchTemplateName": "${1}-LaunchTemplate",
                    "Version": "1"
                },
                "MinSize": "${2}",
                "MaxSize": "${2}",
                "DesiredCapacity": "${2}",
                "VPCZoneIdentifier": ["subnet-dd0354b8"]  # Replace with actual subnet IDs
            }
        }
    }
}
EOL
}

# Function to display help message
show_help() {
    echo "Usage: $0 -n <name> -s <size>"
    echo "  -n <name>   Base name for the created artifacts"
    echo "  -s <size>   Number of instances for the ASG"
    echo "  -h          Display this help message"
    exit 0
}

# Parse command-line arguments
while getopts ":n:s:h" opt; do
    case ${opt} in
        n )
            name=${OPTARG}
            ;;
        s )
            size=${OPTARG}
            ;;
        h )
            show_help
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            show_help
            ;;
        : )
            echo "Option -$OPTARG requires an argument." >&2
            show_help
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "$name" ] || [ -z "$size" ]; then
    echo "Error: Missing required arguments. Use -h for help."
    exit 1
fi

# Generate templates
echo "Creating Launch Template and ASG CloudFormation templates..."
generate_launch_template "$name"
generate_asg_template "$name" "$size"

echo "Launch Template saved as ${name}_launch_template.json"
echo "ASG Template saved as ${name}_asg_template.json"
