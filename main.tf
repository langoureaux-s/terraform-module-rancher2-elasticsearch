terraform {
  required_version = "= 0.12.17"

  # Live modules pin exact provider version; generic modules let consumers pin the version.
  required_providers {
    rancher2 = "= 1.8.3"
    vault    = "= 2.11.0"
  }
}

locals {
    cluster_id = rancher2_cluster.cluster.id
    project_id = rancher2_project.project.id
}

# Get data
data "rancher2_cluster" "cluster" {
    name = var.cluster_name
}
data "rancher2_project" "project" {
    cluster_id  = local.cluster_id
    name        = var.project_name
}

# Create namespace
resource "rancher2_namespace" "namespace" {
  name = var.namespace
  description = "Elasticsearch namespace"
  project_id  = local.project_id
}

# Create secrets
resource "rancher2_secret" "credentials" {
    name = "elastic-credentials"
    description = "Credentials for Elastic cluster"
    project_id   = local.project_id
    namespace_id = local.namespace_id
    data = {
        ELASTIC_USERNAME                  = base64encode("elastic")
        ELASTIC_PASSWORD                  = base64encode(var.elastic_password)
        ELASTICSEARCH_LDAP_USER           = base64encode(var.ldap_user)
        ELASTICSEARCH_LDAP_PASSWORD       = base64encode(var.ldap_password)
        ELASTICSEARCH_MONITORING_USER     = base64encode(var.monitoring_user)
        ELASTICSEARCH_MONITORING_PASSWORD = base64encode(var.monitoring_password)
        KIBANA_PASSWORD                   = base64encode(var.kibana_password)
        LOGSTASH_SYSTEM_PASSWORD          = base64encode(var.logstash_system_password)
    }
}
resource "rancher2_secret" "certificats" {
    name = "elastic-certificates"
    description = "Certificats for Elastic cluster"
    project_id   = local.project_id
    namespace_id = local.namespace_id
    data = {
        elastic-certificates.p12 = base64encode(var.certificates-p12)
    }
}

# Create Elasticsearch with all roles
resource "rancher2_app" "elasticsearch" {
    catalog_name     = var.catalog_name
    name             = var.name
    description      = var.description
    project_id       = local.project_id
    template_name    = var.template_name
    template_version = var.template_version
    target_namespace = rancher2_namespace.namespace
    annotations      = var.annotations
    labels           = var.labels
    values_yaml      = base64encode(var.values)
    
    depends_on = ["rancher2_secret.credentials", "rancher2_secret.certificats"]
}