# resource "aws_s3_bucket" "tfstate_bucket" {
#   acceleration_status = null
#   bucket              = "components-tfstate-dem"
#   bucket_prefix       = null
#   object_lock_enabled = false
#   policy              = null
#   request_payer       = "BucketOwner"
#   tags                = {}
#   tags_all            = {}

#   grant {
#     id = "f4855bf6dec5058c683518659e2f2d0d41bf67c1d29a2e9fde90018d45b417ea"
#     permissions = [
#       "FULL_CONTROL",
#     ]
#     type = "CanonicalUser"
#     uri  = null
#   }

#   server_side_encryption_configuration {
#     rule {
#       bucket_key_enabled = true

#       apply_server_side_encryption_by_default {
#         kms_master_key_id = null
#         sse_algorithm     = "AES256"
#       }
#     }
#   }

#   versioning {
#     enabled    = true
#     mfa_delete = false
#   }
# }