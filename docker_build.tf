# Сборка образа из текущей папки (где лежит Dockerfile)
resource "docker_image" "app" {
  name = "registry-1.docker.io/${var.repo}:${var.tag}"

  build {
    context    = "${path.root}/../app"        # путь к Dockerfile
    dockerfile = "Dockerfile"            # опционально, если имя нестандартное
    no_cache   = false
    pull_parent = true
  }
}

# Пушим в Docker Hub
resource "docker_registry_image" "app" {
  name         = docker_image.app.name
  keep_remotely = true                  # не удалять в реестре при destroy
  depends_on   = [docker_image.app]
}