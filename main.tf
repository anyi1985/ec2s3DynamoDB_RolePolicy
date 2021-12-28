resource "aws_instance" "ec2s3DyB-Instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "BastionKeyPair"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2s3DyDB-Instance-Profile.id
}

resource "aws_iam_role" "ec2_role" {
  description        = "this is an instance role with an assume role policy"
  name               = "ec2-s3-DynamoDB-role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json

}

resource "aws_iam_role_policy" "ec2s3DyDB-Role-Policy" {
  name   = "ec2-s3-DynamoDB-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2-s3-DyDB-role-policy.json

}

resource "aws_iam_instance_profile" "ec2s3DyDB-Instance-Profile" {
  name = "ec2s3DyDB_instance_Profile"
  role = aws_iam_role.ec2_role.name

}
