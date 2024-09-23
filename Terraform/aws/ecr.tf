resource "aws_ecr_repository" "nginx" {
  name         = "sakurai-nginx"
  force_delete = true
}

resource "null_resource" "push_nginx_to_ecr" {
  provisioner "local-exec" {
    command = "$(aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.nginx.repository_url})"
  }

  provisioner "local-exec" {
    command = "docker pull nginx:latest"
  }

  provisioner "local-exec" {
    command = "docker tag nginx:latest ${aws_ecr_repository.nginx.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.nginx.repository_url}:latest"
  }
}
