resource "aws_vpc" "test_vpc" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Shahzad-Terraform"
  }
}
resource "aws_subnet" "test_subnet_1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "shahzad-Pub-Sub-1"
  }
}

resource "aws_subnet" "test_subnet_2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1b"
   map_public_ip_on_launch = true

  tags = {
    Name = "shahzad-Pub-Sub-2"
  }
}

resource "aws_subnet" "test_subnet_3" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "shahzad-Pvt-Sub-1"
  }
}


resource "aws_subnet" "test_subnet_4" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "shahzad-Pvt-Sub-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "Shahzad-igw"
  }
}
6
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "shahzad-pub-rt"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "shahzad-pri-rt"
  }
}

resource "aws_route_table_association" "public_rt_asociation_subnet_1" {
  subnet_id      = aws_subnet.test_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_asociation_subnet_2" {
  subnet_id      = aws_subnet.test_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_asociation_subnet_3" {
  subnet_id      = aws_subnet.test_subnet_3.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_asociation_subnet_4" {
  subnet_id      = aws_subnet.test_subnet_4.id
  route_table_id = aws_route_table.private_rt.id
}