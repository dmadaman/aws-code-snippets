# Output Root Vars
output "subnets_default_public_root" {
  value = "${module.networking.default_public_subnets}"
}
output "vpc_id" {
  value = "${module.networking.vpc_id}"
}
