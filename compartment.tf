resource "oci_identity_compartment" "this" {
  description = local.name
  name        = local.name
}
