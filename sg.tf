resource "aws_security_group" "sg" {
  name        = "web_sg"
  description = "open port 80 and 22 on webserver"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "web_sg"
  }
}

resource "aws_security_group_rule" "sg_rules" {
  for_each          = var.sg_rules
  type              = each.value.type
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group" "sg_private" {
  name        = "web_sg"
  description = "open port 80 and 22 on webserver"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "web_sg_private"
  }
}

resource "aws_security_group_rule" "sg_rules_private" {
  for_each          = var.sg_rules
  type              = each.value.type
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}
