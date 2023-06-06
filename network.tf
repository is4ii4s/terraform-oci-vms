data "oci_identity_compartment" "this" {
  id = oci_identity_compartment.this.id
}

resource "oci_core_vcn" "this" {
  compartment_id = data.oci_identity_compartment.this.id
  cidr_block     = "10.83.0.0/20"
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = data.oci_identity_compartment.this.id
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_vcn.this.default_route_table_id
  route_rules {
    network_entity_id = oci_core_internet_gateway.this.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_default_security_list" "this" {
  manage_default_resource_id = oci_core_vcn.this.default_security_list_id
  ingress_security_rules {
    protocol = "all"
    source   = "0.0.0.0/0"
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

resource "oci_core_subnet" "this" {
  cidr_block        = "10.83.0.0/24"
  compartment_id    = data.oci_identity_compartment.this.id
  vcn_id            = oci_core_vcn.this.id
  route_table_id    = oci_core_default_route_table.this.id
  security_list_ids = [oci_core_default_security_list.this.id]
}