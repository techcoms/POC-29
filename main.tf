resource "aws_instance" "poc29" {
  ami           = "i-02bf89fb887bb1cd0"
  instance_type = "t2.medium"

  tags = {
    Name = "HelloWorld"
  }
}
