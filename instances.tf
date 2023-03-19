//SETTING UP THE EC2 INSTANCES
resource "aws_instance" "Master" {
  ami                         = "ami-0557a15b87f6559cf"
  instance_type               = "t2.medium"
  availability_zone           = "us-east-1a"
  security_groups             = [aws_security_group.hmw-instances-sg.id]
  associate_public_ip_address = true
  key_name                    = "london"
  subnet_id                   = aws_subnet.hmw-public-subnets1.id

  tags = {
    Name = "Master"
  }
}

# resource "aws_instance" "Worker-1" {
#   ami                         = "ami-005f9685cb30f234b"
#   instance_type               = "t2.medium"
#   availability_zone           = "us-east-1b"
#   security_groups             = [aws_security_group.hmw-instances-sg.id]
#   associate_public_ip_address = true
#   key_name                    = var.key_pair_name
#   subnet_id                   = aws_subnet.hmw-public-subnets2.id

#   tags = {
#     Name = "Worker-1"
#   }

# }

# resource "aws_instance" "Worker-2" {
#   ami                         = "ami-005f9685cb30f234b"
#   instance_type               = "t2.micro"
#   availability_zone           = "us-east-1b"
#   security_groups             = [aws_security_group.hmw-instances-sg.id]
#   associate_public_ip_address = true
#   key_name                    = var.key_pair_name
#   subnet_id                   = aws_subnet.hmw-public-subnets2.id

#   tags = {
#     Name = "Worker-2"
#   }


# resource "aws_instance" "Jenkins" {
#   ami                         = "ami-005f9685cb30f234b"
#   instance_type               = "t2.micro"
#   availability_zone           = "us-east-1a"
#   security_groups             = [aws_security_group.hmw-instances-sg.id]
#   associate_public_ip_address = true
#   key_name                    = "london.pem"
#   subnet_id                   = aws_subnet.hmw-public-subnets1.id

#   tags = {
#     Name = "Jenkins"
#   }
#   # userdata file to install jenkins and its depencies
#   user_data = file("user-data-jenkins.sh")
# }




// IMPORTING IP ADDRESSES INTO HOST-INVENTORY FILE

# output "host_ips" {
#   value = (join("\n", [
#     aws_instance.Master.public_ip,
#     aws_instance.Worker-1.public_ip,
#     aws_instance.Worker-2.public_ip,
#   ]))
# }

# resource "local_file" "inventory" {
#   filename = "host-inventory"
#   content  = <<EOT
#        [Master]
#        ${aws_instance.Master.public_ip}
       
#        [Worker]
#        ${aws_instance.Worker-1.public_ip}
#        ${aws_instance.Worker-2.public_ip}
#     EOT
# }