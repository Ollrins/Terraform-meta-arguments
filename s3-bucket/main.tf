# s3-bucket/main.tf
module "s3_bucket" {
  source = "github.com/terraform-yc-modules/terraform-yc-s3?ref=4421e3a5546a88dba619a88b46a6371ac7c90da4""
  
  bucket_name = "dev-oll"
  max_size    = 1073741824  # 1 GB
}
