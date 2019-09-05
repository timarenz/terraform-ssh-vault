
output "config_file" {
  value = local.config_file
}

output "id" {
  value = null_resource.configure.id
}
