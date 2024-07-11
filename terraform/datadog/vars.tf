variable "datadog_api_url" {
  type        = string
  description = "app key for datadog"
  default     = "https://app.datadoghq.eu"
}

variable "region" {
  type        = string
  description = "region"
  default = "West Europe"
}