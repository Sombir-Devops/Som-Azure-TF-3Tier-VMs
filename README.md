# Terraform modular code to deploy 3-Tier Architecture on Azure cloud

## Problem Statement
A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources on a cloud environment (Azure/AWS/GCP). Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.
1. One virtual network tied in three subnets
2. Each subnet will have one virtual machine
3. First virtual machine -> allow inbound traffic from internet only
4. Second virtual machine -> entertain traffic from first virtual machine only and can reply the same virtual machine again
5. App can connect to database and database can connect to app but database cannot connect to web



## Solution
_Note: I have designd the solution using Terraform modules to increase useability and also have kept Terraform state and .terraform directory as a refrence of execution_

### The Terraform resources will consists of following structure

```
├── main.tf                   // The primary entrypoint for terraform resources
├── vars.tf                   // It contain the declarations for variables
├── output.tf                 // It contain the declarations for outputs
├── terraform.tfvars          // The file to pass the terraform variables values
```

### Modules

For the solution, I have created and used five modules:
1. resourcegroup - creating resourcegroup
2. networking - creating azure virtual network and required subnets
3. securitygroup - creating network security group, setting desired security rules and associating them to subnets
4. compute - creating availability sets, network interfaces and virtual machines
5. database - creating database server and database

All the stacks are placed in the modules folder and the variables are stored under **terraform.tfvars**

To run the code you need to append the variables in the terraform.tfvars

Each module consists minimum two files: main.tf, vars.tf


## Deployment

### Steps

**Step 0** `terraform init`

used to initialize modules,backend,provider plugins

**Step 1** `terraform plan`

used to create an execution plan

**Step 2** `terraform validate`

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

**Step 3** `terraform apply --auto-approve`

used to apply the changes required to reach the desired state of the configuration

**Step 4** `terraform destroy --auto-approve`

used to delete the created infrastructure

## Execution output:
C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>terraform init

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 2.0"...
- Installing hashicorp/azurerm v2.99.0...
- Installed hashicorp/azurerm v2.99.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>terraform plan
Stopping operation...

Interrupt received.
Please wait for Terraform to exit or data loss may occur.
Gracefully shutting down...


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Unable to list provider registration status, it is possible that this is due to invalid credentials or the service principal does not have permission to use the Resource Manager API, Azure error: resources.ProvidersClient#List: Failure sending request: StatusCode=0 -- Original Error: context canceled
│
│   with provider["registry.terraform.io/hashicorp/azurerm"],
│   on main.tf line 10, in provider "azurerm":
│   10: provider "azurerm" {
│
╵

C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>
C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>
C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.compute.azurerm_availability_set.app_availabilty_set will be created
  + resource "azurerm_availability_set" "app_availabilty_set" {
      + id                           = (known after apply)
      + location                     = "centralindia"
      + managed                      = true
      + name                         = "app_availabilty_set"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
    }

  # module.compute.azurerm_availability_set.web_availabilty_set will be created
  + resource "azurerm_availability_set" "web_availabilty_set" {
      + id                           = (known after apply)
      + location                     = "centralindia"
      + managed                      = true
      + name                         = "web_availabilty_set"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
    }

  # module.compute.azurerm_network_interface.app-net-interface will be created
  + resource "azurerm_network_interface" "app-net-interface" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "app-network"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "Som-Azure-TF-3Tier-VMs"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "app-webserver"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # module.compute.azurerm_network_interface.web-net-interface will be created
  + resource "azurerm_network_interface" "web-net-interface" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "web-network"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "Som-Azure-TF-3Tier-VMs"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "web-webserver"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # module.compute.azurerm_virtual_machine.app-vm will be created
  + resource "azurerm_virtual_machine" "app-vm" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "som-app-vm"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + vm_size                          = "Standard_D2s_v3"

      + os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "app-disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.compute.azurerm_virtual_machine.web-vm will be created
  + resource "azurerm_virtual_machine" "web-vm" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "som-web-vm"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + vm_size                          = "Standard_D2s_v3"

      + os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "som-web-disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.database.azurerm_sql_database.db will be created
  + resource "azurerm_sql_database" "db" {
      + collation                        = (known after apply)
      + create_mode                      = "Default"
      + creation_date                    = (known after apply)
      + default_secondary_location       = (known after apply)
      + edition                          = (known after apply)
      + elastic_pool_name                = (known after apply)
      + encryption                       = (known after apply)
      + extended_auditing_policy         = (known after apply)
      + id                               = (known after apply)
      + location                         = "centralindia"
      + max_size_bytes                   = (known after apply)
      + max_size_gb                      = (known after apply)
      + name                             = "somdb"
      + read_scale                       = false
      + requested_service_objective_id   = (known after apply)
      + requested_service_objective_name = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + restore_point_in_time            = (known after apply)
      + server_name                      = "som-primary-database"
      + source_database_deletion_date    = (known after apply)
      + source_database_id               = (known after apply)
    }

  # module.database.azurerm_sql_server.primary will be created
  + resource "azurerm_sql_server" "primary" {
      + administrator_login          = "somsqladmin"
      + administrator_login_password = (sensitive value)
      + connection_policy            = "Default"
      + extended_auditing_policy     = (known after apply)
      + fully_qualified_domain_name  = (known after apply)
      + id                           = (known after apply)
      + location                     = "centralindia"
      + name                         = "som-primary-database"
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
      + version                      = "12.0"
    }

  # module.networking.azurerm_subnet.app-subnet will be created
  + resource "azurerm_subnet" "app-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-app-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_subnet.db-subnet will be created
  + resource "azurerm_subnet" "db-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.3.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-db-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_subnet.web-subnet will be created
  + resource "azurerm_subnet" "web-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-web-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_virtual_network.vnet01 will be created
  + resource "azurerm_virtual_network" "vnet01" {
      + address_space         = [
          + "192.168.0.0/16",
        ]
      + dns_servers           = (known after apply)
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "centralindia"
      + name                  = "somvnet3TierVMs"
      + resource_group_name   = "Som-Azure-TF-3Tier-VMs"
      + subnet                = (known after apply)
      + vm_protection_enabled = false
    }

  # module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs will be created
  + resource "azurerm_resource_group" "Som-Azure-TF-3Tier-VMs" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "Som-Azure-TF-3Tier-VMs"
    }

  # module.securitygroup.azurerm_network_security_group.app-nsg will be created
  + resource "azurerm_network_security_group" "app-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-app-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_network_security_group.db-nsg will be created
  + resource "azurerm_network_security_group" "db-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-db-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.2.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 102
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.2.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-3"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_network_security_group.web-nsg will be created
  + resource "azurerm_network_security_group" "web-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-web-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.3.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

