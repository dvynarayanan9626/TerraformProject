provider "aws" {
    region = "us-east-1"  
}
resource "aws_db_instance" "default" {
    db_name = "mydatabase"
    identifier = "mydb"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "1234567890"
    engine = "MySql"
    engine_version = "8.0"
    deletion_protection = false  
    skip_final_snapshot = true
    allocated_storage = 10
}

