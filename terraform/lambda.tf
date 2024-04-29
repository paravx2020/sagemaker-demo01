data "archive_file" "lambda" {
  type = "zip"
  source_file = "../scripts/lambda_pkg.py"
  output_path = "../scripts/index.zip"
}

resource "aws_lambda_function" "lambda" {
  filename = "index.zip"
  function_name = "paravx1-sagemaker-LambdaFunction"
  role = aws_iam_role.lambda.arn
  handler = "index.handler"
  runtime = "python3.12"
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_iam_role" "lambda" {
  name = "paravx1-sagemaker-lambda-role"

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
