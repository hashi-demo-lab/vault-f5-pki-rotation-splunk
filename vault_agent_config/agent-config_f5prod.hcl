pid_file = "./pidfile"

vault {
   address = "https://hcp-vault-demo-public-vault-457f3ef0.5ef008f8.z1.hashicorp.cloud:8200"
}

auto_auth {
   method "aws" {
      mount_path = "auth/aws"
      config = {
          type = "iam"
          role = "f5-device-role"
      }
  }

   sink "file" {
       config = {
           path = "tempToken"
       }
   }
}

template {
  source      = "/home/ubuntu/vault-f5-pki-rotation-splunk/vault_agent_config/resttemplate_f5prod.ctmpl"
  destination = "./prod_f5_prod_payload.json"
  error_on_missing_key=true
  wait = "10s"
  exec {
    command = ["python3", "callPipeline.py"]
    timeout = "120s"
  } 
}