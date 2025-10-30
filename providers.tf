terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }    

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    helm = {
      source = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
  required_version = ">= 1.8.4"
}

provider "yandex" {
  cloud_id                 = "b1g8ta6qu7na0ir2khnv"
  folder_id                = "b1g8kve3609ag8bp327e"
  service_account_key_file = file("~/.authorized_key.json")
  zone                     = "ru-central1-a" #(Optional) 
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

provider "docker" {
  registry_auth {
    address  = "registry-1.docker.io"
    username = var.dockerhub_username
    password = var.dockerhub_password
  }
}

data "yandex_client_config" "client" {}

provider "kubernetes" {
  host                   = yandex_kubernetes_cluster.my_cluster.master[0].external_v4_endpoint
  cluster_ca_certificate = yandex_kubernetes_cluster.my_cluster.master[0].cluster_ca_certificate
  token                  = data.yandex_client_config.client.iam_token
}

provider "helm" {
  kubernetes = {
    host                   = yandex_kubernetes_cluster.my_cluster.master[0].external_v4_endpoint
    cluster_ca_certificate = yandex_kubernetes_cluster.my_cluster.master[0].cluster_ca_certificate
    token                  = data.yandex_client_config.client.iam_token
  }
}
