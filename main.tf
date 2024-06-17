provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MSSQL access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mssql" {
  identifier              = "mssql-instance"
  allocated_storage       = 20
  engine                  = "sqlserver-ex"
  engine_version          = "15.00.4365.2.v1" # SQL Server 2019
  instance_class          = "db.t3.medium"
  name                    = "mydatabase"
  username                = "admin"
  password                = "Nostrongpcanbreakthispassword"
  parameter_group_name    = "default.sqlserver-ex-15.0"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  backup_retention_period = 7
  monitoring_interval     = 60
  deletion_protection     = true
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]

  }
}

resource "aws_iam_role" "rds_access" {
  name = "rds_access"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy" "rds_access_policy" {
  name = "rds_access_policy"
  role = aws_iam_role.rds_access.id

  policy = jsonencode({
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBSnapshots",
          "rds:CreateDBSnapshot",
          "rds:DeleteDBSnapshot",
          "rds:StartDBInstance",
          "rds:StopDBInstance",
          "rds:ModifyDBInstance"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "rds:CreateDBInstance",
          "rds:DeleteDBInstance"
        ]
        Resource = "*"
      }
    ]
  })
}
