terraform {
    backend "s3" {
        bucket  = "voidwalker-site"
        region  = "us-east-1"
        key     = "main"
        profile = "personal"
        encrypt = true
    }
}

