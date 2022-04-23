data "aws_ami" "ubuntu_lts" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 20.04 LTS, amd64 focal image*"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "2022-04"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  name        = "sg_main"
  description = "A delvers security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["71.8.171.136/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_spot_instance_request" "master" {
  vpc_security_group_ids      = [aws_security_group.main.id]
  ami                         = data.aws_ami.ubuntu_lts.id
  key_name                    = aws_key_pair.ssh_key.id
  subnet_id                   = aws_subnet.main.id
  spot_price                  = "0.007"
  spot_type                   = "one-time"
  instance_type               = "t3a.small"
  wait_for_fulfillment        = true
  associate_public_ip_address = true

  tags = {
    Name = "delve-master"
  }
  depends_on = [aws_internet_gateway.main]
}