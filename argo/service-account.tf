locals {
  sa_roles = [
    "roles/container.developer"
  ]
  argocd_server_sa = "argocd-server"
  argocd_application_controller_sa = "argocd-application-controller"
}

# Create argocd google service account
resource "google_service_account" "argocd_service_account" {
  account_id   = var.argocd_gcp_sa_name
  display_name = "Service account for argocd"
}

resource "google_project_iam_member" "argocd_service_account_members" {
  for_each = toset(compact(distinct(concat(local.sa_roles))))
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.argocd_service_account.email}"
}


# Add workload identity user
resource "google_project_iam_member" "argocd_application_controller_workload_identity_role" {
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.argocd_namespace}/argocd-application-controller]"
  project = var.project_id
}

resource "google_project_iam_member" "argocd_server_workload_identity_role" {
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.argocd_namespace}/argocd-server]"
  project = var.project_id
}

# resource "kubernetes_manifest" "argocd_application_controller_sa_annotation" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind"       = "ServiceAccount"
#     "metadata" = {
#       "name"      = "argocd-application-controller"
#       "namespace" = "argocd"
#       "annotations" = {
#         "iam.gke.io/gcp-service-account" = "${var.argocd_gcp_sa_name}@${var.project_id}.iam.gserviceaccount.com"
#       }
#     }
#   }
# }

# resource "kubernetes_manifest" "argocd_server_sa_annotation" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind"       = "ServiceAccount"
#     "metadata" = {
#       "name"      = "argocd-server"
#       "namespace" = "argocd"
#       "annotations" = {
#         "iam.gke.io/gcp-service-account" = "${var.argocd_gcp_sa_name}@${var.project_id}.iam.gserviceaccount.com"
#       }
#     }
#   }
# }

# resource "kubernetes_service_account" "argocd_server" {
#   depends_on = [ helm_release.argocd ]
#   metadata {
#     name      = "argocd-server"
#     namespace = var.argocd_namespace
#     annotations = {
#       "iam.gke.io/gcp-service-account" = "${var.argocd_gcp_sa_name}@${var.project_id}.iam.gserviceaccount.com"
#     }
#   }
# }

# resource "kubernetes_service_account" "argocd_application_controller_server" {
#   depends_on = [ helm_release.argocd ]
#   metadata {
#     name      = "argocd-application-controller"
#     namespace = var.argocd_namespace
#     annotations = {
#       "iam.gke.io/gcp-service-account" = "${var.argocd_gcp_sa_name}@${var.project_id}.iam.gserviceaccount.com"
#     }
#   }
# }