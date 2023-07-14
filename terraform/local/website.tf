resource "docker_image" "recipy_website" {
  name = "chauss/recipy-website:alpha-0.0.1"
}

resource "docker_container" "recipy_website" {
  image    = docker_image.recipy_website.image_id
  name     = local.web_container_name
  restart  = "always"
  hostname = local.web_container_name
  ports {
    internal = "80"
    external = "80"
  }
}