## Introduction

This is a simple Terraform Template that provisions a EC2 instance in
AWS cloud with Apache webserver installed on it and the index page will print “Hello Plexure!” on the Browser

The VM Provisioned is tagged as “Web Server” and also runs behind a Load Balancer.

Network Security Best Practices have been used for a WebServer.


## AWS user account required

An AWS user account with awscli access priveleges is needed
You can get one here https://aws.amazon.com

Export your AWS user credentials into the env before building the web server infrastructure using:

`export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]`

`export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]`


## Usage 

Initializes the terraform environment.
`terraform init`

Builds the infrastructure.
`terraform apply -auto-approve`

Tears down the infrastructure.
`terraform destroy -auto-approve`

## Specifics

Most variables can be changed via the `variables.tf` file. You can change the region, AZ's, Subnet CIDR's, AMI and instance type.

#### Important 

Currently within region `eu-west-1` I am using AMI `ami-0bb3fad3c0286ebd5` - this is valid. You may need to change this based on region used.



Author - Dan Kulkarni