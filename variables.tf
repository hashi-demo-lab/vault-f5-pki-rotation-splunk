// generic variables

variable "deployment_name" {
  description = "Deployment name, used to prefix resources"
  type        = string
  default     = ""
}

variable "customer_domain" {
  description = "This is the url that will be created customer_domain.com"
  default     = "f5demo.com"
}

// hashicorp identification variables

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
  default     = ""
}

variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
  default     = 48
}

// hashicorp cloud platform (hcp) variables

variable "hcp_region" {
  description = "HCP region"
  type        = string
  default     = ""
}

variable "hcp_client_id" {
  description = "HCP client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "HCP client secret"
  type        = string
  default     = ""
}

variable "hcp_hvn_cidr" {
  description = "HCP HVN cidr"
  type        = string
  default     = "172.25.16.0/20"
}

variable "hcp_vault_tier" {
  description = "HCP Vault cluster tier"
  type        = string
  default     = "dev"
}

// amazon web services (aws) variables

variable "ingress_cidr_blocks" {
  description = "ingress allow list"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "aws_key_pair_key_name" {
  description = "Key pair name"
  type        = string
  default     = ""
}

variable "ssh_pubkey" {
  description = "SSH public key"
  type        = string
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.200.0.0/16"
}

variable "aws_private_subnets" {
  description = "AWS private subnets"
  type        = list(any)
  default     = ["10.200.20.0/24", "10.200.21.0/24", "10.200.22.0/24"]
}

variable "aws_public_subnets" {
  description = "AWS public subnets"
  type        = list(any)
  default     = ["10.200.10.0/24", "10.200.11.0/24", "10.200.12.0/24"]
}

variable "aws_eks_cluster_version" {
  description = "AWS EKS cluster version"
  type        = string
  default     = "1.22"
}

variable "aws_eks_cluster_service_cidr" {
  description = "AWS EKS cluster service cidr"
  type        = string
  default     = "172.20.0.0/18"
}

variable "aws_eks_worker_instance_type" {
  description = "AWS EKS EC2 worker node instance type"
  type        = string
  default     = "m5.large"
}

variable "aws_eks_worker_desired_capacity" {
  description = "AWS EKS desired worker capacity in the autoscaling group"
  type        = number
  default     = 2
}

variable "aws_ami_hashicups_product_api_db" {
  description = "AWS AMI for hashicups product-api-db"
  type        = string
  default     = "ami-082c7add2ac0c19f6"
}

// google cloud platform (gcp) variables

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = ""
}

variable "gcp_project_id" {
  description = "GCP project id"
  type        = string
  default     = ""
}

variable "gcp_private_subnets" {
  description = "GCP private subnets"
  type        = list(any)
  default     = ["10.210.20.0/24", "10.210.21.0/24", "10.210.22.0/24"]
}

variable "gcp_gke_pod_subnet" {
  description = "GCP GKE pod subnet"
  type        = string
  default     = "10.211.20.0/23"
}

variable "gcp_gke_cluster_service_cidr" {
  description = "GCP GKE cluster service cidr"
  type        = string
  default     = "172.20.0.0/18"
}

# Organization level variables
variable "organization" {
  description = "TFC Organization to build under"
  type        = string
}

#### F5 Variables

variable "prefix" {
  description = "F5 - prefix for resources"
  type        = string
  default     = "bigip-aws-1nic"
}


## Vault PKI Variables

variable "customername" {
  description = "Customer Demo Name"
  type        = string
  default     = "acme"
}

## TFC Agent Variables


variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for taggable AWS resources."
  default     = {}
}

variable "region" {
  type        = string
  description = "The AWS Region to deploy resources into."
  default     = "us-east-1"
}


#--------------------------------------------------------------------------------------------------
# Cloud Agents
#--------------------------------------------------------------------------------------------------
variable "tfc_agent_token" {
  type        = string
  description = "Agent pool token to authenticate to TFC/TFE when cloud agents are instantiated."
}


variable "tfc_agent_prefix" {
  type        = string
  description = "Agent pool token to authenticate to TFC/TFE when cloud agents are instantiated."
  default = "tfc_agent"
}

variable "tfc_agent_name" {
  type        = string
  description = "The name of the agent."
  default     = "ecs-agent"
}

variable "tfc_agent_version" {
  type        = string
  description = "Version of tfc-agent to run."
  default     = "1.4.0"
}

variable "tfc_address" {
  type        = string
  description = "Hostname of self-hosted TFE instance. Leave default if TFC is in use."
  default     = "app.terraform.io"
}

variable "number_of_agents" {
  type        = number
  description = "Number of cloud agents to run per instance."
  default     = 1
}

