resource "aws_db_instance" "this" {
  count = var.use_aurora ? 0 : 1

  identifier              = "\-rds"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true
  multi_az                = var.multi_az
  parameter_group_name    = aws_db_parameter_group.this.name
}