data "aws_dx_gateway" "dx_gateway_1" {
  name = "${var.dx_gateway_1}"
}

data "aws_dx_gateway" "dx_gateway_2" {
  name = "${var.dx_gateway_2}"
}

resource "aws_dx_connection" "Direct_Device_1" {
  name            = "tf-dx-connection-1"
  bandwidth       = "100Gbps"
  location        = "${var.location_code_1}"
  request_macsec  = true
  encryption_mode = "must_encrypt"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Direct_Device_1"
        Role: "${var.env_prefix}-Direct_Device_1"
        Team: "team-${var.team}"
    
    } 
}

resource "aws_dx_connection" "Direct_Device_2" {
  name            = "tf-dx-connectio-2"
  bandwidth       = "100Gbps"
  location        = "${var.location_code_2}"
  request_macsec  = true
  encryption_mode = "must_encrypt"

   tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Direct_Device_2"
        Role: "${var.env_prefix}-Direct_Device_2"
        Team: "team-${var.team}"
    
    } 
}

resource "aws_customer_gateway" "Customer_Gateway_1" {
  bgp_asn    = 65000
  ip_address = "0.0.9.0"
  type       = "ipsec.1"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Customer_Gateway_1"
        Role: "${var.env_prefix}-Customer_Gateway_1"
        Team: "team-${var.team}"
    
    } 
}

resource "aws_customer_gateway" "Customer_Gateway_2" {
  bgp_asn    = 65000
  ip_address = "0.0.0.0"
  type       = "ipsec.1"

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-Customer_Gateway_2"
        Role: "${var.env_prefix}-Customer_Gateway_2"
        Team: "team-${var.team}"
    
    } 
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.Lab_VPC.id

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-${var.proj_prefix}"
        Name : "${var.env_prefix}-vpn_gw"
        Role: "${var.env_prefix}-vpn_gw"
        Team: "team-${var.team}"
    
    } 
}

resource "aws_dx_gateway_association" "vpn_dx_assc_1" {
  dx_gateway_id         = data.aws_dx_gateway.dx_gateway_1
  associated_gateway_id = aws_vpn_gateway.vpn_gw.id
  allowed_prefixes = aws_vpc.Lab_VPC.cidr_block
}

resource "aws_dx_gateway_association" "vpn_dx_assc_2" {
  dx_gateway_id         = data.aws_dx_gateway.dx_gateway_1
  associated_gateway_id = aws_vpn_gateway.vpn_gw.id
  allowed_prefixes = aws_vpc.Lab_VPC.cidr_block
}


