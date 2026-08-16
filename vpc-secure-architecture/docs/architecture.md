# Architecture

The setup uses one VPC with public and private subnets across two Availability Zones.
flowchart TB
    Internet((Internet))

    subgraph VPC["VPC 10.0.0.0/16"]
        IGW[Internet Gateway]

        subgraph Public["Public Subnets"]
            NAT1[NAT Gateway]
            Bastion[Bastion Host]
            ALB[Application Load Balancer]
        end

        subgraph Private["Private Subnets"]
            Web1[Web App EC2]
            Web2[Web App EC2]
        end
    end

    Internet --> IGW
    IGW      --> ALB
    ALB       --> Web1
    ALB      --> Web2
    Web1     --> NAT1
    Web2       --> NAT1
    NAT1     --> IGW
    Internet -. SSH .-> Bastion
    Bastion -. SSH .-> Web1
    Bastion -. SSH .-> Web2

## How the traffic works
**1. Website traffic**
Users access the application through the public Application Load Balancer. The ALB then sends the request to one of the web servers in the private subnets.

**2. Private server internet access**
The private servers cannot be accessed directly from the internet. They use a NAT Gateway when they need internet access, such as downloading updates or packages.

**3. Admin access**
SSH access is allowed only from a trusted IP to the bastion host. From the bastion, an administrator can connect to the private web servers.

## Security
The setup uses a few layers of security:

* Web servers are kept in private subnets.
* Security Groups control which resources can communicate.
* NACLs provide an additional layer of network control.
* SSH is restricted to a trusted IP.
* NAT Gateway provides outbound internet access for private servers.
* EBS storage is encrypted.
* The setup uses two Availability Zones for better availability.

The main idea is to **keep the web servers private and expose only the Load Balancer to the internet**.
