// Get All Availability Zones
data "aws_availability_zones" "available" {
  all_availability_zones = true
  state                  = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags = merge(
    tomap({
      "Name"      = "${var.env}-eip",
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.env}-vpc"

  cidr = var.cidr // 10.0.0.0/8 is reserved for EC2-Classic

  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]

  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  database_subnets    = var.database_subnets
  elasticache_subnets = var.elasticache_subnets

  create_database_subnet_group = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway  = true
  single_nat_gateway  = true
  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat.*.id

  manage_default_security_group = true
  manage_default_network_acl    = true
  manage_default_route_table    = true

  tags = merge(
    tomap({
      "Name"      = "${var.env}-${lower(var.env)}-vpc",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  public_subnet_tags = merge(
    tomap({
      "Name"      = "${var.env}-public-subnet",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  private_subnet_tags = merge(
    tomap({
      "Name"      = "${var.env}-private-subnet",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  database_subnet_tags = merge(
    tomap({
      "Name"      = "${var.env}-rds-subnet",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  elasticache_subnet_tags = merge(
    tomap({
      "Name"      = "${var.env}-redis-subnet",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  igw_tags = merge(
    tomap({
      "Name"      = "${var.env}-igw",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  nat_gateway_tags = merge(
    tomap({
      "Name"      = "${var.env}-ngw",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  nat_eip_tags = merge(
    tomap({
      "Name"      = "${var.env}-eip",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )

  default_security_group_tags = merge(
    tomap({
      "Name"      = "${var.env}-${lower(var.env)}-sg",
      "Environment"   = var.env,
      "Env"       = var.env,
      "Terraform" = "true"
    })
  )
}
