provider "aws" {
    region = "ap-south-1"
    access_key = <>
    secret_key = <>

}

variable server_port {
    type = number
    description = "This represents the port of the server"
    default = 80
} 

resource "aws_instance" "myfirstec2instancewithnginx" {
    ami = "ami-0bcf5425cdc1d8a85"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.securitygroupfornginx.id]

    user_data = <<-EOF
               	sudo amazon-linux-extras install nginx1 -y
                sudo service nginx start
                EOF

    tags = {
        Name = "My-First-EC2Instance-with-nginx"
    }
}

resource "aws_security_group" "securitygroupfornginx" {
    name = "first-instance-security-group-with-nginx"

    ingress  {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output public_ip {
    value = aws_instance.myfirstec2instancewithnginx.public_ip
    description = "This is the public ip of the created EC2 instance"
}
