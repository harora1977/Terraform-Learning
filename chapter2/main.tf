provider "aws" {
    region = "ap-south-1"
}

variable server_port {
    type = number
    description = "This represents the port of the server"
    default = 8080
} 

resource "aws_instance" "myfirstec2instancewithterraform" {
    ami = "ami-0d758c1134823146a"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.myfirstsecuritygroupwithterraform.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

    tags = {
        Name = "My-First-EC2Instance-With-Terraform"
    }
}

resource "aws_security_group" "myfirstsecuritygroupwithterraform" {
    name = "first-instance-security-group-with-terraform"

    ingress  {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output public_ip {
    value = aws_instance.myfirstec2instancewithterraform.public_ip
    description = "This is the public ip of the created EC2 instance"
}