Plan: 19 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.

C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.compute.azurerm_availability_set.app_availabilty_set will be created
  + resource "azurerm_availability_set" "app_availabilty_set" {
      + id                           = (known after apply)
      + location                     = "centralindia"
      + managed                      = true
      + name                         = "app_availabilty_set"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
    }

  # module.compute.azurerm_availability_set.web_availabilty_set will be created
  + resource "azurerm_availability_set" "web_availabilty_set" {
      + id                           = (known after apply)
      + location                     = "centralindia"
      + managed                      = true
      + name                         = "web_availabilty_set"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
    }

  # module.compute.azurerm_network_interface.app-net-interface will be created
  + resource "azurerm_network_interface" "app-net-interface" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "app-network"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "Som-Azure-TF-3Tier-VMs"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "app-webserver"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # module.compute.azurerm_network_interface.web-net-interface will be created
  + resource "azurerm_network_interface" "web-net-interface" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "web-network"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "Som-Azure-TF-3Tier-VMs"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "web-webserver"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # module.compute.azurerm_virtual_machine.app-vm will be created
  + resource "azurerm_virtual_machine" "app-vm" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "som-app-vm"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + vm_size                          = "Standard_D2s_v3"

      + os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "app-disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.compute.azurerm_virtual_machine.web-vm will be created
  + resource "azurerm_virtual_machine" "web-vm" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "som-web-vm"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + vm_size                          = "Standard_D2s_v3"

      + os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "som-web-disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.database.azurerm_sql_database.db will be created
  + resource "azurerm_sql_database" "db" {
      + collation                        = (known after apply)
      + create_mode                      = "Default"
      + creation_date                    = (known after apply)
      + default_secondary_location       = (known after apply)
      + edition                          = (known after apply)
      + elastic_pool_name                = (known after apply)
      + encryption                       = (known after apply)
      + extended_auditing_policy         = (known after apply)
      + id                               = (known after apply)
      + location                         = "centralindia"
      + max_size_bytes                   = (known after apply)
      + max_size_gb                      = (known after apply)
      + name                             = "somdb"
      + read_scale                       = false
      + requested_service_objective_id   = (known after apply)
      + requested_service_objective_name = (known after apply)
      + resource_group_name              = "Som-Azure-TF-3Tier-VMs"
      + restore_point_in_time            = (known after apply)
      + server_name                      = "som-primary-database"
      + source_database_deletion_date    = (known after apply)
      + source_database_id               = (known after apply)
    }

  # module.database.azurerm_sql_server.primary will be created
  + resource "azurerm_sql_server" "primary" {
      + administrator_login          = "somsqladmin"
      + administrator_login_password = (sensitive value)
      + connection_policy            = "Default"
      + extended_auditing_policy     = (known after apply)
      + fully_qualified_domain_name  = (known after apply)
      + id                           = (known after apply)
      + location                     = "centralindia"
      + name                         = "som-primary-database"
      + resource_group_name          = "Som-Azure-TF-3Tier-VMs"
      + version                      = "12.0"
    }

  # module.networking.azurerm_subnet.app-subnet will be created
  + resource "azurerm_subnet" "app-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-app-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_subnet.db-subnet will be created
  + resource "azurerm_subnet" "db-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.3.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-db-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_subnet.web-subnet will be created
  + resource "azurerm_subnet" "web-subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "192.168.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "som-web-subnet"
      + resource_group_name                            = "Som-Azure-TF-3Tier-VMs"
      + virtual_network_name                           = "somvnet3TierVMs"
    }

  # module.networking.azurerm_virtual_network.vnet01 will be created
  + resource "azurerm_virtual_network" "vnet01" {
      + address_space         = [
          + "192.168.0.0/16",
        ]
      + dns_servers           = (known after apply)
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "centralindia"
      + name                  = "somvnet3TierVMs"
      + resource_group_name   = "Som-Azure-TF-3Tier-VMs"
      + subnet                = (known after apply)
      + vm_protection_enabled = false
    }

  # module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs will be created
  + resource "azurerm_resource_group" "Som-Azure-TF-3Tier-VMs" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "Som-Azure-TF-3Tier-VMs"
    }

  # module.securitygroup.azurerm_network_security_group.app-nsg will be created
  + resource "azurerm_network_security_group" "app-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-app-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_network_security_group.db-nsg will be created
  + resource "azurerm_network_security_group" "db-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-db-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.2.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 102
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.2.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "3306"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "ssh-rule-3"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.1.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_network_security_group.web-nsg will be created
  + resource "azurerm_network_security_group" "web-nsg" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "som-web-nsg"
      + resource_group_name = "Som-Azure-TF-3Tier-VMs"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-1"
              + priority                                   = 101
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "ssh-rule-2"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "192.168.3.0/24"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet will be created
  + resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

