resource "aws_instance" "web_instance" {
    ami = "ami-01376101673c89611"
    instance_type = "t2.micro"
    key_name = "terraform_mac_playWithDevOps"
    security_groups = [aws_security_group.ssh-connection.name]
    tags = {
      Name = "Web_instance"
    }

}

resource "aws_security_group" "ssh-connection" {
    name = "ssh-connection"
    description = "Enables the SSH connectivity"

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