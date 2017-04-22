resource "aws_subnet" "subnet-test-field-az-c2" {
	vpc_id = "${aws_vpc.test-field.id}"
	cidr_block = "172.10.1.0/24"
	availability_zone = "ap-northeast-1c"
	map_public_ip_on_launch = true

	tags {
	  "Name" = "test-field-az-c2"
	}
}

resource "aws_subnet" "subnet-test-field-az-c" {
	vpc_id = "${aws_vpc.test-field.id}"
	cidr_block = "172.10.0.0/24"
	availability_zone = "ap-northeast-1c"
	map_public_ip_on_launch = true

	tags {
		"Name" = "test-field-az-c"
	}
}

resource "aws_subnet" "subnet-side-effect-az-a" {
	vpc_id = "${aws_vpc.side-effect.id}"
	cidr_block = "172.31.16.0/20"
	availability_zone = "ap-northeast-1a"
	map_public_ip_on_launch = true

	tags {
	  "Name" = "side-effect-az-a"
	}
}

resource "aws_subnet" "subnet-side-effect-az-c" {
	vpc_id = "${aws_vpc.side-effect.id}"
	cidr_block = "172.31.0.0/20"
	availability_zone = "ap-northeast-1c"
	map_public_ip_on_launch = true

	tags {
		"Name" = "side-effect-az-c"
	}
}

