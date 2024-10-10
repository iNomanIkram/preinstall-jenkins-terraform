locals {
  RESOURCE_PREFIX = "JENKINS"
  BASIC_SECURITY_GROOVY_RENDERED = base64encode(templatefile("template/basic-security.groovy.j2", { JENKINS_ADMIN_USER = var.JENKINS_ADMIN_USER, JENKINS_ADMIN_PASSWORD = var.JENKINS_ADMIN_PASSWORD }))
  USER_DATA_FILE_RENDERED = templatefile("template/setup-jenkins.j2", { JENKINS_DOCKER_IMAGE = var.JENKINS_DOCKER_IMAGE, BASIC_SECURITY_GROOVY = local.BASIC_SECURITY_GROOVY_RENDERED })
  
}

resource "aws_security_group" "instance_security_group" {
  vpc_id      = var.VPC_ID
  name        = "${local.RESOURCE_PREFIX}-SG"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.RESOURCE_PREFIX}-SG"
  }
}

resource "aws_instance" "jenkins" {
  ami = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_PAIR_NAME
  iam_instance_profile = var.INSTANCE_PROFILE_NAME
  subnet_id              = var.SUBNET_ID
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  root_block_device {
    delete_on_termination = var.DELETE_VOLUME_ON_TERMINATION
    volume_size           = var.VOLUME_SIZE
  }

  user_data = local.USER_DATA_FILE_RENDERED

  tags = {
    Name = local.RESOURCE_PREFIX
  }
}