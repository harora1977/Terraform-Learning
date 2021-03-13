provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "myfirstec2instancewithterraform" {
    ami = "ami-081bb417559035fe8"
    instance_type = "t2.micro"

    tags = {
        Name = "My-First-EC2Instance-With-Terraform"
    }
}
