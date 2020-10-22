# Create a new load balancer
resource "aws_elb" "terra-elb" {
  name  = "Apache-ELB"
  count = "1"
  #availability_zones = ["${var.azs}"]
  subnets         = ["${element(aws_subnet.public.*.id, count.index)}"]
  security_groups = ["${aws_security_group.webservers.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${element(aws_instance.webservers.*.id, count.index)}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "WebServer-ELB"
  }
}

