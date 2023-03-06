pid_file = "./pidfile"

vault {
   address = "https://hcp-vault-demo-public-vault-7a4fb99b.6adbf943.z1.hashicorp.cloud:8200"
}

auto_auth {
   method "aws" {
      namespace = "admin"
      mount_path = "auth/aws"
      config = {
          type = "ec2"
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
  source      = "/home/ubuntu/vault-f5-pki-rotation-splunk/vault_agent_config/dev_f5demo_com-template.ctmpl"
  destination = "./prod_f5_demo_payload.json"
  error_on_missing_key=true
  wait = "10s"
  exec {
    command = ["python3", "callPipeline.py"]
    timeout = "120s"
  } 
}