output "loadbalancer_url" {
  value = aws_lb.homework_lb.dns_name
}
