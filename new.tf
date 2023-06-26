provider "aws" {}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                          = aws_vpc.my_vpc.id
  cidr_block                      = "10.0.0.0/24"
  availability_zone               = "eu-central-1a"
  map_public_ip_on_launch         = true
  
  tags = {
    Name = "My Subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My Internet Gateway"
  }
}
resource "aws_instance" "my_webserver" {
  count                       = 3
  ami                         = "ami-04e601abe3e1a910f"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my_webserver.id]
  associate_public_ip_address = true
  
  provisioner "local-exec" {
    command = <<EOF
      sudo apt-get update
      sudo apt-get install -y ansible

      # Run Ansible playbook
      ansible-playbook -i "${aws_instance.my_webserver.*.public_ip}," -u ubuntu playbook.yml
    EOF
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y default-jdk
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins

    # Install Jenkins plugins
    sudo /usr/local/bin/install-plugins.sh \
      blueocean \
      pipeline \

    sudo systemctl start jenkins
  EOF
}

resource "aws_security_group" "my_webserver" {
  name        = "Webserver Security Group"
  description = "My First Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}






