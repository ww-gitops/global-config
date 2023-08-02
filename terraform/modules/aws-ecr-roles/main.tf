
data "aws_iam_policy_document" "ecr_read_assume_role" {
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

resource "aws_iam_role" "ecr_read" {
  assume_role_policy = data.aws_iam_policy_document.ecr_read_assume_role.json
  name               = "${var.cluster_name}-ecr-read"
}

data "aws_iam_policy_document" "ecr_read" {
  statement {
    effect = "Allow"

    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      "arn:aws:ecr:${var.awsRegion}:${var.awsAccountId}:repository/cluster-${var.cluster_name}",
      "arn:aws:ecr:${var.awsRegion}:${var.awsAccountId}:repository/templates"
    ]
  }
}

resource "aws_iam_policy" "ecr_read" {
  name   = "${var.cluster_name}-ecr-read"
  policy = data.aws_iam_policy_document.ecr_read.json
}


resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.ecr_read.name
  policy_arn = aws_iam_policy.ecr_read.arn
}
