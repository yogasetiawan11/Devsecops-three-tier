output "cluster_name" {
    description = "The name of the EKS cluster"
    value       = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
    description = "The endpoint of the EKS cluster"
    value       = module.eks_cluster.cluster_endpoint
}

output "cluster_certificate_authority" {
    description = "The certificate authority of the EKS cluster"
    value       = module.eks_cluster.cluster_certificate_authority
    sensitive = true
}

output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.vpc.vpc_id
}

output "region" {
    description = "The AWS region where resources are deployed"
    value       = var.aws_region
}