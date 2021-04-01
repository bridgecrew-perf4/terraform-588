variable "instances" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}