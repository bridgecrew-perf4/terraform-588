resource "aws_lb" "lb" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.public_subnet_0.id, aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = 80
    protocol = "HTTP"
    matcher  = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "lb_tg_attach" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.web-server-a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_tg_attach1" {
  count = var.serverb_instances
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.web-server-b[count.index].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_tg_attach2" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.web-server-c.id
  port             = 80
}
