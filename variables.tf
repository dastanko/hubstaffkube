# App Settings
variable "image" {
  default = "nginx"
}

variable "image_tag" {
  default = "1.21.6"
}

# DB settings
variable "db_name" {
  default = "postgresdb"
}
variable "db_username" {
  default = "admin"
}
variable "db_password" {
  default = "somepassword"
}
