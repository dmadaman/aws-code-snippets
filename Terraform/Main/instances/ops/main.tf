terraform {
    backend s3 {
        bucket = "CHANGEME"
        key    = "instances/current/ops.tfstate"
        region = "us-west-2"
  }
}

module "instances" {
    #---------------------------------------------------------------------------#
    # Git Versioned Module                                                      #
    #---------------------------------------------------------------------------#
    source = "git@github.com:URL//instances?ref=instances-TAG_VERSION"

    #---------------------------------------------------------------------------#
    # Environment Specific Variables                                            #
    #---------------------------------------------------------------------------#
    env = "ops" 

    #---------------------------------------------------------------------------#
    # Global Variables set in global-vars.tf                                    #
    #---------------------------------------------------------------------------#
    subnets = "subnet-8c8761ea"
    ami_id = "ami-835b4efa"
    key_name = "linux-key"
    sgs = "sg-aae436d0,sg-cec470b4"
    instance_type = "m4.large"
    azs_short = "${var.azs_short}"
    region = "us-west-2"
    count = "1"
    tag_name = "amazon-linux"
}
