output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "nginx_instance_ids" {
  value = aws_instance.nginx[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
