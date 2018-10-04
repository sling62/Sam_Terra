


resource "aws_instance" "sam_instance" {
  ami = "ami-7abd0209" 
  user_data = "${data.template_cloudinit_config.master.rendered}"
  instance_type = "m4.xlarge"
  vpc_security_group_ids = ["${aws_security_group.sam_security_group.id}"]
  key_name = "Sam_Adop"

  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    delete_on_termination = "false"
  } 

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "15"
    delete_on_termination = "false"
  }

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_type = "gp2"
    volume_size = "25"
    delete_on_termination = "false"
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_type = "gp2"
    volume_size = "25"
    delete_on_termination = "false"
  }

  tags{
      Name = "Samantha_Adop_Instance"
  }
}

resource "aws_network_interface" "sam_interface" {
  subnet_id = "${aws_subnet.sam_vpc_subnet.id}"
  
  attachment {
    instance     = "${aws_instance.sam_instance.id}"
    device_index = 1
  }

  tags {
    Name = "sam_primary_network_interface"
    Service = "ADOP-C"
    NetworkTier = "private"
    ServiceComponent = "ApplicationServer"
  }
}

 data "template_cloudinit_config" "master" {
     part {
     filename     = "userdata.sh"
     content_type = "text/x-shellscript"
     content      = "#!/bin/bash curl -L https://gist.githubusercontent.com/bmistry12/6a4296de580f69158f864546ee6ecb6d/raw/ed3096e88bba15bc23083b03bdbc796ede94ba8a/ADOPC-User-Data.sh > userAdopData.sh && chmod 700 userAdopData.sh &&  ./userAdopData.sh"
     }
 }

# resource "template_file" "user_data" {
#     filename = "userdata.sh"
# }

