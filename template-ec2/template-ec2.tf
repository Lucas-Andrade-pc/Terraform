resource "aws_launch_template" "ecs_lt" {
  name          = "template-ec2"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.type-ec2

  key_name               = "golang"
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.id_security]
  iam_instance_profile {
    name = data.terraform_remote_state.role.outputs.name
  }
  placement {
    availability_zone = "us-east-1"
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }
}