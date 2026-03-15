provider "aws" {
    region = "us-east-1"  
}
resource "aws_db_instance" "default" {
    db_name = "mydatabase"
    identifier = "mydb"
    instance_class = "db.t3.micro"
    username = "divya"
    password = "Divya789620"
    engine = "MySql"
    engine_version = "8.0"
    deletion_protection = false  
    skip_final_snapshot = true
    allocated_storage = 10
}

