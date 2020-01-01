output "teslamate_ec2_ip" {
  description = "The IP address of teslamate instance"
  value       = aws_instance.teslamate.public_ip
}
