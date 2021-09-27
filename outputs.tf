output "web0-ips" {
  value = aws_instance.web-server-a.public_ip
}

output "web1-ips" {
  value = ["${aws_instance.web-server-b.*.public_ip}"]
}

output "web2-ips" {
  value = aws_instance.web-server-c.public_ip
}


output "LB-DNS" {
  value = aws_lb.lb.dns_name
}