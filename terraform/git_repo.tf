# Defining the Git repo to instantiate on the SageMaker notebook instance
resource "aws_sagemaker_code_repository" "git_repo" {
  code_repository_name = "${var.name_prefix}-${var.service}-demo-repo"
  
  git_config {
    repository_url = "https://github.com/paravx2020/sagemaker-demo01.git"
  }
}