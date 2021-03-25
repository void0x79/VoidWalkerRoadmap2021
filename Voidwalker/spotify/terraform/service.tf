# Configure Kubernetes to run the vault service locally via helm chart.
# Configure Helm + K8 via terraform

resource "kubernetes_namespace" "spotify" {
    metadata {
        name = var.service_ns
    }
}

resource "helm_release" "vault_server" {
    name       = "vault-server"
    repository = "https://helm.releases.hashicorp.com"
    chart      = "vault"
    namespace  = var.service_ns
}

resource "null_resource" "creds_gen" {
    depends_on = [helm_release.vault_server]
    provisioner "local-exec" {
        command = "/bin/bash creds_gen.sh"
        interpreter = ["/bin/bash", "-c"]
    }
}

# Port forward 8200:8200
output "port_forward_message" {
    depends_on = [helm_release.vault_server]
    value = "TO ACCESS VAULT RUN: kubectl port-forward vault-server-0 -n spotify 8200:8200"
}