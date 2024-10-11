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

# DB Subnet Group for Aurora
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

# Route table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate the public route table with each public subnet
resource "aws_route_table_association" "public_1_association" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_association" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_3_association" {
  subnet_id      = aws_subnet.public_3.id
  route_table_id = aws_route_table.public_rt.id
}

# Internal Route Table for App and Data Subnets
resource "aws_route_table" "internal_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internal-rt"
  }
}

# Associate the internal route table with app subnets (App 1, App 2, App 3)
resource "aws_route_table_association" "app_1_association" {
  subnet_id      = aws_subnet.app_1.id
  route_table_id = aws_route_table.internal_rt.id
}

resource "aws_route_table_association" "app_2_association" {
  subnet_id      = aws_subnet.app_2.id
  route_table_id = aws_route_table.internal_rt.id
}

resource "aws_route_table_association" "app_3_association" {
  subnet_id      = aws_subnet.app_3.id
  route_table_id = aws_route_table.internal_rt.id
}

# Associate the internal route table with data subnets (Data 1, Data 2, Data 3)
resource "aws_route_table_association" "data_1_association" {
  subnet_id      = aws_subnet.data_1.id
  route_table_id = aws_route_table.internal_rt.id
}

resource "aws_route_table_association" "data_2_association" {
  subnet_id      = aws_subnet.data_2.id
  route_table_id = aws_route_table.internal_rt.id
}

resource "aws_route_table_association" "data_3_association" {
  subnet_id      = aws_subnet.data_3.id
  route_table_id = aws_route_table.internal_rt.id
}
