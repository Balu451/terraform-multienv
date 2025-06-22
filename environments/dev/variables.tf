variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}



variable "rds_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}
