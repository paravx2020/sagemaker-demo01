resource "aws_s3_bucket" "b" {
  bucket = "${var.name_prefix}-${var.service}-demo-bucket"
#  acl    = "private"

  tags = {
    Name        = "${var.name_prefix}-${var.service}-demo-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "b" {
  bucket = aws_s3_bucket.b.id
  rule {
    object_ownership = "BucketOwnerEnforced"
    #object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket_acl" "b" {
#   depends_on = [aws_s3_bucket_ownership_controls.b]

#   bucket = aws_s3_bucket.b.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_policy" "b" {
#   bucket = aws_s3_bucket.b.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "paravx1-MYBUCKETPOLICY"
#     Statement = [
#       {
#         Sid       = "IPAllow"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = ["s3:GetObject", "s3:DeleteObject", "s3:PutObject"]
#         Resource  = "${aws_s3_bucket.b.arn}/*"
#       },
#     ]
#   })
# }

output "bucket_name" {
  value = aws_s3_bucket.b.bucket
  description = "The name of the bucket"
}

output "bucket_arn" {
  value = aws_s3_bucket.b.arn
  description = "The ARN of the bucket"
}