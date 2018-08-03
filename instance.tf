# resource
resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


resource "aws_instance" "us-east-1-instance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.aws-key.key_name}"

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  # using attributes in a script
  provisioner "local-exec" {
    command = "echo ${aws_instance.us-east-1-instance.private_ip} >> private_ips.txt"
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

output "ip" {
  value = "${aws_instance.us-east-1-instance.public_ip}"
}

