pid_file = "./pidfile"

vault {
   address = "http://192.168.86.247:8200"
}

auto_auth {
   method "approle" {
       mount_path = "auth/approle"
       config = {
           role_id_file_path = "roleID"
           secret_id_file_path = "secretID"
           remove_secret_id_file_after_reading = false
       }
   }

   sink "file" {
       config = {
           path = "approleToken"
       }
   }
}

template {
  source      = "./certs.ctmpl"
  destination = "./certs.json"
  command = "bash f5-magic.sh"
}

template {
    source = "./certmanagement.tmpl"
    destination = "./certmanagement.json"
}
