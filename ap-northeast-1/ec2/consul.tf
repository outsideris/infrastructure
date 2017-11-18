module "consul" {
  source = "hashicorp/consul/aws"

  # https://github.com/hashicorp/terraform-aws-consul/blob/master/_docs/ubuntu16-ami-list.md
  ami_id          = "ami-847ab7e2"
  aws_region      = "ap-northeast-1"
  cluster_name    = "consul-cluster"
  cluster_tag_key = "consul-servers"
  num_clients     = "2"
  num_servers     = "3"
  ssh_key_name    = "${var.keypair}"
  vpc_id          = "${data.terraform_remote_state.vpc.side_effect_id}"
}
