//Server web-App
resource "aws_instance" "master" { //nama web-app samakan dengan nama servernya
  ami                         = "ami-030e837d78f47cbb1" //ubuntu 22
  instance_type               = "m5.large"
  associate_public_ip_address = "false"
  key_name                    = "master-key"
  subnet_id                   = module.vpc.private_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.master-sg.id]
  root_block_device {
    volume_size           = 200
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags                  = merge(local.common_tags, {
      Name = format("%s-%s-master-ebs", var.customer, var.environment)
    })
  }

  #user_data = file("userdata-with-caching.sh")

  lifecycle {
    ignore_changes        = [associate_public_ip_address]
    create_before_destroy = false
  }

  tags = merge(local.common_tags, {
    Name                = format("%s-%s-master", var.customer, var.environment),
    start-stop-schedule = false,
    OS                  = "Ubuntu",
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}