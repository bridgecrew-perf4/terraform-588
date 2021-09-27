data "aws_ssm_parameter" "linuxAmi" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Get Linux AMI ID using SSM Parameter endpoint in us-west-2
data "aws_ssm_parameter" "linuxAmiOregon" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey" # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

#Create webserver 0 and add ansible playbook
resource "aws_instance" "web-server-a" {
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnet_0.id
  user_data                   = <<EOT
#!/bin/bash
sudo su
yum -y install httpd
echo "<p> My Instance! </p>" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd
EOT  

  provisioner "local-exec" {
    command = <<EOF
aws --profile default ec2 wait instance-status-ok --region eu-west-2 --instance-ids ${self.id}
ansible-playbook --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}' ./ansible/playbooks/web.yml
EOF
  }

  tags = {
    Name = "web-server-a"
  }

}

#Create 2 instances of webserverb 
resource "aws_instance" "web-server-b" {
  count = var.serverb_instances
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  user_data                   = <<EOT
  tags = {
    Name = "web-server-b-${count.index}"
#!/bin/bash
sudo su
yum -y install httpd
echo "<p> My Instance! </p>" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd
EOT 

  tags = {
    Name = "web-server-b-${count.index}"
  }
}

resource "aws_instance" "web-server-c" {
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_private.id]
  subnet_id                   = aws_subnet.private_subnet.id
  user_data                   = <<EOT
#!/bin/bash
sudo su
yum -y install httpd
echo "<p> My Instance! </p>" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd
EOT 

  tags = {
    Name = "web-server-c"
  }
}
