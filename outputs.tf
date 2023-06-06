output "ssh_ubuntu_user" {
  value = join(
    "\n",
    [for i in oci_core_instance.this :
      format(
        "ssh -o StrictHostKeyChecking=no -l ubuntu -p 22 -i %s %s # %s",
        local_file.ssh_private_key.filename,
        i.public_ip,
        i.display_name
      )
    ]
  )
}