# VPC
resource "aws_vpc" "sakurai_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# サブネット

resource "aws_subnet" "sakurai_subnet_a" {
  count             = 2
  vpc_id            = aws_vpc.sakurai_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.sakurai_vpc.cidr_block, 8, count.index)
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "sakurai_subnet_c" {
  count             = 2
  vpc_id            = aws_vpc.sakurai_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.sakurai_vpc.cidr_block, 8, count.index + 2)
  availability_zone = "ap-northeast-1c"
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "sakurai_igw" {
  vpc_id = aws_vpc.sakurai_vpc.id
}

# ルートテーブル
resource "aws_route_table" "sakurai_rtb_public" {
  vpc_id = aws_vpc.sakurai_vpc.id
}

# パブリック用 ルートテーブルとサブネットの関連付け
resource "aws_route_table_association" "sakurai_rtb_assoc_pblic" {
  count          = 2
  route_table_id = aws_route_table.sakurai_rtb_public.id
  subnet_id      = element([aws_subnet.sakurai_subnet_a[0].id, aws_subnet.sakurai_subnet_c[0].id], count.index)
}

# IGWへのルーティング（インターネットに繋ぐため）
resource "aws_route" "sakurai_route_igw" {
  route_table_id         = aws_route_table.sakurai_rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sakurai_igw.id
  depends_on             = [aws_route_table.sakurai_rtb_public]
}

# NAT ゲートウェイ
resource "aws_eip" "sakurai_eip" {
  count = 2
  vpc   = true
}

resource "aws_nat_gateway" "sakurai_nat" {
  count         = 2
  subnet_id     = element([aws_subnet.sakurai_subnet_a[0].id, aws_subnet.sakurai_subnet_c[0].id], count.index)
  allocation_id = aws_eip.sakurai_eip[count.index].id
}


# プライベート用
resource "aws_route_table" "sakurai_rtb_private" {
  count  = 2
  vpc_id = aws_vpc.sakurai_vpc.id
}

resource "aws_route_table_association" "sakurai_rtb_assoc_private" {
  count          = 2
  route_table_id = aws_route_table.sakurai_rtb_private[count.index].id
  subnet_id      = element([aws_subnet.sakurai_subnet_a[1].id, aws_subnet.sakurai_subnet_c[1].id], count.index)
}

# NAT Gatewayへのルーティング
resource "aws_route" "sakurai_route_ngw" {
  count                  = 2
  route_table_id         = aws_route_table.sakurai_rtb_private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.sakurai_nat[count.index].id
  depends_on             = [aws_route_table.sakurai_rtb_private]
}
