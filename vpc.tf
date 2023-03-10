module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  # insert the 14 required variables here
  name                             = format("%s-%s-VPC", var.customer, var.environment)
  cidr                             = var.cidr
  enable_dns_hostnames             = true
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  azs                              = ["us-east-1a", "us-east-1b"]
  public_subnets                   = [var.Public_Subnet_AZ1, var.Public_Subnet_AZ2]
  private_subnets                  = [var.App_Subnet_AZ1, var.App_Subnet_AZ2]
  database_subnets                 = [var.Data_Subnet_AZ1, var.Data_Subnet_AZ2]

  # Nat Gateway
  enable_nat_gateway = true
  single_nat_gateway = true                   #if true, nat gateway only create one

  # Reuse NAT IPs
  reuse_nat_ips         = true                 # <= if true, Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids   = [aws_eip.eip-nat.id] #attach eip from manual create eip
  public_subnet_suffix  = "public"
  private_subnet_suffix = "private"
  intra_subnet_suffix   = "data"

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
#  enable_flow_log                      = true
#  create_flow_log_cloudwatch_log_group = true
#  create_flow_log_cloudwatch_iam_role  = true
#  flow_log_max_aggregation_interval    = 60
#  flow_log_cloudwatch_log_group_kms_key_id = module.kms-cwatch-flowlogs-kms.key_arn

  tags = local.common_tags
#  vpc_flow_log_tags = {
#    Name = format("%s-%s-vpc-flowlogs", var.customer, var.environment)
#  }
}

resource "aws_eip" "eip-nat" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-%s-eip-nat", var.customer, var.environment)
  })
}
