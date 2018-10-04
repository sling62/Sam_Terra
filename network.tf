resource "aws_subnet" "sam_vpc_subnet" {
  vpc_id = "${var.aws_vpc}"
  cidr_block= "172.31.64.48/28"
  map_public_ip_on_launch = true

  tags{
      Name = "SamAdopSubnet"
  }
  
}
resource "aws_security_group" "sam_security_group" {
  name        = "Sam-Adop-Security-Group"
  description = "Allow Adop Inbound Traffic"
  vpc_id      = "${var.aws_vpc}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 2376
    to_port         = 2376
    protocol        = "udp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 25826
    to_port         = 25826
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "sam_adop_security_group"
  }
}