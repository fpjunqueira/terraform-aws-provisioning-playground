# launch instance in created VPC
resource "aws_instance" "us-east-1-instance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # VPC subnet subnet-public-1
  subnet_id = "${aws_subnet.subnet-public-1.id}"

  # security groups
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}", "${aws_security_group.allow-my-ip.id}"]

  # public key
  key_name = "${aws_key_pair.aws-key.key_name}"

  # copy running a script to install the nginx on instance
  provisioner "file" {
    source = "../script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  # using attributes in a local script
  provisioner "local-exec" {
    command = "echo ${aws_instance.us-east-1-instance.private_ip} >> private_ips.txt"
  }

  # connection to running the script.sh with the remote-exec provisioner
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

# output
output "ip" {
  value = "${aws_instance.us-east-1-instance.public_ip}"
}

