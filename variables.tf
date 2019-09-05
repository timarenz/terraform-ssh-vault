variable "dependencies" {
  type    = list(string)
  default = null
}

variable "host" {
  description = "IP address, hostname or dns name of the machine that should become a Consul agent"
  type        = string
}

variable "username" {
  description = "Username used for SSH connection"
  type        = string
}

variable "ssh_private_key" {
  description = "SSH private key used for SSH connection"
  type        = string
}

variable "vault_binary" {
  description = "Path to Vault binary that should be uploaded. If not specified a version will be download from releases.hashicorp.com"
  type        = string
  default     = null
}

variable "vault_version" {
  description = "Specifices the version of Vault that will be downloaded from releases.hashicorp.com"
  type        = string
  default     = "1.2.1"
}

variable "address" {
  description = "Specifies the address to bind to for listening. (https://www.vaultproject.io/docs/configuration/listener/tcp.html#address)"
  type        = string
  default     = "127.0.0.1:8200"
}

variable "cluster_address" {
  description = "Specifies the address to bind to for cluster server-to-server requests. This defaults to one port higher than the value of address. (https://www.vaultproject.io/docs/configuration/listener/tcp.html#cluster_address)"
  type        = string
  default     = "127.0.0.1:8201"
}

variable "ui" {
  description = "Enable/disable Consul UI"
  type        = bool
  default     = true
}

variable "tls" {
  description = "Configure Vault to use TLS"
  type        = bool
  default     = false
}

variable "tls_cert" {
  description = "For future use"
  type        = string
  default     = null
}

variable "tls_key" {
  description = "For future use"
  type        = string
  default     = null
}

variable "storage" {
  description = "Possible choices are currently only 'raft', 'inmem' and 'file'."
  type        = string
  default     = "file"
}

variable "file_path" {
  description = "The file system path where all the Vault data gets stored."
  type        = string
  default     = "/opt/vault/data"
}

variable "raft_path" {
  description = "The file system path where all the Vault Raft data gets stored."
  type        = string
  default     = "/opt/vault/raft/data"
}

variable "raft_node_id" {
  description = "The identifier for the node in the Raft cluster."
  type        = string
  default     = null
}


