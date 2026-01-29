job "trivy-vuln-scan" {
  datacenters = ["dc1"]
  type        = "batch"

  group "scanner" {
    count = 1

    task "trivy" {
      driver = "docker"

      config {
        image = "aquasec/trivy:latest"
        # In a real CI, you might scan an image from a registry or a local tarball
      }

      # Environment variables for private registry auth if needed
      # (Credentials should be injected via protected secrets)

      # Scan a public image as an example
      command = "trivy"
      args = [
        "image",
        "--exit-code", "1", 
        "--severity", "HIGH,CRITICAL", 
        "python:3.9-alpine"
      ]

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}
