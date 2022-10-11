#### prefix locals
locals {
  project_name = "bidulgi"
  region_tag = "an2"
  env = "dev"
  name_fix = "${local.region_tag}-${local.project_name}-${local.env}"
}