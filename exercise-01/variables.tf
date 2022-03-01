variable "gcp_project" {
  description = "The GCP project to use for test"
  default     = "unity-ie-sre-isolated-test"

variable "gcp_region" {
  description = "the gcs region to use"
  default     = "us-central1"
}

variable "name" {
  description = "The name for the gcp Instance and all other resources in this module."
  default     = "example-web-server"
}

variable "key_name" {
  description = "The name of key that can be used to SSH to the GCP Instance. Leave blank to not associate a Key Pair with the Instance."
  default     = ""
}

variable "http_port" {
  description = "The port the GCP Instance should listen on for HTTP requests"
  default     = 8080
}

variable "server_text" {
  description = "The text the server should return for HTTP requests"
  default     = "Hello, World from Matt Spah!"
}
