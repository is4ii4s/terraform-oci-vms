terraform {
  required_version = "1.4.6"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.114.0"
    }
  }
}