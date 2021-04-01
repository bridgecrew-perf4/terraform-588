resource "aws_instance" "ec2" {
       count = length(var.user_names)
       ami    = "ami-01c835443b86fe988"
       instance_type  = "t2.micro"
       vpc_security_group_ids    = [aws_security_group.nbrown.id]
       subnet_id = aws_subnet.var.instances[count.index].id
       availability_zone = "aws_availability_zone.var.instances[count.index].id"

       tags = {
         Name = var.instances[count.index]
       }     
}
