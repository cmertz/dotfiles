plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
	version = "0.30.0"
    enabled = true
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
