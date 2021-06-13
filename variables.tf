variable "hetzner_api_token" {
  type        = string
  description = "Hetzner API token"

  validation {
    condition     = length(var.hetzner_api_token) == 64
    error_message = "Must be a 64 character long Hetzner API token."
  }
}

variable "server_role_arn" {
  type        = string
  description = "AWS arn of the role to assign to servers"

  validation {
    condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.server_role_arn))
    error_message = "Must be a valid AWS IAM role ARN."
  }
}

variable "env" {
  type        = string
  description = "Environment to deploy, can be production, staging, development, or test."

  validation {
    condition = anytrue([
      var.env == "production",
      var.env == "staging",
      var.env == "development",
      var.env == "test"
    ])
    error_message = "Must be a valid env, can be production, staging, development, or test."
  }
}


variable "hetzner_server_type" {
  type        = string
  description = "Server type to use, see https://www.hetzner.com/cloud#pricing"
  default     = "cx21"

  validation {
    condition = alltrue([
      anytrue([
        can(regex("cx*", var.hetzner_server_type)),
        can(regex("cpx*", var.hetzner_server_type)),
        can(regex("ccx*", var.hetzner_server_type))
      ]),
      anytrue([
        length(var.hetzner_server_type) == 5,
        length(var.hetzner_server_type) == 4
      ])
    ])
    error_message = "Must be a valid Hetzner server type, e.g. cx21, cx11, ccx22 see https://www.hetzner.com/cloud#pricing for available options."
  }
}

variable "hetzner_datacenters" {
  type        = list(string)
  description = "List of datacenter identifier into which the server can be launched, chosen at random"
  default     = ["nbg1", "fsn1"]

  validation {
    condition = alltrue([
      for dc in var.hetzner_datacenters : contains(["nbg1", "fsn1", "hel1"], dc)
    ])
    error_message = "Must one or more of: 'nbg1', 'fsn1', or 'hel1' - no other value is allowed."
  }
}
