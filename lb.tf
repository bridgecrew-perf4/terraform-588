resource "aws_lb" "nbrown" {
  name               = "nbrownlb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nbrown.id]
  subnets            = [aws_subnet.eu-west-2a.id, aws_subnet.eu-west-2b.id, aws_subnet.eu-west-2c.id]


}

resource "aws_lb_listener" "nbrown" {
  load_balancer_arn = aws_lb.nbrown.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nbrown.arn
  }
}

resource "aws_lb_target_group" "nbrown" {
  name     = "nbrown"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.nbrown.id
}

resource "aws_lb_target_group_attachment" "euwest2a" {
  target_group_arn = aws_lb_target_group.nbrown.arn
  target_id        = aws_instance.euwest2a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "euwest2b" {
  target_group_arn = aws_lb_target_group.nbrown.arn
  target_id        = aws_instance.euwest2b.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "euwest2c" {
  target_group_arn = aws_lb_target_group.nbrown.arn
  target_id        = aws_instance.euwest2c.id
  port             = 80
}