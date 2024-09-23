# ECSのセキュリティグループ
resource "aws_security_group" "ecs" {
  name   = "sakurai-ecs-security"
  vpc_id = aws_vpc.sakurai_vpc.id

  # アウトバウンドトラフィックを全て許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ecs_ingress_http" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs.id

  # インターネットから80ポートへのHTTPトラフィックを許可
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"] # 同一VPC内からのアクセスのみ許可
}

# ALBのセキュリティグループ
resource "aws_security_group" "alb" {
  name   = "sakurai-alb-security"
  vpc_id = aws_vpc.sakurai_vpc.id
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  # ALBへの80ポートのHTTPトラフィックを許可
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # 公開アクセスを許可する場合
}

resource "aws_security_group_rule" "allow_app_sg_egress" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  # ALBからECSセキュリティグループへの80ポートのアウトバウンドトラフィックを許可
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs.id
}

# RDSのセキュリティグループ
resource "aws_security_group" "sakurai_rds_sec" {
  description = "Allow access to RDS"
  name        = "sakurai-rds-sg"
  vpc_id      = aws_vpc.sakurai_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["10.0.0.0/16"] # 同一VPC内からのアクセスのみ許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
