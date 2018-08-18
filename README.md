# Terraform AWS Provisioning Playground

Repository for playing around Terraform AWS Provider

**See AWS Regions**

`$ aws ec2 describe-regions
`

**See Availability Zones for us-east-1**

`$ aws ec2 describe-availability-zones --region us-east-1
`

**Generate a keygen**

`ssh-keygen -f aws-key
` 

**Init Terraform**

`$ terraform init
`

**See what'll change**

`$ terraform plan
`

**Provisioning**

`$ terraform apply
`

**Destroy**

`$ terraform destroy
`