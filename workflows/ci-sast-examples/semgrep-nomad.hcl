job "semgrep-sast-scan" {
  datacenters = ["dc1"]
  type        = "batch"

  group "scanner" {
    count = 1

    task "semgrep" {
      driver = "docker"

      config {
        image = "returntocorp/semgrep:latest"
        # Mount the source code directory. 
        # In a real CI, this would likely be an artifact download or a volume from a previous step.
        volumes = [
          "local/repo:/src"
        ]
      }

      # Run Semgrep with default configuration against the mounted source
      env {
        SEMGREP_RULES = "p/default"
      }

      template {
        data = <<EOH
        # Script to run semgrep and output results
        semgrep scan --config auto --json --output results.json /src
        EOH
        destination = "local/run_scan.sh"
        perms = "755"
      }

      # Depending on the image entrypoint, you might need to override the command
      # command = "/bin/sh"
      # args    = ["local/run_scan.sh"]
      
      # Simple default execution for demonstration
      command = "semgrep"
      args = ["scan", "--config", "auto", "--error", "/src"]

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}
