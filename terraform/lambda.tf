data "archive_file" "lambda" {
  type = "zip"
  source_file = "../scripts/lambda_pkg.py"
  output_path = "../scripts/index.zip"
}

resource "aws_lambda_function" "lambda" {
  filename = "../scripts/index.zip"
  function_name = "${var.name_prefix}-${var.service}-lambda-function"
  role = aws_iam_role.lambda.arn
  handler = "lambda_pkg.lambda_handler"  ## format:- <python program name>.<lambda_handler>
  runtime = "python3.12"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  depends_on = [
    data.archive_file.lambda
  ]
}

resource "aws_iam_role" "lambda" {
  name = "${var.name_prefix}-${var.service}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
  ]
})
}

## The below permissions to be added to the role
## 1. AWSLambdaBasicExecutionRole
## 2. AmazonSageMakerFullAccess
resource "aws_iam_role_policy_attachment" "lambda" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", 
    "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
  ])

  role       = aws_iam_role.lambda.name
  policy_arn = each.value
}