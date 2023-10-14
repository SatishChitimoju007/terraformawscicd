terraform {
    required_version = ">=1.5.1"
}
provider "aws" {
    region = "us-east-2"  
}

resource "aws_instance" "tf_Test-instance" {
  ami           = "ami-024e6efaf93d85776" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
