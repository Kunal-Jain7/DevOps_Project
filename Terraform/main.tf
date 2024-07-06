resource "aws_instance" "web_instance" {
    ami = "ami-01376101673c89611"
    instance_type = "t2.micro"
    key_name = "terraform_mac_playWithDevOps"
    security_groups = [aws_security_group.ssh-connection.name]
    tags = {
      Name = "Web_instance"
    }
    subnet_id = aws_subnet.amber-pubsub01.id

}

resource "aws_security_group" "ssh-connection" {
    name = "ssh-connection"
    description = "Enables the SSH connectivity"
    vpc_id = aws_vpc.client-acr.id

    ingress {
        description = "SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh-connection"
    }
  
}

resource "aws_vpc" "client-acr" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "client-acr"
  }
}

resource "aws_subnet" "amber-pubsub01" {
  vpc_id = aws_vpc.client-acr.id
  cidr_block = "10.1.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "amber-pubsub01"
  }
}

resource "aws_subnet" "amber-pubsub02" {
  vpc_id = aws_vpc.client-acr.id
  cidr_block = "10.2.0.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "amber-pubsub02"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.client-acr.id
  tags = {
    Name = "gatewayOfInternet"
  }
}

resource "aws_route_table" "routing-table-public" {
  vpc_id = aws_vpc.client-acr.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}

resource "aws_route_table_association" "rta-public-subnet" {
  subnet_id = aws_subnet.amber-pubsub01.id
  route_table_id = aws_route_table.routing-table-public.id
}

resource "aws_route_table_association" "rta-public-subnet02" {
  subnet_id = aws_subnet.amber-pubsub02.id
  route_table_id = aws_route_table_association.rta-public-subnet.id
}