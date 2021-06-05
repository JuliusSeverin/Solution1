# This resource creates hosts file in ansible directory. Sets file and directory permisions.
# Also with use of templatefile function and inventory.tmpl file writes ip's into hosts file 
# accordingly to declared variables and .tmpl file schema.  


resource "local_file" "AnsibleInventory" {

  filename             = "ansible/hosts"
  directory_permission = "0600"
  file_permission      = "0600"

  # templatefiles function with vars. Saves ec2 output to hosts file with use of inventory.tmpl

  content = templatefile("${path.cwd}/templates/inventory.tmpl", {
    "vm_dev_name"     = var.vm_dev_name,
    "vm_dev_ip"       = var.vm_dev_ip,
    "vm_dev_priv_ip"  = var.vm_dev_priv_ip,
    "jmp_hst_name"    = var.jmp_hst_name,
    "jmp_hst_ip"      = var.jmp_hst_ip,
    "jmp_hst_priv_ip" = var.jmp_hst_priv_ip,
    "all_hosts"       = "[all]",
    "jmp_hst"         = "[jmp_hst]",
    "jmp_hst_priv"    = "[jmp_hst_priv]",
    "vm_dev"          = "[vm_dev]",
    "vm_dev_priv"     = "[vm_dev_priv]",
    "addprivto"       = "priv"
  })
}
