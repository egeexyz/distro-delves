variable "cidr_block" { default = "172.20.0.0/16" }

resource "aws_vpc" "primary" {
  cidr_block = var.cidr_block
  tags = {
    Name = "Delves"
  }
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "Delves"
  }
}

resource "aws_route_table" "primary" {
  vpc_id = aws_vpc.primary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "primary" {
  route_table_id = aws_route_table.primary.id
  subnet_id      = aws_subnet.primary.id
}

resource "aws_subnet" "primary" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.20.68.0/24"
  availability_zone       = "us-west-2d"
  map_public_ip_on_launch = true

  tags = {
    Name = "Delves"
  }
}

resource "aws_route_table" "secondary" {
  vpc_id = aws_vpc.primary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "secondary" {
  route_table_id = aws_route_table.secondary.id
  subnet_id      = aws_subnet.secondary.id
}

resource "aws_subnet" "secondary" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.20.0.0/24"
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Delves"
  }
}