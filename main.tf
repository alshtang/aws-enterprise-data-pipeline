# 1. Определяем провайдера (AWS) и регион
provider "aws" {
  region = "eu-central-1" # Франкфурт
}

# 2. Создаем саму сеть (VPC)
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16" # Диапазон IP-адресов нашей сети
  enable_dns_hostnames = true          # Чтобы наши сервера имели красивые имена
  enable_dns_support   = true

  tags = {
    Name        = "Enterprise-VPC"
    Environment = "Dev"
    Project     = "BigDataPipeline"
  }
}

# 3. Создаем публичную подсеть (здесь будут "входные ворота")
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a" # Первая зона во Франкфурте

  tags = {
    Name = "Public-Subnet-1"
  }
}

# 4. Интернет-шлюз (Gateway), чтобы наша сеть могла "общаться" с миром
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Main-IGW"
  }
}

# 1. Создаем приватную подсеть (здесь будет жить Big Data и логика)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Private-Subnet-Processing"
  }
}

# 2. Нам нужен статический IP (Elastic IP) для шлюза
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# 3. NAT Gateway (Шлюз, чтобы приватная сеть могла выходить в интернет)
# ВАЖНО: Он ставится в ПУБЛИЧНУЮ подсеть
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id # Ставим в "прихожую"

  tags = {
    Name = "Main-NAT-Gateway"
  }
}