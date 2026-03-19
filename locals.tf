locals {
#  web_vn = "${var.env}-${var.platform}-${var.vn_web}"
#  db_vn = "${var.env}-${var.platform}-${var.vn_db}"

 ssh_public_key = file(var.vms_ssh_public_key_path)
  
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.user}:${local.ssh_public_key}"
  }
}
