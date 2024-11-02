resource "helm_release" "argo_apps" {
  count            = var.argo_apps ? 1 : 0
  depends_on       = [htpasswd_password.hash, helm_release.argocd]
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  create_namespace = true
  namespace        = var.argocd_namespace
  version          = "0.0.8"

  values = [
    var.argo_apps_values
  ]
}