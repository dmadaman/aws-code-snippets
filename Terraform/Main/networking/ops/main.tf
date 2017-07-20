terraform {
    backend s3 {
        bucket = "terraform-states-stobie"
        key    = "networking/current/ops.tfstate"
        region = "us-west-2"
  }
}

module "networking" {
    #---------------------------------------------------------------------------#
    # Git Versioned Module                                                      #
    #---------------------------------------------------------------------------#
    source = "git@github.com:lanmalkieri/terraform-modules.git//networking?ref=networking-0.0.7"

    #---------------------------------------------------------------------------#
    # Environment Specific Variables                                            #
    #---------------------------------------------------------------------------#
    env = "ops" 
    vpc_cidr = "10.1.0.0/16" 

    #---------------------------------------------------------------------------#
    # Global Variables set in global-vars.tf                                    #
    #---------------------------------------------------------------------------#
    azs = "${var.azs}"
    azs_short = "${var.azs_short}"
    acct_number = "${var.acct_number}"
}
