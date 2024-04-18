resource "aws_autoscaling_group" "ecs_asg" {
  name = "auto-scaling-cluster-ecs"
  vpc_zone_identifier = ["${data.terraform_remote_state.vpc.outputs.id_subnet}"]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1

  launch_template {
    id      = data.terraform_remote_state.template.outputs.template-id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}