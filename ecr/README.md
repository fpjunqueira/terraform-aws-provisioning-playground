# AWS ECR Terraform

**Init Terraform Plugins**

`$ terraform init
`

**See the Plan**

`$ terraform plan
`

**Aplly planned changes**

`$ terraform apply
`

**Push Docker Image to AWS ECR**

`$ docker tag <local-image>:latest <ecr-repository>:latest
`

`$ `aws ecr get-login --no-include-email --region us-east-1`
`

`$ docker push <ecr-repository>/eureka-server:latest
`

**TODO**

- Push eureka-server to the docker hub and pull it before tag 
- Add AWS ECS draw.io diagram