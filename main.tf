provider "aws" {
  region = "${var.AWS_REGION}"
}

# Create ELB

resource "aws_elb" "ELB_TRF" {
  name               = "${var.elb_name}"
  availability_zones = "${var.elb_zones}"
  security_groups    = "${var.elb_security_group}"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "HTTP:80/index.html"
    interval            = 5
  }

  #  instances                   = "${var.instance_list}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "terraform-elb-classic"
  }
}

# Create Launch Configuration
resource "aws_launch_configuration" "launch_conf" {
  name          = "${var.lc_name}"
  image_id      = "${var.lc_ami_image_id}"
  instance_type = "${var.lc_instance_type}"

  user_data = "${file("script.sh")}"
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "as_group" {
  name                 = "${var.auto_scaling_group_name}"
  launch_configuration = "${aws_launch_configuration.launch_conf.name}"
  vpc_zone_identifier  = "${var.as_group_zones}"
  max_size             = "3"
  min_size             = "1"

  load_balancers = ["${aws_elb.ELB_TRF.name}"]

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "RDNTech"
      propagate_at_launch = true
    },
  ]
}
