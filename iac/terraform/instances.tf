data "aws_ami" "ubuntu_lts" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image*"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "2022-04"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "primary" {
  name        = "primary-delve"
  description = "Delvers security group"
  vpc_id      = aws_vpc.primary.id

  # Wide open baby
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_spot_instance_request" "primary" {
  vpc_security_group_ids      = [aws_security_group.primary.id]
  ami                         = data.aws_ami.ubuntu_lts.id
  key_name                    = aws_key_pair.ssh_key.id
  subnet_id                   = aws_subnet.primary.id
  spot_price                  = "0.020"
  spot_type                   = "one-time"
  instance_type               = "t3a.medium"
  wait_for_fulfillment        = true
  associate_public_ip_address = true

  tags = {
    Name = "Minecraft Maybe"
  }
}