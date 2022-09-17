output "website-url" {
  value = module.website_s3_bucket.website-url
}

output "cdn-url" {
  value = module.website_s3_bucket.cdn-url
}

output "distribution-id" {
  value = module.website_s3_bucket.distribution-id
}

output "bucket_website" {
  value = module.website_s3_bucket.bucket_website
}