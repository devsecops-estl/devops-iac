resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = {
    Name    = var.bucket_name
    Product = var.product_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id"     : "BUCKET-POLICY",
    "Statement": [
      {
        "Sid"      : "EnforceTls",
        "Effect"   : "Deny",
        "Principal": "*",
        "Action"   : "s3:*",
        "Resource": [
          "${aws_s3_bucket.this.arn}/*",
          "${aws_s3_bucket.this.arn}"
        ],
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "false"
          }
        }
      },
      {
        "Sid"      : "EnforceProtoVer",
        "Effect"   : "Deny",
        "Principal": "*",
        "Action"   : "s3:*",
        "Resource": [
          "${aws_s3_bucket.this.arn}/*",
          "${aws_s3_bucket.this.arn}"
        ],
        "Condition": {
          "NumericLessThan": {
            "s3:TlsVersion": 1.2
          }
        }
      }
    ]
  }
POLICY
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
