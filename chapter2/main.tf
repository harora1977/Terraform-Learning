provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "myfirstec2instancewithterraform" {
    ami = "ami-081bb417559035fe8"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.myfirstsecuritygroupwithterraform.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    tags = {
        Name = "My-First-EC2Instance-With-Terraform"
    }
}

resource "aws_security_group" "myfirstsecuritygroupwithterraform" {
    name = "first-instance-security-group-with-terraform"

    ingress  {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
