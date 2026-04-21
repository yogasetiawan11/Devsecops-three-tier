variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.medium"
}


variable "key_pair" {
    description = "The name of the EC2 Key Pair to allow SSH access to the instance"
    type        = string
    default     = "my-key-pair"
}

variable "security_group" {
    description = "The Security Group ID to associate with the EC2 instance"
    type        = string
    default     = "sg-12345678"
}

variable "ami_id" {
    description = "The AMI ID to use for the EC2 instance"
    type        = string
    default     = "ami-12345678"
}

variable "route_table_id" {
    description = "The Route Table ID to associate with the subnet"
    type        = string
    default     = "rtb-12345678"

}

variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "south-east-1"
}


variable "environment" {
    description = "The environment to deploy resources in (e.g., dev, staging, prod)"
    type        = string
    default     = "dev"
}

variable "cluster_name" {
    description = "name that used for the cluster"
    type        = string
    default     = "eks-cluster-dev"
}

variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.32"
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}