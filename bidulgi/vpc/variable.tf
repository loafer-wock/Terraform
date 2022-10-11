variable "project_name" {
    description = "project_name"
    type = string
}

variable "env" {
    description = "environment"
    type = string
}

variable "region" {
    description = "region name(ap-northeast-2..)"
    type = string
}

variable "region_tag" {
    description = "Region Name Tag"
    type = string
}

variable "vpc_cidr" {
    description = "Product VPC CIDR "
    type = string
}

variable "sub_pub_cidr" {
    description = "dcifvdual DMZ Subnet CIDR"
    type = list
}

variable "sub_pri_cidr" {
    description = "dcifvdual Application Subnet CIDR"
    type = list
}

variable "sub_db_cidr" {
    description = "dcifvdual DB Subnet CIDR"
    type = list
}

variable "az" {
    description = "az"
    type = list
}