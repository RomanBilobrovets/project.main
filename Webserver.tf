
provider "aws"{}

resource "aws_instance" "my_webserver" {
    ami                = "ami-05b5a865c3579bbc4"
    instance_type      = "t3.micro"
    vpc_security_group_ids = ["aws_security_group.my_webserver.id]
    user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip='curl http://192.168.1.107/latest/meta-data/local-ipv4'
echo "<h2>Webserver with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

}


resource "aws_security_group" "my_webserver" {
    name = "Webserver Security Group"
    description = "My First SecurityGroup"



    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
}


ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]


}







    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
