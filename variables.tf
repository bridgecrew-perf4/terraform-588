variable "environment" {
  type = string
}

variable "public_subnet" {
  type    = list
  default = []
}

variable "serverb_instances" {
  type    = number
  default = 2
}


variable "sg_rules" {
  type = map(map(any))
  default = {
    in22   = { from = 22, to = 22, type = "ingress" }
    in80   = { from = 80, to = 80, type = "ingress" }
    out443 = { from = 443, to = 443, type = "egress" }
    out80  = { from = 80, to = 80, type = "egress" }
  }
}

