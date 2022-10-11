##### Product VPC #####
module "vpc" {
    source = ".." #Module Source
    
    project_name        = "${local.project_name}"                       #locals.tf -> project_name
    env                 = "${local.env}"                                #locals.tf -> env
    region_tag          = "${local.region_tag}"                         #regin_tag + project_name + env = ${locals.name-fix}
    region              = "ap-northeast-2"
    vpc_cidr            = "172.21.0.0/16"
    
    sub_pub_cidr   = ["172.21.0.0/19","172.21.32.0/19"]
    sub_pri_cidr   = ["172.21.64.0/18","172.21.128.0/18"]
    sub_db_cidr    = ["172.21.192.0/19","172.21.224.0/19"]
    az              = ["ap-northeast-2a","ap-northeast-2c"]
}