terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
 # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
     resource_group_name   = "som-terraform-storage-rg"
     storage_account_name  = "terraformstate3tier"
     container_name        = "tfstatefiles"
     key                   = "3tier-som-terraform.tfstate"
   }   
}
provider "azurerm" {
  features {}

 ## subscription_id   = "35b0fa4f-b6ba-4752-87a9-d644b3f23b8b"
 # tenant_id         = "008e45fa-c27b-4574-aefd-9adb4a37493f"
 # client_id         = "d3614534-118d-40ff-955f-2fa44e25777f"
 # client_secret     = ".v58Q~~Iu-Sz4XujfueVXhUgR3AjAkMBE7QTBbeR"
}
# Terraform State Storage to Azure Storage Container
#  backend "azurerm" {
 #   resource_group_name   = "som-terraform-storage-rg"
  #  storage_account_name  = "terraformstate3tier"
 #   container_name        = "tfstatefiles"
 #   key                   = "3tier-som-terraform.tfstate"
  #}   

module "resourcegroup" {
  source         = "./modules/resourcegroup"
  name           = var.name
  location       = var.location
}

module "networking" {
  source         = "./modules/networking"
  location       = module.resourcegroup.location_id
  resource_group = module.resourcegroup.resource_group_name
  vnetcidr       = var.vnetcidr
  websubnetcidr  = var.websubnetcidr
  appsubnetcidr  = var.appsubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
}

module "securitygroup" {
  source         = "./modules/securitygroup"
  location       = module.resourcegroup.location_id
  resource_group = module.resourcegroup.resource_group_name 
  web_subnet_id  = module.networking.websubnet_id
  app_subnet_id  = module.networking.appsubnet_id
  db_subnet_id   = module.networking.dbsubnet_id
}

module "compute" {
  source         = "./modules/compute"
  location = module.resourcegroup.location_id
  resource_group = module.resourcegroup.resource_group_name
  web_subnet_id = module.networking.websubnet_id
  app_subnet_id = module.networking.appsubnet_id
  web_host_name = var.web_host_name
  web_username = var.web_username
  web_os_password = var.web_os_password
  app_host_name = var.app_host_name
  app_username = var.app_username
  app_os_password = var.app_os_password
}

module "database" {
  source = "./modules/database"
  location = module.resourcegroup.location_id
  resource_group = module.resourcegroup.resource_group_name
  primary_database = var.primary_database
  primary_database_version = var.primary_database_version
  primary_database_admin = var.primary_database_admin
  primary_database_password = var.primary_database_password
}
