locals {
  name = "oci${var.project}"
}

locals {
  nodes = {
    for i in range(1, 1 + var.nodes_count) :
    i => {
      node_name  = format("${local.name}0%d", i)
      ip_address = format("10.83.0.%d", 10 + i)
    }
  }
}