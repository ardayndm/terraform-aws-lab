output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "subnet2_id" {
  value = aws_subnet.public_2.id
}
