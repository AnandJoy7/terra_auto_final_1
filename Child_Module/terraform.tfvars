aws_region = "us-east-1"

vpc_configs = {
  "vpc-0e8104893617c26c7": {
    "cidr_block": "10.0.0.0/16",
    "tags": {
      "Name": "project-vpc"
    },
    "enable_dns_support": true,
    "enable_dns_hostnames": true
  }
}

subnet_configs = {
  "subnet-0b6a455a5c7d6b667": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "cidr_block": "10.0.128.0/20",
    "availability_zone": "us-east-1a",
    "map_public_ip": false,
    "tags": {
      "Name": "project-subnet-private1-us-east-1a"
    }
  },
  "subnet-08f049e34c971ce41": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "cidr_block": "10.0.0.0/20",
    "availability_zone": "us-east-1a",
    "map_public_ip": false,
    "tags": {
      "Name": "project-subnet-public1-us-east-1a"
    }
  }
}

igw_configs = {
  "igw-0d8443ef15ea3bf64": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "tags": {
      "Name": "project-igw"
    }
  }
}

nat_configs = {
  "nat-06247d8c4c701c28b": {
    "subnet_id": "subnet-08f049e34c971ce41",
    "tags": {
      "Name": "project-nat-public1-us-east-1a"
    }
  }
}

sg_configs = {
  "sg-07febebb2fa3c7ad4": {
    "name": "default",
    "description": "default VPC security group",
    "vpc_id": "vpc-0e8104893617c26c7",
    "ingress": [
      {
        "from_port": 0,
        "to_port": 0,
        "protocol": "-1",
        "cidr_blocks": [
          "0.0.0.0/0"
        ]
      }
    ],
    "egress": [
      {
        "from_port": 0,
        "to_port": 0,
        "protocol": "-1",
        "cidr_blocks": [
          "0.0.0.0/0"
        ]
      }
    ],
    "tags": {}
  }
}

rt_configs = {
  "rtb-0da8e500237eed745": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "routes": [
      {
        "destination_cidr_block": "10.0.0.0/16",
        "gateway_id": "local"
      },
      {
        "destination_cidr_block": "0.0.0.0/0",
        "gateway_id": "nat-06247d8c4c701c28b"
      }
    ],
    "tags": {
      "Name": "project-rtb-private1-us-east-1a"
    }
  },
  "rtb-038eca0edaec00082": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "routes": [
      {
        "destination_cidr_block": "10.0.0.0/16",
        "gateway_id": "local"
      },
      {
        "destination_cidr_block": "0.0.0.0/0",
        "gateway_id": "igw-0d8443ef15ea3bf64"
      }
    ],
    "tags": {
      "Name": "project-rtb-public"
    }
  },
  "rtb-0b8805f44451f08a6": {
    "vpc_id": "vpc-0e8104893617c26c7",
    "routes": [
      {
        "destination_cidr_block": "10.0.0.0/16",
        "gateway_id": "local"
      }
    ],
    "tags": {}
  }
}
