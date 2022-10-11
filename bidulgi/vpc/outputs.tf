output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "sub_pub_2a" {
    value = aws_subnet.sub_pub[0].id
}

output "sub_pub_2c" {
    value = aws_subnet.sub_pub[1].id
}

output "sub_pri_2a" {
    value = aws_subnet.sub_pri[0].id
}

output "sub_pri_2c" {
    value = aws_subnet.sub_pri[1].id
}

output "sub_db_2a" {
    value = aws_subnet.sub_db[0].id
}

output "sub_db_2c" {
    value = aws_subnet.sub_db[1].id
}

output "sub_pub_all" {
    value = aws_subnet.sub_pub[*].id
}

output "sub_pri_all" {
    value = aws_subnet.sub_pri[*].id
}

output "sub_db_all" {
    value = aws_subnet.sub_db[*].id
}

output "project_name" {
    value = var.project_name
}

output "env" {
    value = var.env
}