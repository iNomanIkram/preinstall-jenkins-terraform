variable "JENKINS_ADMIN_USER" {
    default = "admin"
}

variable "JENKINS_ADMIN_PASSWORD" {
    default = "admin1234"
}

variable "JENKINS_DOCKER_IMAGE" {
    default = "jenkins/jenkins:2.313-jdk11"
}

variable "VPC_ID" {
    default = "vpc-1c48c361"
}

variable "SUBNET_ID" {
    default = "subnet-4ac5bd15"
}

variable "AMI_ID" {
    default = "ami-0747bdcabd34c712a"
}

variable "INSTANCE_TYPE" {
    default = "t2.medium"
}

variable "KEY_PAIR_NAME" {
    default = "abc_ni_keypair"
}

variable "INSTANCE_PROFILE_NAME" {
    default = "AdminAccess"
}

variable "DELETE_VOLUME_ON_TERMINATION" {
    default = false
}

variable "VOLUME_SIZE" {
    default = 30
}