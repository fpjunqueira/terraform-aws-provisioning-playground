# Terraform AWS Provisioning Playground

Repository for playing around Terraform AWS Provider

**See AWS Regions**

`$ aws ec2 describe-regions
`

**See Availability Zones of us-east-1**
`$ aws ec2 describe-availability-zones --region us-east-1
`

**Generate a keygen**
`ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (~/.ssh/id_rsa): aws-key
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
`

**Init Terraform**
`$ terraform init
`

**Provisioning**
`$ terraform apply
`

**Destroy**
`$ terraform destroy
`