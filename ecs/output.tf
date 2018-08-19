output "eureka-server-repository-URL" {
  value = "${aws_ecr_repository.eureka-server.repository_url}"
}
