This repo deploys 3 EC2 instances in 3 difference AZ's in a secure VPC, with an ALB balancing requests between the 3 servers.
Weberser-a takes advantage of ansible dynamic inventory.
Weberser-b has 2 instances.

There is one varialbe without a default so you should create a var-file and pass this on the command line
terraform apply -var-file  prod.tfvar

Ansible dynamic inventory depends on boto3 
pip3 install boto3 --user

If you apply and then destroy you must delete myKey.pem before applying again