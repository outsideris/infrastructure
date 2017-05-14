// side-effect VPC for my personal projects
resource "aws_vpc" "side_effect" {
  cidr_block  = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags {
    "Name" = "side effect"
  }
}

// default route table
resource "aws_default_route_table" "side_effect" {
  default_route_table_id = "${aws_vpc.side_effect.default_route_table_id}"

  tags {
    Name = "default"
  }
}

// public subnets
resource "aws_subnet" "side_effect_public_subnet1" {
  vpc_id = "${aws_vpc.side_effect.id}"
  cidr_block = "10.10.1.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "public-az-1"
  }
}

// private subnets
resource "aws_subnet" "side_effect_private_subnet1" {
  vpc_id = "${aws_vpc.side_effect.id}"
  cidr_block = "10.10.10.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "private-az-1"
  }
}

resource "aws_subnet" "side_effect_private_subnet2" {
  vpc_id = "${aws_vpc.side_effect.id}"
  cidr_block = "10.10.11.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "private-az-2"
  }
}

// internet gateway
resource "aws_internet_gateway" "side_effect_igw" {
  vpc_id = "${aws_vpc.side_effect.id}"
  tags {
    Name = "internet-gateway"
  }
}

// route to internet
resource "aws_route" "side_effect_internet_access" {
  route_table_id = "${aws_vpc.side_effect.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.side_effect_igw.id}"
}

// eip for NAT
resource "aws_eip" "side_effect_nat_eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.side_effect_igw"]
}

// NAT gateway
resource "aws_nat_gateway" "side_effect_nat" {
  allocation_id = "${aws_eip.side_effect_nat_eip.id}"
  subnet_id = "${aws_subnet.side_effect_public_subnet1.id}"
  depends_on = ["aws_internet_gateway.side_effect_igw"]
} 

// private route table 
resource "aws_route_table" "side_effect_private_route_table" {
  vpc_id = "${aws_vpc.side_effect.id}"
  tags {
    Name = "private"
  }
}
 
resource "aws_route" "private_route" {
  route_table_id = "${aws_route_table.side_effect_private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.side_effect_nat.id}"
}

// associate subnets to route tables
resource "aws_route_table_association" "side_effect_public_subnet_association" {
  subnet_id = "${aws_subnet.side_effect_public_subnet1.id}"
  route_table_id = "${aws_vpc.side_effect.main_route_table_id}"
}
 
resource "aws_route_table_association" "side_effect_private_subnet1_association" {
  subnet_id = "${aws_subnet.side_effect_private_subnet1.id}"
  route_table_id = "${aws_route_table.side_effect_private_route_table.id}"
}

resource "aws_route_table_association" "side_effect_private_subnet2_association" {
  subnet_id = "${aws_subnet.side_effect_private_subnet2.id}"
  route_table_id = "${aws_route_table.side_effect_private_route_table.id}"
}

// default security group
resource "aws_default_security_group" "side_effect_default" {
  vpc_id = "${aws_vpc.side_effect.id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "default"
  }
}

// default network acl
// keep it do nothing
resource "aws_default_network_acl" "side_effect_default" {
  default_network_acl_id = "${aws_vpc.side_effect.default_network_acl_id}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "default"
  }
}

// network acl for public subnets
resource "aws_network_acl" "side_effect_public" {
  vpc_id = "${aws_vpc.side_effect.id}"
  subnet_ids = [
    "${aws_subnet.side_effect_public_subnet1.id}",
  ]

  tags {
    Name = "public"
  }
}

resource "aws_network_acl_rule" "side_effect_public_ingress80" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 100
  rule_action = "allow"
  egress = false
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 80
  to_port = 80
}

resource "aws_network_acl_rule" "side_effect_public_egress80" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 100
  rule_action = "allow"
  egress = true
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 80
  to_port = 80
}

resource "aws_network_acl_rule" "side_effect_public_ingress443" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 110
  rule_action = "allow"
  egress = false
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "side_effect_public_egress443" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 110
  rule_action = "allow"
  egress = true
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "side_effect_public_ingress22" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 120
  rule_action = "allow"
  egress = false
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 22
  to_port = 22
}

resource "aws_network_acl_rule" "side_effect_public_egress22" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 120
  rule_action = "allow"
  egress = true
  protocol = "tcp"
  cidr_block = "${aws_vpc.side_effect.cidr_block}"
  from_port = 22
  to_port = 22
}

resource "aws_network_acl_rule" "side_effect_public_ingress_ephemeral" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 140
  rule_action = "allow"
  egress = false
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}

resource "aws_network_acl_rule" "side_effect_public_egress_ephemeral" {
  network_acl_id = "${aws_network_acl.side_effect_public.id}"
  rule_number = 140
  rule_action = "allow"
  egress = true
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}

// network acl for private subnets
resource "aws_network_acl" "side_effect_private" {
  vpc_id = "${aws_vpc.side_effect.id}"

  egress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "${aws_vpc.side_effect.cidr_block}"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "${aws_vpc.side_effect.cidr_block}"
    from_port = 0
    to_port = 0
  }

  subnet_ids = [
    "${aws_subnet.side_effect_private_subnet1.id}",
    "${aws_subnet.side_effect_private_subnet2.id}"
  ]

  tags {
    Name = "private"
  }
}

// Basiton Host
resource "aws_security_group" "side_effect_bastion" {
  name = "bastion"
  description = "Security group for bastion instance"
  vpc_id = "${aws_vpc.side_effect.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastion"
  }
}

resource "aws_instance" "side_effect_bastion" {
  ami = "${data.aws_ami.ubuntu.id}"
  availability_zone = "${aws_subnet.side_effect_public_subnet1.availability_zone}"
  instance_type = "t2.nano"
  key_name = "${var.keypair}"
  vpc_security_group_ids = [
    "${aws_default_security_group.side_effect_default.id}",
    "${aws_security_group.side_effect_bastion.id}"
  ]
  subnet_id = "${aws_subnet.side_effect_public_subnet1.id}"
  associate_public_ip_address = true

  tags {
    Name = "bastion"
  }
}

resource "aws_eip" "side_effect_bastion" {
  vpc = true
  instance = "${aws_instance.side_effect_bastion.id}"
  depends_on = ["aws_internet_gateway.side_effect_igw"]
}