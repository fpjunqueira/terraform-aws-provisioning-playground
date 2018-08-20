[
  {
    "essential": true,
    "memory": 256,
    "name": "eureka-server",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "portMappings": [
        {
            "containerPort": 8010,
            "hostPort": 8010
        }
    ]
  }
]

