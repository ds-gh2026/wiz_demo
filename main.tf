terraform {
  required_version = "~>= 1.5.0"

  required_providers {
    random = {
      source = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "random" {}

resource "random_pet" "demo" {
  length = 2
}

output "pet_name" {
  value = random_pet.demo.id
}
