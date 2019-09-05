resource "null_resource" "dependencies" {
  triggers = {
    dependencies = var.dependencies == null ? join(",", []) : join(",", var.dependencies)
  }
}

locals {
  config_file = templatefile("${path.module}/templates/vault.hcl.tpl", {
    address         = var.address
    ui              = var.ui
    tls             = var.tls
    cluster_address = var.cluster_address
    storage         = var.storage
    raft_path       = var.raft_path
    raft_node_id    = var.raft_node_id
    file_path       = var.file_path
    }
  )
}

resource "null_resource" "prereqs" {
  depends_on = ["null_resource.dependencies"]

  connection {
    type        = "ssh"
    host        = var.host
    user        = var.username
    private_key = var.ssh_private_key
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/install-prereqs.sh"
  }
}

resource "null_resource" "download_binary" {
  count      = var.vault_binary == null ? 1 : 0
  depends_on = ["null_resource.prereqs"]

  connection {
    type        = "ssh"
    host        = var.host
    user        = var.username
    private_key = var.ssh_private_key
  }

  provisioner "file" {
    source      = "${path.module}/scripts/download-vault.sh"
    destination = "download-vault.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x download-vault.sh",
      "VAULT_VERSION=${var.vault_version} ./download-vault.sh"
    ]
  }
}

resource "null_resource" "upload_binary" {
  count      = var.vault_binary == null ? 0 : 1
  depends_on = ["null_resource.prereqs"]

  connection {
    type        = "ssh"
    host        = var.host
    user        = var.username
    private_key = var.ssh_private_key
  }

  provisioner "file" {
    source      = var.vault_binary
    destination = "vault"
  }
}

resource "null_resource" "install" {
  depends_on = ["null_resource.download_binary", "null_resource.upload_binary"]

  connection {
    type        = "ssh"
    host        = var.host
    user        = var.username
    private_key = var.ssh_private_key
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/install-vault.sh"
  }
}

resource "null_resource" "configure" {
  depends_on = ["null_resource.install"]

  connection {
    type        = "ssh"
    host        = var.host
    user        = var.username
    private_key = var.ssh_private_key
  }

  provisioner "file" {
    content     = local.config_file
    destination = "vault.hcl"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/configure-vault.sh"
  }
}