Plan: 19 to add, 0 to change, 0 to destroy.
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Creating...
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Creation complete after 1s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs]
module.networking.azurerm_virtual_network.vnet01: Creating...
module.compute.azurerm_availability_set.web_availabilty_set: Creating...
module.database.azurerm_sql_server.primary: Creating...
module.securitygroup.azurerm_network_security_group.web-nsg: Creating...
module.compute.azurerm_availability_set.app_availabilty_set: Creating...
module.securitygroup.azurerm_network_security_group.app-nsg: Creating...
module.securitygroup.azurerm_network_security_group.db-nsg: Creating...
module.compute.azurerm_availability_set.app_availabilty_set: Creation complete after 1s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/app_availabilty_set]
module.compute.azurerm_availability_set.web_availabilty_set: Creation complete after 1s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/web_availabilty_set]
module.securitygroup.azurerm_network_security_group.db-nsg: Creation complete after 2s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg]
module.securitygroup.azurerm_network_security_group.web-nsg: Creation complete after 2s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg]
module.securitygroup.azurerm_network_security_group.app-nsg: Creation complete after 2s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg]
module.networking.azurerm_virtual_network.vnet01: Creation complete after 4s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs]
module.networking.azurerm_subnet.web-subnet: Creating...
module.networking.azurerm_subnet.app-subnet: Creating...
module.networking.azurerm_subnet.db-subnet: Creating...
module.networking.azurerm_subnet.web-subnet: Creation complete after 4s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Creating...
module.compute.azurerm_network_interface.web-net-interface: Creating...
module.database.azurerm_sql_server.primary: Still creating... [10s elapsed]
module.networking.azurerm_subnet.db-subnet: Creation complete after 7s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Creating...
module.networking.azurerm_subnet.app-subnet: Still creating... [10s elapsed]
module.networking.azurerm_subnet.app-subnet: Creation complete after 11s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Creating...
module.compute.azurerm_network_interface.app-net-interface: Creating...
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Still creating... [10s elapsed]
module.compute.azurerm_network_interface.web-net-interface: Still creating... [10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Creation complete after 11s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.compute.azurerm_network_interface.web-net-interface: Creation complete after 11s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/web-network]
module.compute.azurerm_virtual_machine.web-vm: Creating...
module.database.azurerm_sql_server.primary: Still creating... [20s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Still creating... [10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Creation complete after 11s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.compute.azurerm_network_interface.app-net-interface: Still creating... [10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Still creating... [10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Creation complete after 11s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.compute.azurerm_network_interface.app-net-interface: Creation complete after 12s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/app-network]
module.compute.azurerm_virtual_machine.app-vm: Creating...
module.compute.azurerm_virtual_machine.web-vm: Still creating... [10s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [30s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still creating... [10s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still creating... [20s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [40s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still creating... [20s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still creating... [30s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [50s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still creating... [30s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still creating... [40s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [1m0s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still creating... [40s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Creation complete after 48s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-web-vm]
module.database.azurerm_sql_server.primary: Still creating... [1m10s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Creation complete after 46s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-app-vm]
module.database.azurerm_sql_server.primary: Still creating... [1m20s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [1m30s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [1m40s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [1m50s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [2m0s elapsed]
module.database.azurerm_sql_server.primary: Still creating... [2m10s elapsed]
module.database.azurerm_sql_server.primary: Creation complete after 2m15s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database]
module.database.azurerm_sql_database.db: Creating...
module.database.azurerm_sql_database.db: Still creating... [10s elapsed]
module.database.azurerm_sql_database.db: Still creating... [20s elapsed]
module.database.azurerm_sql_database.db: Still creating... [30s elapsed]
module.database.azurerm_sql_database.db: Still creating... [40s elapsed]
module.database.azurerm_sql_database.db: Still creating... [50s elapsed]
module.database.azurerm_sql_database.db: Still creating... [1m0s elapsed]
module.database.azurerm_sql_database.db: Still creating... [1m11s elapsed]
module.database.azurerm_sql_database.db: Still creating... [1m21s elapsed]
module.database.azurerm_sql_database.db: Still creating... [1m31s elapsed]
module.database.azurerm_sql_database.db: Creation complete after 1m34s [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database/databases/somdb]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>terraform destroy --auto-approve
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs]
module.networking.azurerm_virtual_network.vnet01: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs]
module.compute.azurerm_availability_set.web_availabilty_set: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/web_availabilty_set]
module.securitygroup.azurerm_network_security_group.web-nsg: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg]
module.database.azurerm_sql_server.primary: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database]
module.securitygroup.azurerm_network_security_group.app-nsg: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg]
module.compute.azurerm_availability_set.app_availabilty_set: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/app_availabilty_set]
module.securitygroup.azurerm_network_security_group.db-nsg: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg]
module.networking.azurerm_subnet.web-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.networking.azurerm_subnet.app-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.networking.azurerm_subnet.db-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.compute.azurerm_network_interface.app-net-interface: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/app-network]
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.compute.azurerm_network_interface.web-net-interface: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/web-network]
module.compute.azurerm_virtual_machine.app-vm: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-app-vm]
module.compute.azurerm_virtual_machine.web-vm: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-web-vm]
module.database.azurerm_sql_database.db: Refreshing state... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database/databases/somdb]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  - destroy

Terraform will perform the following actions:

  # module.compute.azurerm_availability_set.app_availabilty_set will be destroyed
  - resource "azurerm_availability_set" "app_availabilty_set" {
      - id                           = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/app_availabilty_set" -> null
      - location                     = "centralindia" -> null
      - managed                      = true -> null
      - name                         = "app_availabilty_set" -> null
      - platform_fault_domain_count  = 3 -> null
      - platform_update_domain_count = 5 -> null
      - resource_group_name          = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                         = {} -> null
    }

  # module.compute.azurerm_availability_set.web_availabilty_set will be destroyed
  - resource "azurerm_availability_set" "web_availabilty_set" {
      - id                           = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/web_availabilty_set" -> null
      - location                     = "centralindia" -> null
      - managed                      = true -> null
      - name                         = "web_availabilty_set" -> null
      - platform_fault_domain_count  = 3 -> null
      - platform_update_domain_count = 5 -> null
      - resource_group_name          = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                         = {} -> null
    }

  # module.compute.azurerm_network_interface.app-net-interface will be destroyed
  - resource "azurerm_network_interface" "app-net-interface" {
      - applied_dns_servers           = [] -> null
      - dns_servers                   = [] -> null
      - enable_accelerated_networking = false -> null
      - enable_ip_forwarding          = false -> null
      - id                            = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/app-network" -> null
      - internal_domain_name_suffix   = "lmnogdzntzeuveeqrhyix4e21f.rx.internal.cloudapp.net" -> null
      - location                      = "centralindia" -> null
      - mac_address                   = "00-0D-3A-3E-1A-6F" -> null
      - name                          = "app-network" -> null
      - private_ip_address            = "192.168.2.4" -> null
      - private_ip_addresses          = [
          - "192.168.2.4",
        ] -> null
      - resource_group_name           = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                          = {} -> null
      - virtual_machine_id            = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-app-vm" -> null

      - ip_configuration {
          - name                          = "app-webserver" -> null
          - primary                       = true -> null
          - private_ip_address            = "192.168.2.4" -> null
          - private_ip_address_allocation = "Dynamic" -> null
          - private_ip_address_version    = "IPv4" -> null
          - subnet_id                     = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet" -> null
        }
    }

  # module.compute.azurerm_network_interface.web-net-interface will be destroyed
  - resource "azurerm_network_interface" "web-net-interface" {
      - applied_dns_servers           = [] -> null
      - dns_servers                   = [] -> null
      - enable_accelerated_networking = false -> null
      - enable_ip_forwarding          = false -> null
      - id                            = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/web-network" -> null
      - internal_domain_name_suffix   = "lmnogdzntzeuveeqrhyix4e21f.rx.internal.cloudapp.net" -> null
      - location                      = "centralindia" -> null
      - mac_address                   = "00-0D-3A-3E-62-82" -> null
      - name                          = "web-network" -> null
      - private_ip_address            = "192.168.1.4" -> null
      - private_ip_addresses          = [
          - "192.168.1.4",
        ] -> null
      - resource_group_name           = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                          = {} -> null
      - virtual_machine_id            = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-web-vm" -> null

      - ip_configuration {
          - name                          = "web-webserver" -> null
          - primary                       = true -> null
          - private_ip_address            = "192.168.1.4" -> null
          - private_ip_address_allocation = "Dynamic" -> null
          - private_ip_address_version    = "IPv4" -> null
          - subnet_id                     = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet" -> null
        }
    }

  # module.compute.azurerm_virtual_machine.app-vm will be destroyed
  - resource "azurerm_virtual_machine" "app-vm" {
      - availability_set_id              = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourcegroups/som-azure-tf-3tier-vms/providers/microsoft.compute/availabilitysets/web_availabilty_set" -> null
      - delete_data_disks_on_termination = false -> null
      - delete_os_disk_on_termination    = true -> null
      - id                               = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-app-vm" -> null
      - location                         = "centralindia" -> null
      - name                             = "som-app-vm" -> null
      - network_interface_ids            = [
          - "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/app-network",
        ] -> null
      - resource_group_name              = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                             = {} -> null
      - vm_size                          = "Standard_D2s_v3" -> null
      - zones                            = [] -> null

      - os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      - os_profile_linux_config {
          - disable_password_authentication = false -> null
        }

      - storage_image_reference {
          - offer     = "UbuntuServer" -> null
          - publisher = "Canonical" -> null
          - sku       = "18.04-LTS" -> null
          - version   = "latest" -> null
        }

      - storage_os_disk {
          - caching                   = "ReadWrite" -> null
          - create_option             = "FromImage" -> null
          - disk_size_gb              = 30 -> null
          - managed_disk_id           = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/disks/app-disk" -> null
          - managed_disk_type         = "Standard_LRS" -> null
          - name                      = "app-disk" -> null
          - os_type                   = "Linux" -> null
          - write_accelerator_enabled = false -> null
        }
    }

  # module.compute.azurerm_virtual_machine.web-vm will be destroyed
  - resource "azurerm_virtual_machine" "web-vm" {
      - availability_set_id              = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourcegroups/som-azure-tf-3tier-vms/providers/microsoft.compute/availabilitysets/web_availabilty_set" -> null
      - delete_data_disks_on_termination = false -> null
      - delete_os_disk_on_termination    = true -> null
      - id                               = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-web-vm" -> null
      - location                         = "centralindia" -> null
      - name                             = "som-web-vm" -> null
      - network_interface_ids            = [
          - "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/web-network",
        ] -> null
      - resource_group_name              = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                             = {} -> null
      - vm_size                          = "Standard_D2s_v3" -> null
      - zones                            = [] -> null

      - os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      - os_profile_linux_config {
          - disable_password_authentication = false -> null
        }

      - storage_image_reference {
          - offer     = "UbuntuServer" -> null
          - publisher = "Canonical" -> null
          - sku       = "18.04-LTS" -> null
          - version   = "latest" -> null
        }

      - storage_os_disk {
          - caching                   = "ReadWrite" -> null
          - create_option             = "FromImage" -> null
          - disk_size_gb              = 30 -> null
          - managed_disk_id           = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/disks/som-web-disk" -> null
          - managed_disk_type         = "Standard_LRS" -> null
          - name                      = "som-web-disk" -> null
          - os_type                   = "Linux" -> null
          - write_accelerator_enabled = false -> null
        }
    }

  # module.database.azurerm_sql_database.db will be destroyed
  - resource "azurerm_sql_database" "db" {
      - collation                        = "SQL_Latin1_General_CP1_CI_AS" -> null
      - create_mode                      = "Default" -> null
      - creation_date                    = "2023-06-18T08:12:42.843Z" -> null
      - default_secondary_location       = "South India" -> null
      - edition                          = "GeneralPurpose" -> null
      - extended_auditing_policy         = [] -> null
      - id                               = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database/databases/somdb" -> null
      - location                         = "centralindia" -> null
      - max_size_bytes                   = "34359738368" -> null
      - name                             = "somdb" -> null
      - read_scale                       = false -> null
      - requested_service_objective_id   = "f21733ad-9b9b-4d4e-a4fa-94a133c41718" -> null
      - requested_service_objective_name = "GP_Gen5_2" -> null
      - resource_group_name              = "Som-Azure-TF-3Tier-VMs" -> null
      - server_name                      = "som-primary-database" -> null
      - tags                             = {} -> null
      - zone_redundant                   = false -> null

      - threat_detection_policy {
          - disabled_alerts      = [] -> null
          - email_account_admins = "Disabled" -> null
          - email_addresses      = [] -> null
          - retention_days       = 0 -> null
          - state                = "Disabled" -> null
          - use_server_default   = "Disabled" -> null
        }
    }

  # module.database.azurerm_sql_server.primary will be destroyed
  - resource "azurerm_sql_server" "primary" {
      - administrator_login          = "somsqladmin" -> null
      - administrator_login_password = (sensitive value) -> null
      - connection_policy            = "Default" -> null
      - extended_auditing_policy     = [] -> null
      - fully_qualified_domain_name  = "som-primary-database.database.windows.net" -> null
      - id                           = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database" -> null
      - location                     = "centralindia" -> null
      - name                         = "som-primary-database" -> null
      - resource_group_name          = "Som-Azure-TF-3Tier-VMs" -> null
      - tags                         = {} -> null
      - version                      = "12.0" -> null

      - threat_detection_policy {
          - disabled_alerts      = [
              - "",
            ] -> null
          - email_account_admins = false -> null
          - email_addresses      = [
              - "",
            ] -> null
          - retention_days       = 0 -> null
          - state                = "Disabled" -> null
        }
    }

  # module.networking.azurerm_subnet.app-subnet will be destroyed
  - resource "azurerm_subnet" "app-subnet" {
      - address_prefix                                 = "192.168.2.0/24" -> null
      - address_prefixes                               = [
          - "192.168.2.0/24",
        ] -> null
      - enforce_private_link_endpoint_network_policies = false -> null
      - enforce_private_link_service_network_policies  = false -> null
      - id                                             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet" -> null
      - name                                           = "som-app-subnet" -> null
      - resource_group_name                            = "Som-Azure-TF-3Tier-VMs" -> null
      - service_endpoint_policy_ids                    = [] -> null
      - service_endpoints                              = [] -> null
      - virtual_network_name                           = "somvnet3TierVMs" -> null
    }

  # module.networking.azurerm_subnet.db-subnet will be destroyed
  - resource "azurerm_subnet" "db-subnet" {
      - address_prefix                                 = "192.168.3.0/24" -> null
      - address_prefixes                               = [
          - "192.168.3.0/24",
        ] -> null
      - enforce_private_link_endpoint_network_policies = false -> null
      - enforce_private_link_service_network_policies  = false -> null
      - id                                             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet" -> null
      - name                                           = "som-db-subnet" -> null
      - resource_group_name                            = "Som-Azure-TF-3Tier-VMs" -> null
      - service_endpoint_policy_ids                    = [] -> null
      - service_endpoints                              = [] -> null
      - virtual_network_name                           = "somvnet3TierVMs" -> null
    }

  # module.networking.azurerm_subnet.web-subnet will be destroyed
  - resource "azurerm_subnet" "web-subnet" {
      - address_prefix                                 = "192.168.1.0/24" -> null
      - address_prefixes                               = [
          - "192.168.1.0/24",
        ] -> null
      - enforce_private_link_endpoint_network_policies = false -> null
      - enforce_private_link_service_network_policies  = false -> null
      - id                                             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet" -> null
      - name                                           = "som-web-subnet" -> null
      - resource_group_name                            = "Som-Azure-TF-3Tier-VMs" -> null
      - service_endpoint_policy_ids                    = [] -> null
      - service_endpoints                              = [] -> null
      - virtual_network_name                           = "somvnet3TierVMs" -> null
    }

  # module.networking.azurerm_virtual_network.vnet01 will be destroyed
  - resource "azurerm_virtual_network" "vnet01" {
      - address_space           = [
          - "192.168.0.0/16",
        ] -> null
      - dns_servers             = [] -> null
      - flow_timeout_in_minutes = 0 -> null
      - guid                    = "0fe31a5b-9e2d-4a49-9090-89f08bf89cdd" -> null
      - id                      = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs" -> null
      - location                = "centralindia" -> null
      - name                    = "somvnet3TierVMs" -> null
      - resource_group_name     = "Som-Azure-TF-3Tier-VMs" -> null
      - subnet                  = [
          - {
              - address_prefix = "192.168.1.0/24"
              - id             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet"
              - name           = "som-web-subnet"
              - security_group = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg"
            },
          - {
              - address_prefix = "192.168.2.0/24"
              - id             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet"
              - name           = "som-app-subnet"
              - security_group = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg"
            },
          - {
              - address_prefix = "192.168.3.0/24"
              - id             = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet"
              - name           = "som-db-subnet"
              - security_group = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg"
            },
        ] -> null
      - tags                    = {} -> null
      - vm_protection_enabled   = false -> null
    }

  # module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs will be destroyed
  - resource "azurerm_resource_group" "Som-Azure-TF-3Tier-VMs" {
      - id       = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs" -> null
      - location = "centralindia" -> null
      - name     = "Som-Azure-TF-3Tier-VMs" -> null
      - tags     = {} -> null
    }

  # module.securitygroup.azurerm_network_security_group.app-nsg will be destroyed
  - resource "azurerm_network_security_group" "app-nsg" {
      - id                  = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg" -> null
      - location            = "centralindia" -> null
      - name                = "som-app-nsg" -> null
      - resource_group_name = "Som-Azure-TF-3Tier-VMs" -> null
      - security_rule       = [
          - {
              - access                                     = "Allow"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "22"
              - destination_port_ranges                    = []
              - direction                                  = "Inbound"
              - name                                       = "ssh-rule-1"
              - priority                                   = 100
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.1.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
          - {
              - access                                     = "Allow"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "22"
              - destination_port_ranges                    = []
              - direction                                  = "Outbound"
              - name                                       = "ssh-rule-2"
              - priority                                   = 101
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.1.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
        ] -> null
      - tags                = {} -> null
    }

  # module.securitygroup.azurerm_network_security_group.db-nsg will be destroyed
  - resource "azurerm_network_security_group" "db-nsg" {
      - id                  = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg" -> null
      - location            = "centralindia" -> null
      - name                = "som-db-nsg" -> null
      - resource_group_name = "Som-Azure-TF-3Tier-VMs" -> null
      - security_rule       = [
          - {
              - access                                     = "Allow"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "3306"
              - destination_port_ranges                    = []
              - direction                                  = "Inbound"
              - name                                       = "ssh-rule-1"
              - priority                                   = 101
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.2.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
          - {
              - access                                     = "Allow"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "3306"
              - destination_port_ranges                    = []
              - direction                                  = "Outbound"
              - name                                       = "ssh-rule-2"
              - priority                                   = 102
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.2.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
          - {
              - access                                     = "Deny"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "3306"
              - destination_port_ranges                    = []
              - direction                                  = "Outbound"
              - name                                       = "ssh-rule-3"
              - priority                                   = 100
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.1.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
        ] -> null
      - tags                = {} -> null
    }

  # module.securitygroup.azurerm_network_security_group.web-nsg will be destroyed
  - resource "azurerm_network_security_group" "web-nsg" {
      - id                  = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg" -> null
      - location            = "centralindia" -> null
      - name                = "som-web-nsg" -> null
      - resource_group_name = "Som-Azure-TF-3Tier-VMs" -> null
      - security_rule       = [
          - {
              - access                                     = "Allow"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "22"
              - destination_port_ranges                    = []
              - direction                                  = "Inbound"
              - name                                       = "ssh-rule-1"
              - priority                                   = 101
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "*"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
          - {
              - access                                     = "Deny"
              - description                                = ""
              - destination_address_prefix                 = "*"
              - destination_address_prefixes               = []
              - destination_application_security_group_ids = []
              - destination_port_range                     = "22"
              - destination_port_ranges                    = []
              - direction                                  = "Inbound"
              - name                                       = "ssh-rule-2"
              - priority                                   = 100
              - protocol                                   = "Tcp"
              - source_address_prefix                      = "192.168.3.0/24"
              - source_address_prefixes                    = []
              - source_application_security_group_ids      = []
              - source_port_range                          = "*"
              - source_port_ranges                         = []
            },
        ] -> null
      - tags                = {} -> null
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet will be destroyed
  - resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
      - id                        = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet" -> null
      - network_security_group_id = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg" -> null
      - subnet_id                 = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet" -> null
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet will be destroyed
  - resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
      - id                        = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet" -> null
      - network_security_group_id = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg" -> null
      - subnet_id                 = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet" -> null
    }

  # module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet will be destroyed
  - resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
      - id                        = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet" -> null
      - network_security_group_id = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg" -> null
      - subnet_id                 = "/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet" -> null
    }

Plan: 0 to add, 0 to change, 19 to destroy.
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.database.azurerm_sql_database.db: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database/databases/somdb]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.compute.azurerm_availability_set.app_availabilty_set: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/app_availabilty_set]
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.compute.azurerm_virtual_machine.web-vm: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-web-vm]
module.compute.azurerm_virtual_machine.app-vm: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/virtualMachines/som-app-vm]
module.compute.azurerm_availability_set.app_availabilty_set: Destruction complete after 3s
module.database.azurerm_sql_database.db: Destruction complete after 4s
module.database.azurerm_sql_server.primary: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Sql/servers/som-primary-database]
module.securitygroup.azurerm_subnet_network_security_group_association.app-nsg-subnet: Destruction complete after 4s
module.securitygroup.azurerm_network_security_group.app-nsg: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-app-nsg]
module.securitygroup.azurerm_network_security_group.app-nsg: Destruction complete after 2s
module.securitygroup.azurerm_subnet_network_security_group_association.web-nsg-subnet: Destruction complete after 8s
module.securitygroup.azurerm_network_security_group.web-nsg: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-web-nsg]
module.securitygroup.azurerm_network_security_group.web-nsg: Destruction complete after 1s
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 10s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-.../somvnet3TierVMs/subnets/som-db-subnet, 10s elapsed]
module.securitygroup.azurerm_subnet_network_security_group_association.db-nsg-subnet: Destruction complete after 11s
module.networking.azurerm_subnet.db-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-db-subnet]
module.securitygroup.azurerm_network_security_group.db-nsg: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkSecurityGroups/som-db-nsg]
module.securitygroup.azurerm_network_security_group.db-nsg: Destruction complete after 1s
module.database.azurerm_sql_server.primary: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...osoft.Sql/servers/som-primary-database, 10s elapsed]
module.database.azurerm_sql_server.primary: Destruction complete after 15s
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 20s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 20s elapsed]
module.networking.azurerm_subnet.db-subnet: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-.../somvnet3TierVMs/subnets/som-db-subnet, 10s elapsed]
module.networking.azurerm_subnet.db-subnet: Destruction complete after 10s
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 30s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 30s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 40s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 40s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 50s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 50s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 1m0s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 1m0s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-app-vm, 1m10s elapsed]
module.compute.azurerm_virtual_machine.web-vm: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...oft.Compute/virtualMachines/som-web-vm, 1m10s elapsed]
module.compute.azurerm_virtual_machine.app-vm: Destruction complete after 1m12s
module.compute.azurerm_virtual_machine.web-vm: Destruction complete after 1m12s
module.compute.azurerm_availability_set.web_availabilty_set: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Compute/availabilitySets/web_availabilty_set]
module.compute.azurerm_network_interface.web-net-interface: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/web-network]
module.compute.azurerm_network_interface.app-net-interface: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/networkInterfaces/app-network]
module.compute.azurerm_availability_set.web_availabilty_set: Destruction complete after 0s
module.compute.azurerm_network_interface.app-net-interface: Destruction complete after 5s
module.networking.azurerm_subnet.app-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-app-subnet]
module.compute.azurerm_network_interface.web-net-interface: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-....Network/networkInterfaces/web-network, 10s elapsed]
module.compute.azurerm_network_interface.web-net-interface: Destruction complete after 10s
module.networking.azurerm_subnet.web-subnet: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs/subnets/som-web-subnet]
module.networking.azurerm_subnet.app-subnet: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...somvnet3TierVMs/subnets/som-app-subnet, 10s elapsed]
module.networking.azurerm_subnet.web-subnet: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...somvnet3TierVMs/subnets/som-web-subnet, 10s elapsed]
module.networking.azurerm_subnet.app-subnet: Destruction complete after 15s
module.networking.azurerm_subnet.web-subnet: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...somvnet3TierVMs/subnets/som-web-subnet, 20s elapsed]
module.networking.azurerm_subnet.web-subnet: Destruction complete after 20s
module.networking.azurerm_virtual_network.vnet01: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs/providers/Microsoft.Network/virtualNetworks/somvnet3TierVMs]
module.networking.azurerm_virtual_network.vnet01: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-...etwork/virtualNetworks/somvnet3TierVMs, 10s elapsed]
module.networking.azurerm_virtual_network.vnet01: Destruction complete after 12s
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-d644b3f23b8b/resourceGroups/Som-Azure-TF-3Tier-VMs]
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Still destroying... [id=/subscriptions/35b0fa4f-b6ba-4752-87a9-.../resourceGroups/Som-Azure-TF-3Tier-VMs, 10s elapsed]
module.resourcegroup.azurerm_resource_group.Som-Azure-TF-3Tier-VMs: Destruction complete after 16s

Destroy complete! Resources: 19 destroyed.

C:\Users\somde\OneDrive\Desktop\KPMG Assignment\Som-Azure-TF-3Tier-VMs>
