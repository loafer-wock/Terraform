resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = "vpc-${var.region_tag}-${var.project_name}-${var.env}"
    }
}

##### Subnet #####
resource "aws_subnet" "sub_pub" {
    count = length(var.sub_pub_cidr)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_pub_cidr[count.index]
    availability_zone = var.az[count.index]
    
    tags = {
        Name = "sub-${var.region_tag}-${var.project_name}-${var.env}-pub-${substr("${var.az[count.index]}", -2, -1)}"
    }
}

resource "aws_subnet" "sub_pri" {
    count = length(var.sub_pri_cidr)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_pri_cidr[count.index]
    availability_zone = var.az[count.index]
    
    tags = {
        Name = "sub-${var.region_tag}-${var.project_name}-${var.env}-pri-${substr("${var.az[count.index]}", -2, -1)}"
    }
}

resource "aws_subnet" "sub_db" {
    count = length(var.sub_db_cidr)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_db_cidr[count.index]
    availability_zone = var.az[count.index]
    
    tags = {
        Name = "sub-${var.region_tag}-${var.project_name}-${var.env}-db-${substr("${var.az[count.index]}", -2, -1)}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "igw-${var.region_tag}-${var.project_name}-${var.env}"
    }
}

resource "aws_eip" "nat_eip" {
    
    network_border_group = var.region
    public_ipv4_pool = "amazon"
    
    tags = {
        Name = "eip-${var.region_tag}-${var.project_name}-${var.env}-nat"
    }
    vpc = "true"
}

resource "aws_nat_gateway" "nat" {
    
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.sub_pub[1].id
    
    tags = {
        Name = "nat-${var.region_tag}-${var.project_name}-${var.env}"
    }
}

resource "aws_route_table" "sub_pub_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "rtb-${var.region_tag}-${var.project_name}-${var.env}-pub"
    }
}

resource "aws_route_table" "sub_pri_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    
    tags = {
        Name = "rtb-${var.region_tag}-${var.project_name}-${var.env}-pri"
    }
}

resource "aws_route_table" "sub_db_rt" {
    vpc_id = aws_vpc.vpc.id
    
    tags = {
        Name = "rtb-${var.region_tag}-${var.project_name}-${var.env}-db"
    }
}

resource "aws_route_table_association" "rt_pub_asso" {
    count = length(var.sub_pub_cidr)
    subnet_id = aws_subnet.sub_pub[count.index].id
    route_table_id = aws_route_table.sub_pub_rt.id
}

resource "aws_route_table_association" "rt_pri_asso" { 
    count = length(var.sub_pri_cidr)
    subnet_id = aws_subnet.sub_pri[count.index].id
    route_table_id = aws_route_table.sub_pri_rt.id
}

resource "aws_route_table_association" "rt_db_asso" { 
    count = length(var.sub_db_cidr)
    subnet_id = aws_subnet.sub_db[count.index].id
    route_table_id = aws_route_table.sub_db_rt.id
}
