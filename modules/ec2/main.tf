resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project29-ec2-sg"
  }
}

resource "aws_instance" "this" {
  ami           = "ami-03f4878755434977f" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "project29-ec2"
  }
}
