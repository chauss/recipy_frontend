terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # Enable for windows
  # host = "npipe:////.//pipe//docker_engine"
}
