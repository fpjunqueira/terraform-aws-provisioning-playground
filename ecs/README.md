# AWS ECS Terraform

**Init Terraform Plugins**

`$ terraform init
`

**See the Plan**


`$ terraform plan
`

**Aplly planned changes**

`$ terraform apply
`

**Output**

`Apply complete! Resources: 27 added, 0 changed, 0 destroyed.
`

`Outputs:
`

`elb = <elastic-load-balancer-dns>
`

_Do get to output above:_


`$ curl <elastic-load-balancer-dns>
`

<img src="ecs-eureka-server.png" alt="eureka-server"/>
