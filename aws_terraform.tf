variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
    region = "us-east-1"
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    version = "~>2.0"
  
}

resource "aws_instance" "WebSite" {
    ami = "ami-07ebfd5b3428b6f4d"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.WebSG.name}"]
    associate_public_ip_address = "true"
    key_name = "tf_ec2_key"
    user_data = "${file("user_data.sh")}"

    tags = {
        Name = "WebServer"
    }
  
}

resource "aws_security_group" "WebSG" {
    name = "ServiceSG"
    vpc_id = "vpc-d45ef0ae"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

output "Instace_IP" {
  value = ["${aws_instance.WebSite.*.public_ip}"]
}



