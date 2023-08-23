data "aws_iam_policy_document" "s3_read_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
    }

    principals {
      identifiers = [var.cluster_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "s3_read" {
  assume_role_policy = data.aws_iam_policy_document.s3_read_assume_role.json
  name               = "${var.cluster_name}-s3-bootstrap-read"
}

data "aws_iam_policy_document" "s3_read" {
  statement {
      sid = ""
      effect = "Allow"
      actions = ["s3:GetObject"]
      resources = ["arn:aws:s3:::${var.bucket_name}/*"]
  }
    
  statement {
    effect = "Allow"
    sid = ""
    actions = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }
}

resource "aws_iam_policy" "s3_read" {
  name   = "${var.cluster_name}-s3-read"
  policy = data.aws_iam_policy_document.s3_read.json
}


resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.s3_read.name
  policy_arn = aws_iam_policy.s3_read.arn
}
