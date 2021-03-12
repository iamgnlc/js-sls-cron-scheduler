provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["${var.aws_account_id}"]
}

provider "aws" {
  alias = "master_role"
  region = "${var.region}"
  assume_role {
    role_arn     = "${var.aws_master_role}"
  }
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "grid" {
  backend = "s3"

  config = {
    bucket = "${var.state_bucket}"
    key    = "${var.env}/grid.tfstate"
    region = "eu-west-2"
  }
}

data "aws_ssm_parameter" "rewrites_url" {
  name = "/${var.env}/${var.stack}/rewrites/rewrites-url"
}

resource "aws_ssm_parameter" "rewrites-endpoint" {
    name       = "/${var.env}/${var.stack}/${var.app}/rewrites-endpoint"
    type       = "SecureString"
    value      = "${data.aws_ssm_parameter.rewrites_url.value}"

    tags = {
      env        = "${var.env}"
      stack      = "${var.stack}"
      app        = "${var.app}"
      created-by = "terraform"
    }
  }

data "aws_ssm_parameter" "vehicles-endpoint" {
  name = "/${var.env}/${var.stack}/vehicles/vehicles-endpoint"
}
resource "aws_ssm_parameter" "vehicles-endpoint" {
    name       = "/${var.env}/${var.stack}/${var.app}/vehicles-endpoint"
    type       = "SecureString"
    value      = "${data.aws_ssm_parameter.vehicles-endpoint.value}"

    tags = {
      env        = "${var.env}"
      stack      = "${var.stack}"
      app        = "${var.app}"
      created-by = "terraform"
    }
  }  

data "aws_ssm_parameter" "sitemaps-endpoint" {
  name = "/${var.env}/${var.stack}/sitemaps/sitemaps-url"
}
resource "aws_ssm_parameter" "sitemaps-endpoint" {
    name       = "/${var.env}/${var.stack}/${var.app}/sitemaps-endpoint"
    type       = "SecureString"
    value      = "${data.aws_ssm_parameter.sitemaps-endpoint.value}"

    tags = {
      env        = "${var.env}"
      stack      = "${var.stack}"
      app        = "${var.app}"
      created-by = "terraform"
    }
  }  