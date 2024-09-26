resource "aws_db_subnet_group" "sakurai_db_subnet_gp" {
  name = "sakurai-main"
  subnet_ids = [
    aws_subnet.sakurai_subnet_a[1].id,
    aws_subnet.sakurai_subnet_c[1].id,
  ]

}

resource "aws_db_instance" "sakurai_rds" {
  allocated_storage = 10
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.33"
  instance_class    = "db.t3.micro"
  identifier        = "sakuraidb"
  username          = var.db_username
  password          = var.db_password
  #   manage_master_user_password = true # Secrets Managerでパスワード管理
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sakurai_rds_sec.id]
  db_subnet_group_name   = aws_db_subnet_group.sakurai_db_subnet_gp.name
}

