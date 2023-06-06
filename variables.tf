variable "project" {
  type    = string
  default = "k8s"
}

variable "shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "nodes_count" {
  type    = number
  default = 2
}

variable "availability_domain" {
  type    = number
  default = 0
}

variable "cpus" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 12
}

#variable "os" {
#  type    = string
#  default = "Canonical Ubuntu"
#}
#
#variable "os_version" {
#  type    = string
#  default = "22.04"
#}

variable "source_id" {
  type = string
  default = "ocid1.image.oc1.phx.aaaaaaaalz4kuyiaw2og7u5pg53f2ebbtoh6vp5kldo6gxtl3ztv2auykx2q"
}