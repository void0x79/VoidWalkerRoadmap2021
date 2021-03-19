### Upload the "site" directory to the s3 bucket. ###

resource "aws_s3_bucket" "site_bucket" {
    bucket = "voidwalker.dev"
    acl    = "private"
}

resource "aws_s3_bucket" "tls_site_bucket" {
    bucket = "www.voidwalker.dev"
    acl    = "private"
}


resource "aws_s3_bucket_object" "voidwalker_site" {
    for_each = fileset(path.module, "*/*")
    bucket   = aws_s3_bucket.site_bucket.bucket
    key      = each.value
}

output "files-uploaded" {
    value = fileset(path.module, "*/*")
}