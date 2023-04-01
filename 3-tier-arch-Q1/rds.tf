resource "aws_db_instance" "postgresql" {
  allocated_storage    			      = "${var.db_allocated_storage}"
  storage_type        			      = "io1"
  iops                            = 1000
  engine                          = "postgres"
  engine_version                  = "12.9"
  identifier                      = "database-${var.app_environment}"
  instance_class                  = "${var.db_instance_class}"
  username                        = "${var.db_username}"
  password						            = "${var.db_password}"
  backup_retention_period         = "${var.db_backup_retention_period}"
  maintenance_window              = "Sun:00:00-Sun:03:00"
  auto_minor_version_upgrade      = true
  copy_tags_to_snapshot           = true
  multi_az                        = "${var.db_multi_az}"
  port                            = 5432
  vpc_security_group_ids          = [aws_security_group.vas_postgres_sg.id]
  db_subnet_group_name            = aws_db_subnet_group.default.name
  parameter_group_name            = "default.postgres12"
  storage_encrypted               = true
  deletion_protection             = true
  final_snapshot_identifier       = "database-${var.app_environment}-final"

  tags = local.tags
}

resource "aws_security_group" "vas_postgres_sg" {
  name 							  = "database-${var.app_environment}-sg"

  description = "Traffic for the sudhakar Postgres RDS ${var.app_environment} instance"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_db_subnet_group" "default" {
  name       = "database-${var.app_environment}-subnet-group"
  subnet_ids = "${aws_subnet.subnet1-private.id}"

  tags = local.tags
}