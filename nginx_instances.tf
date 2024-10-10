# EC2 Instances (Nginx) in App Subnets
resource "aws_instance" "nginx" {
  count = 3
  ami           = "ami-054a53dca63de757b"  # Replace with your desired Nginx AMI ID
  instance_type = "t2.micro"
  
  subnet_id     = element([aws_subnet.app_1.id, aws_subnet.app_2.id, aws_subnet.app_3.id], count.index)
  
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install nginx1 -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
    Name = "nginx-${count.index + 1}"
  }
}
