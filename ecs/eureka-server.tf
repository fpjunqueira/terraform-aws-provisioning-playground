# eureka-service task definition

# file template with the task definition json receiving the eureka-server ecr url 
data "template_file" "eureka-server-task-definition-template" {
  template               = "${file("templates/eureka-server.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.eureka-server.repository_url}", "https://", "")}"
  }
}

# task definition
resource "aws_ecs_task_definition" "eureka-sever-task-definition" {
  family                = "eureka-server"
  container_definitions = "${data.template_file.eureka-server-task-definition-template.rendered}"
}

# service definition 
resource "aws_ecs_service" "eureka-server-service" {
  name = "eureka-server"
  # cluster
  cluster = "${aws_ecs_cluster.microservices-cluster.id}"
  # task definition
  task_definition = "${aws_ecs_task_definition.eureka-sever-task-definition.arn}"
  # how many instances of the task will run
  desired_count = 1
  # policies difined in iam.tf
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  # attach the policies
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  # load balancer elb.tf
  load_balancer {
    elb_name = "${aws_elb.eureka-server-elb.name}"
    container_name = "eureka-server"
    container_port = 8010
  }
  lifecycle { ignore_changes = ["task_definition"] }
}

