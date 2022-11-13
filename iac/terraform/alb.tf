# resource "aws_alb" "my_alb" {
#   name            = "alb-test"
#   subnets         = [
#     aws_subnet.primary.id,
#     aws_subnet.secondary.id,
#   ]
#   security_groups = [
#     aws_security_group.primary.id,
#   ]
# }

# resource "aws_alb_target_group" "my_target_group" {
#   name        = "test-group"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = data.aws_vpc.dev_vpc.id
#   target_type = "ip"
#   health_check {
#     healthy_threshold   = "2"
#     interval            = "60"
#     matcher             = "300-312"
#     path                = "/"
#     port                = 80
#     protocol            = "HTTP"
#     timeout             = "5"
#     unhealthy_threshold = "3"
#   }
# }

# resource "aws_alb_listener" "my_alb" {
#   load_balancer_arn = aws_alb.my_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = data.aws_acm_certificate.egee_io.arn

#   default_action {
#     target_group_arn = aws_alb_target_group.my_alb.id
#     type             = "forward"
#   }
# }
