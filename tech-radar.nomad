job "tech-radar" {
  datacenters = ["dc1"]
  type = "service"

  group "tech-radar" {
    count = "1"
    network {
      mode = "bridge"
    }
    service {
      name = "${NOMAD_GROUP_NAME}"
      port = 80

      tags = [
        "app",
        "traefik.http.routers.techradar.entrypoints=web",
        "traefik.http.routers.techradar.rule=Host(`tech-radar.[[ or (env "SUB_DOMAIN") .subdomain ]].alexanderhopgood.com`)",
        "traefik.http.routers.techradar.middlewares=local-network@consulcatalog,https-redirect@consulcatalog",
        "traefik.http.routers.techradar-secure.entrypoints=secure",
        "traefik.http.routers.techradar-secure.rule=Host(`tech-radar.[[ or (env "SUB_DOMAIN") .subdomain ]].alexanderhopgood.com`)",
        "traefik.http.routers.techradar-secure.middlewares=local-network@consulcatalog",
        "traefik.http.routers.techradar-secure.tls=true",
        "traefik.http.routers.techradar-secure.tls.certresolver=myletsencryptresolver",
        "traefik.consulcatalog.connect=true",
        "traefik.enable=true"

      ]

      connect {
        sidecar_service {}
      }
    }

    task "tech-radar" {

      driver = "docker"
      env {
        SERVER_NAMES = "localhost 127.0.0.1 tech-radar.[[ or (env "SUB_DOMAIN") .subdomain ]].alexanderhopgood.com"
      }

      config {
        image = "[[ or (env "DOCKER_REGISTRY_ADDRESS") .docker.registry.address ]]/[[ or (env "DOCKER_REGISTRY_NAMESPACE") .docker.registry.namespace ]]build-your-own-radar:[[ or (env "TECH_RADAR_VERSION") .tech_radar.version ]]"
        ports = ["http"]
        auth {
          username = "[[ or (env "DOCKER_REGISTRY_USERNAME") .docker.registry.username ]]"
          password = "[[ or (env "DOCKER_REGISTRY_PASSWORD") .docker.registry.password ]]"
        }
      }
    }
  }
}
