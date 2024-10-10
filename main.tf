# VPC 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Public Subnets 
resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "public-2"
  }
}

resource "aws_subnet" "public_3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    Name = "public-3"
  }
}

# App Subnets (for EC2 application instances)
resource "aws_subnet" "app_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "app-1"
  }
}

resource "aws_subnet" "app_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "app-2"
  }
}

resource "aws_subnet" "app_3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    Name = "app-3"
  }
}

# Data Subnets (for databases, Aurora)
resource "aws_subnet" "data_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "data-1"
  }
}

resource "aws_subnet" "data_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.8.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "data-2"
  }
}

resource "aws_subnet" "data_3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.9.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    Name = "data-3"
  }
}

resource "aws_db_subnet_group" "aurora-db-gp" {
  name       = "main"
  subnet_ids = [aws_subnet.data_1.id, aws_subnet.data_2.id, aws_subnet.data_3.id]

  tags = {
    Name = "DB subnet group"
  }
} 


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
