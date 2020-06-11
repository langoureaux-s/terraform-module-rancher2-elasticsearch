variable "cluster_name" {
    description = "Cluster name where to deploy elastic"
    type        = string
}

variable "project_name" {
    description = "Project name where to deploy elastic"
    type        = string
}

variable "namespace" {
    description = "Namespace where to deploy elastic"
    type        = string
}

variable "catalog_name" {
    description = "Catalog name used to deploy elastic"
    default     = "hm"
    type        = string
}

variable "template_name" {
    description = "Template name used to deploy elastic"
    default     = "elasticsearch"
    type        = string
}

variable "template_version" {
    description = "Template version used to deploy elastic"
    type        = string
}

variable "name" {
    description = "Application name"
    default     = "elasticsearch"
    type        = string
}

variable "description" {
    description = "Application description"
    default     = "Elasticsearch with all roles"
    type        = string
}

variable "values" {
    description = "Values contend used when invoke helm"
    type        = string
}

variable "annotations" {
    description = "Annotations to add on application"
    default     = {}
    type        = map
}

variable "labels" {
    description = "Labels to add on application"
    default     = {}
    type        = string
}

variable "elastic_password" {
    description = "The password for Elastic"
    type        = string
}

variable "ldap_user" {
    description = "The LDAP user"
    type        = string
}

variable "ldap_password" {
    description = "The LDAP password"
    type        = string
}

variable "monitoring_user" {
    description = "The monitoring user"
    default     = ""
    type        = string
}

variable "monitoring_password" {
    description = "The monitoring password"
    default     = ""
    type        = string
}

variable "kibana_password" {
    description = "The kibana password"
    type        = string
}

variable "logstash_system_password" {
    description = "The logstash system password"
    type        = string
}

variable "certificates-p12" {
    description = "The certificates contend in P12 format"
    type        = string
}