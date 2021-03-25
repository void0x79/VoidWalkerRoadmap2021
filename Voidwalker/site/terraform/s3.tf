### Uploads site to s3 bucket ###

locals {
        s3_origin_id = "S3-voidwalker"
    }


resource "aws_s3_bucket" "site_bucket" {
    bucket = "voidwalker.systems"
    acl    = "private"

    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

resource "aws_s3_bucket" "tls_site_bucket" {
    bucket = "www.voidwalker.systems"
    acl    = "private"
}

resource "aws_s3_bucket_policy" "get_contents" {
    bucket = aws_s3_bucket.site_bucket.bucket
    policy = jsonencode({
        Version = "2012-10-17"
        Id      = "GETCONTENTBUCKET"
        Statement = [
            {
                Effect    = "Allow"
                Principal = "*"
                Action    = "s3:GetObject"
                Resource  = "${aws_s3_bucket.site_bucket.arn}/*"
            }
        ]
    })
}


resource "null_resource" "site_upload" {
    provisioner "local-exec" {
        command = "aws s3 sync ${path.module}/site s3://${aws_s3_bucket.site_bucket.id} --profile personal"
    }
}

output "files-uploaded" {
    value = fileset(path.module, "*/")
}