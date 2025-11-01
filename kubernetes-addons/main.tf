resource "google_compute_address" "ingress" {
  count   = var.deploy_nginx ? 1 : 0
  name    = format("%s-ingress-ip", var.cluster_name)
  project = var.project_id
  region  = var.region
}

resource "kubernetes_namespace_v1" "app_namespace" {
  count = var.create_app_namespace ? 1 : 0
  metadata {
    name = var.app_namespace
  }
}


module "nginx-controller" {
  count  = var.deploy_nginx ? 1 : 0
  source = "terraform-iaac/nginx-controller/helm"
  atomic = true
  ip_address = google_compute_address.ingress[0].address

}

resource "helm_release" "sealed_secrets" {
  count            = var.install_sealed_secrets ? 1 : 0
  name             = "sealed-secrets"
  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  create_namespace = true
}
