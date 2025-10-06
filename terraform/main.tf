resource "aws_s3_bucket" "resume" {
  bucket_prefix = "resume"
  force_destroy = true 
}

data "aws_iam_policy_document" "allow_s3_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.resume.arn}/*",
    ]

    effect = "Allow"
  }
}

resource "aws_s3_bucket_policy" "resume" {
  bucket = aws_s3_bucket.resume.id
  policy = data.aws_iam_policy_document.allow_s3_public_access.json
}

resource "aws_s3_bucket_public_access_block" "disable_block" {
  bucket                  = aws_s3_bucket.resume.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "resume" {
  bucket = aws_s3_bucket.resume.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}