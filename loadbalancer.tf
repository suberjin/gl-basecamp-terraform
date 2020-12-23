resource "aws_lb" "homework_lb" {
  name               = "homework-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web_rules.id]
  subnets            = [aws_subnet.homework_1.id,aws_subnet.homework_2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "homework-tg" {
  name     = "homework-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.homework.id
}

resource "aws_lb_listener" "homework-listeners" {
  load_balancer_arn = aws_lb.homework_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.homework-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "homework-tg-attached" {
  target_group_arn = aws_lb_target_group.homework-tg.arn
  target_id        = aws_instance.worker_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "homework-tg-attached-2" {
  target_group_arn = aws_lb_target_group.homework-tg.arn
  target_id        = aws_instance.worker_2.id
  port             = 80
}