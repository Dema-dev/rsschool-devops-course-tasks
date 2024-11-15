# # GHA Role Provision via OIDC
# resource "aws_iam_openid_connect_provider" "github_provider" {
#   url = "https://token.actions.githubusercontent.com"
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#   tags     = {}
#   tags_all = {}
#   thumbprint_list = [
#     "d89e3bd43d5d909b47a18977aa9d5ce36cee184c",
#   ]

# }

# # Create Role
# resource "aws_iam_role" "github_role" {
#   assume_role_policy = jsonencode(
#     {
#       Statement = [
#         {
#           Action = "sts:AssumeRoleWithWebIdentity"
#           Condition = {
#             StringLike = {
#               "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
#               "token.actions.githubusercontent.com:sub" = "repo:Dema-dev/rsschool-devops-course-tasks:*"
#             }
#           }
#           Effect = "Allow"
#           Principal = {
#             Federated = "arn:aws:iam::913524930772:oidc-provider/token.actions.githubusercontent.com"
#           }
#         },
#       ]
#       Version = "2012-10-17"
#     }
#   )
#   description           = null
#   force_detach_policies = false
#   managed_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
#     "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess",
#     "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
#     "arn:aws:iam::aws:policy/AmazonS3FullAccess",
#     "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
#     "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
#     "arn:aws:iam::aws:policy/IAMFullAccess",
#   ]
#   max_session_duration = 3600
#   name                 = "GithubActionsRole"
#   name_prefix          = null
#   path                 = "/"
#   permissions_boundary = null
#   tags                 = {}
#   tags_all             = {}


# }

# # Attache policy to role
# resource "aws_iam_role_policy" "github_policy" {
#   name = "AWSRevokeOlderSessions"
#   role = aws_iam_role.github_role.name
#   policy = jsonencode(
#     {
#       Statement = [
#         {
#           Action = [
#             "*",
#           ]
#           Condition = {
#             DateLessThan = {
#               "aws:TokenIssueTime" = "2024-09-28T14:50:02.494Z"
#             }
#           }
#           Effect = "Deny"
#           Resource = [
#             "*",
#           ]
#         },
#       ]
#       Version = "2012-10-17"
#     }
#   )
# }