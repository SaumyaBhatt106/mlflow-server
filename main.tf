provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_db_instance" "mlflow_users_db" {
  identifier          = "mlflow-users-db-instance"
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "12.7"
  instance_class      = "db.t2.micro"
  username            = "db_user"
  password            = "db_password"
  publicly_accessible = false
}

resource "aws_db_instance" "mlflow_logs_db" {
  identifier          = "mlflow-logs-db-instance"
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "12.7"
  instance_class      = "db.t2.micro"
  username            = "db_user"
  password            = "db_password"
  publicly_accessible = false
}

resource "aws_s3_bucket" "mlflow_artifacts_bucket" {
  bucket = "mlflow-artifacts-bucket"
}

resource "aws_instance" "mlflow_instance" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  key_name                    = "key-pair"
  associate_public_ip_address = true

  tags = {
    Name = "mlflow-instance"
  }
}

output "mlflow_users_db_endpoint" {
  value = aws_db_instance.mlflow_users_db.endpoint
}

output "mlflow_logs_db_endpoint" {
  value = aws_db_instance.mlflow_logs_db.endpoint
}

output "mlflow_artifacts_bucket_name" {
  value = aws_s3_bucket.mlflow_artifacts_bucket.bucket
}

output "ec2_instance_public_ip" {
  value = aws_instance.mlflow_instance.public_ip
}
