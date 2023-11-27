variable "vpc_name" {}
variable "ami" {}
variable "instance_type" {}
variable "region" {}
variable "instance_name" {}
variable "tags" {}

// locals{
//   aws_iam_instance_profile = "myec2-profile"
//   aws_iam_role             = "ssm" 
// }
### Existing VPC and subnets fetching ###
data "aws_vpc" "targetVpc" {
   filter {
     name = "tag:Name"
     values = [var.vpc_name]
   }
}
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.targetVpc.id]
  }
  tags = {
        Name = "private*"
      }
}
data "aws_subnet" "this" {
  for_each = toset(data.aws_subnets.selected.ids)
   id      = each.key
  
}
resource "aws_security_group" "sg" {
  name        = "${var.instance_name}-linux"
  vpc_id      = data.aws_vpc.targetVpc.id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "startup" {
 template = file("modules/ssm.sh")
}

### IAM role creation ###
resource "aws_iam_instance_profile" "profile" {
  name = "${var.instance_name}-ec2-profile"
  role = aws_iam_role.role.name
}
resource "aws_iam_role" "role" {
  name               = "${var.instance_name}-ssm-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

### AWS instance creation ###
resource "aws_instance" "main" { 
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.profile.name
  user_data            = data.template_file.startup.rendered
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id            = values(data.aws_subnet.this)[0].id
  tags                 = var.tags 
}

output "instance_id" {
  value = aws_instance.main.*.id
}