variable "assign_public_ip" {
  type        = bool
  description = "Only required when using Fargate for ECS services placed in public subnets. Needed for fargate to assign ENI and pull docker image. True or False"
  default     = "false"
}

variable "agent_image" {
  type        = string
  description = "The registry/image:tag_Version to use for the agent. Default = hashicorp/tfc-agent:latest"
  default     = "hashicorp/tfc-agent:latest"
}

variable "agent_log_level" {
  type        = string
  description = "The log verbosity. Level options include 'trace', 'debug', 'info', 'warn', and 'error'. Log levels have a progressive level of data sensitivy. The 'info', 'warn', and 'error' levels are considered generally safe for log collection and don't include sensitive information. The 'debug' log level may include internal system details, such as specific commands and arguments including paths to user data on the local filesystem. The 'trace' log level is the most sensitive and may include personally identifiable information, secrets, pre-authorized internal URLs, and other sensitive material."
  default     = "info"
}

variable "enable_logs" {
  type        = bool
  description = "Whether or not to enable tfc-agent ECS logs."
  default     = true
}

variable "cpu" {
  type        = number
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  default     = 1024
}

variable "memory" {
  type        = number
  description = "Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  default     = 2048
}



### workspace variables



/* # Workspace level variables
variable "workspace_name" {
  description = "Name of the workspace to create"
  type        = string
}

variable "workspace_description" {
  description = "Description of workspace"
  type        = string
  default     = ""
}

variable "workspace_terraform_version" {
  description = "Version of Terraform to run"
  type        = string
  default     = "latest"
}

variable "workspace_tags" {
  description = "Tags to apply to workspace"
  type        = list(string)
  default     = []
}


## VCS variables (existing VCS connection)
variable "vcs_repo" {
  description = "(Optional) - Map of objects that will be used when attaching a VCS Repo to the Workspace. "
  default     = {}
  type        = map(string)
}

variable "workspace_vcs_directory" {
  description = "Working directory to use in repo"
  type        = string
  default     = "root_directory"
}

# Variables
variable "variables" {
  description = "Map of all variables for workspace"
  type        = map(any)
  default = {
    "CLOUD_PROVIDER_AWS" : {
      "value" : "true",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "VAULT_PATH" : {
      "value" : "aws-dynamic-credentials",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_VAULT_APPLY_ROLE" : {
      "value" : "vault-demo-assumed-role",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_VAULT_PLAN_ROLE" : {
      "value" : "vault-demo-assumed-role",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_WORKLOAD_IDENTITY_AUDIENCE" : {
      "value" : "vault.workload.identity",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "VAULT_ADDR" : {
      "value" : "http://localhost:8200",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    }
  }
}

variable "create_project" {
  description = "(Optional) Boolean that allows for the creation of a Project in Terraform Cloud that the workspace will use. This feature is in beta and currently doesn't have a datasource"
  type        = bool
  default     = false
}

variable "project_name" {
  description = "(Optional) Name of the Project that is created in Terraform Cloud if var.create_project is set to true. Note this is currently in beta"
  type        = string
  default     = ""
}

variable "assessments_enabled" {
  description = "(Optional) Boolean that enables heath assessments on the workspace"
  type        = bool
  default     = false
} */

# # RBAC
# ## Workspace owner (exising org user)
# variable "workspace_owner_email" {
#   description = "Email for the owner of the account"
#   type        = string
# }

/* ## Additional read users (existing org user)
variable "workspace_read_access_emails" {
  description = "Emails for the read users"
  type        = list(string)
  default     = []
}

## Additional write users (existing org user)
variable "workspace_write_access_emails" {
  description = "Emails for the write users"
  type        = list(string)
  default     = []
}

## Additional plan users (existing org user)
variable "workspace_plan_access_emails" {
  description = "Emails for the plan users"
  type        = list(string)
  default     = []
}

variable "agent_pool_name" {
  type        = string
  description = "(Optional) Name of the agent pool that will be created or used"
  default     = null
}

variable "workspace_agents" {
  type        = bool
  description = "(Optional) Conditional that allows for the use of existing or new agents within a given workspace"
  default     = true
}

variable "workspace_auto_apply" {
  type        = string
  description = "(Optional)  Setting if the workspace should automatically apply changes when a plan succeeds."
  default     = true
}

variable "execution_mode" {
  type        = string
  description = "Defines the execution mode of the Workspace. Defaults to remote"
  default     = "agent"
}

variable "remote_state" {
  type        = bool
  description = "(Optional) Boolean that enables the sharing of remote state between this workspace and other workspaces within the environment"
  default     = false
}

variable "remote_state_consumers" {
  type        = set(string)
  description = "(Optional) Set of remote IDs of the workspaces that will consume the state of this workspace"
  default     = [""]
} */