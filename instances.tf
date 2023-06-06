data "oci_identity_availability_domains" "this" {
  compartment_id = data.oci_identity_compartment.this.id
}

#data "oci_core_images" "this" {
#  compartment_id           = data.oci_identity_compartment.this.id
#  shape                    = var.shape
#  operating_system         = var.os
#  operating_system_version = var.os_version
#}

resource "oci_core_instance" "this" {
  for_each = local.nodes
  display_name = each.value.node_name
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[var.availability_domain].name
  compartment_id      = data.oci_identity_compartment.this.id
  shape               = var.shape

  shape_config {
    ocpus = var.cpus
    memory_in_gbs = var.memory
  }

  source_details {
    #source_id   = data.oci_core_images.this.images[0].id
    source_id = var.source_id
    source_type = "image"
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.this.id
    private_ip = each.value.ip_address
  }

  metadata = {
    ssh_authorized_keys = join("\n", local.authorized_keys)
  }

  connection {
    host = self.public_ip
    user = "ubuntu"
    private_key = tls_private_key.ssh.private_key_pem
  }
}