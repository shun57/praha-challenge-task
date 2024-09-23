

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "sakurai-ecs"
}

# ECS Service
resource "aws_ecs_service" "main" {
  name = "sakurai_ecs_service"

  cluster         = aws_ecs_cluster.main.name
  launch_type     = "FARGATE"
  desired_count   = "1"
  task_definition = aws_ecs_task_definition.sakurai_ecs_task_definition.arn

  # ECSタスクへ設定するネットワークの設定
  network_configuration {
    subnets         = [aws_subnet.sakurai_subnet_a[1].id, aws_subnet.sakurai_subnet_a[1].id]
    security_groups = [aws_security_group.ecs.id]
  }

  # ECSタスクの起動後に紐付けるELBターゲットグループ
  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "nginx"
    container_port   = "80"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "sakurai_ecs_task_definition" {
  family                   = "sakurai-ecs-task-definition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  # 起動するコンテナの定義
  container_definitions = <<-EOS
  [
    {
        "name": "nginx",
        "image": "${aws_ecr_repository.nginx.repository_url}",
        "portMappings": [
            {
                "name": "nginx",
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp",
                "appProtocol": "http"
            }
        ],
        "essential": true,
        "environment": [],
        "environmentFiles": [],
        "mountPoints": [],
        "volumesFrom": [],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/ecs/logs/nginx",
                "awslogs-region": "ap-northeast-1",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
  ]
  EOS
}

# ECS Log
resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/logs/nginx"
  retention_in_days = 1
}


# オートスケール
resource "aws_appautoscaling_target" "appautoscaling_ecs_target" {
  service_namespace = "ecs"

  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  role_arn = data.aws_iam_role.ecs_service_autoscaling.arn

  min_capacity = 1
  max_capacity = 2
}

data "aws_iam_role" "ecs_service_autoscaling" {
  name = "AWSServiceRoleForApplicationAutoScaling_ECSService"
}

# サーバ台数増加設定
resource "aws_appautoscaling_policy" "appautoscaling_scale_up" {
  name              = "service_name_scale_up"
  service_namespace = "ecs"

  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 120
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

# サーバ台数減少設定
resource "aws_appautoscaling_policy" "appautoscaling_scale_down" {
  name              = "service_name_scale_down"
  service_namespace = "ecs"

  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 120
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
}

# メトリクスアラーム
resource "aws_cloudwatch_metric_alarm" "alarm_cpu_high" {
  alarm_name = "service_name_cpu_utilization_high"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"

  threshold = "80"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name
  }

  alarm_actions = [aws_appautoscaling_policy.appautoscaling_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "alarm_cpu_low" {
  alarm_name = "service_name_cpu_utilization_low"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"

  threshold = "76"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name
  }

  alarm_actions = [aws_appautoscaling_policy.appautoscaling_scale_down.arn]
}
