# main.tf

provider "aws" {
  region = "ap-southeast-1"
}

# S3 Bucket
resource "aws_s3_bucket" "mlflow_artifact_storage" {
  bucket = "mlflow-artifact-storage"
  acl    = "private"
}

# PostgreSQL RDS Instance
resource "aws_db_instance" "mlflow_postgres" {
  identifier           = "mlflow-postgres"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.7"
  instance_class       = "db.t2.micro"
  name                 = "mlflowdb"
  username             = "user"
  password             = "password"
  parameter_group_name = "default.postgres12"
}

# EC2 Instance
resource "aws_instance" "mlflow_ec2_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI, adjust based on your region
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"     # Change this to your key pair name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo docker run -d -p 5001:5001 \
                    -e MLFLOW_S3_ENDPOINT=http://s3.amazonaws.com \
                    -e AWS_ACCESS_KEY_ID=your_access_key \
                    -e AWS_SECRET_ACCESS_KEY=your_secret_key \
                    -e MLFLOW_S3_IGNORE_TLS=true \
                    -e MLFLOW_S3_REGION=us-east-1 \
                    -e MLFLOW_S3_BUCKET=mlflow-artifact-storage \
                    -e MLFLOW_DATABASE_URL=postgresql://user:password@mlflow-postgres:5432/mlflowdb \
                    mlflow/mlflow server
              EOF

  tags = {
    Name = "mlflow-ec2-instance"
  }
}
