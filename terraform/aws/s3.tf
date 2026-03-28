resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "jonjozwiak/nimrodkor/schosterbarak"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "0874007d-903a-4b4c-945f-c9c233e13243"
    }, {
    yor_name = "data"
  })
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = merge({
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "jonjozwiak/nimrodkor"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "a7f01cc7-63c2-41a8-8555-6665e5e39a64"
    }, {
    yor_name = "data_object"
  })
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  acl           = "private"
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-financials"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "jonjozwiak/nimrodkor/schosterbarak"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "0e012640-b597-4e5d-9378-d4b584aea913"
    }, {
    yor_name = "financials"
  })

}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "jonjozwiak/nimrodkor/schosterbarak"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "29efcf7b-22a8-4bd6-8e14-1f55b3a2d743"
    }, {
    yor_name = "operations"
  })
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.logs.id
    target_prefix = "log/"
  }
  force_destroy = true
  tags = {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "nimrodkor/schosterbarak"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "9a7c8788-5655-4708-bbc3-64ead9847f64"
    yor_name             = "data_science"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.logs_key.arn
      }
    }
  }
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "5c6b5d60a8aa63a5d37e60f15185d13a967f0542"
    git_file             = "terraform/aws/s3.tf"
    git_last_modified_at = "2021-05-02 10:06:10"
    git_last_modified_by = "nimrodkor@users.noreply.github.com"
    git_modifiers        = "jonjozwiak/nimrodkor/schosterbarak"
    git_org              = "MayurP16"
    git_repo             = "terragoat"
    yor_trace            = "01946fe9-aae2-4c99-a975-e9b0d3a4696c"
    }, {
    yor_name = "logs"
  })
}

resource "aws_s3_bucket" "data_access_logs" {
  bucket_prefix = "data-access-logs-"
}

resource "aws_s3_bucket_logging" "data_logging" {
  bucket        = aws_s3_bucket.data.id
  target_bucket = aws_s3_bucket.data_access_logs.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket" "financials_access_logs" {
  bucket_prefix = "financials-access-logs-"
}

resource "aws_s3_bucket_logging" "financials_logging" {
  bucket        = aws_s3_bucket.financials.id
  target_bucket = aws_s3_bucket.financials_access_logs.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket" "logs_access_logs" {
  bucket_prefix = "logs-access-logs-"
}

resource "aws_s3_bucket_logging" "logs_logging" {
  bucket        = aws_s3_bucket.logs.id
  target_bucket = aws_s3_bucket.logs_access_logs.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket" "operations_access_logs" {
  bucket_prefix = "operations-access-logs-"
}

resource "aws_s3_bucket_logging" "operations_logging" {
  bucket        = aws_s3_bucket.operations.id
  target_bucket = aws_s3_bucket.operations_access_logs.id
  target_prefix = "logs/"
}

resource "aws_sns_topic" "data_events" {
  name = "data-events"
}

resource "aws_sns_topic_policy" "data_events_policy" {
  arn = aws_sns_topic.data_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.data_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.data.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "data_notifications" {
  bucket = aws_s3_bucket.data.id
  topic {
    topic_arn = aws_sns_topic.data_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.data_events_policy]
}

resource "aws_sns_topic" "data_science_events" {
  name = "data_science-events"
}

resource "aws_sns_topic_policy" "data_science_events_policy" {
  arn = aws_sns_topic.data_science_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.data_science_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.data_science.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "data_science_notifications" {
  bucket = aws_s3_bucket.data_science.id
  topic {
    topic_arn = aws_sns_topic.data_science_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.data_science_events_policy]
}

resource "aws_sns_topic" "financials_events" {
  name = "financials-events"
}

resource "aws_sns_topic_policy" "financials_events_policy" {
  arn = aws_sns_topic.financials_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.financials_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.financials.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "financials_notifications" {
  bucket = aws_s3_bucket.financials.id
  topic {
    topic_arn = aws_sns_topic.financials_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.financials_events_policy]
}

resource "aws_sns_topic" "logs_events" {
  name = "logs-events"
}

resource "aws_sns_topic_policy" "logs_events_policy" {
  arn = aws_sns_topic.logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "logs_notifications" {
  bucket = aws_s3_bucket.logs.id
  topic {
    topic_arn = aws_sns_topic.logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.logs_events_policy]
}

resource "aws_sns_topic" "operations_events" {
  name = "operations-events"
}

resource "aws_sns_topic_policy" "operations_events_policy" {
  arn = aws_sns_topic.operations_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.operations_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.operations.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "operations_notifications" {
  bucket = aws_s3_bucket.operations.id
  topic {
    topic_arn = aws_sns_topic.operations_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.operations_events_policy]
}

resource "aws_s3_bucket_public_access_block" "data_pab" {
  bucket                  = aws_s3_bucket.data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "data_science_pab" {
  bucket                  = aws_s3_bucket.data_science.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "financials_pab" {
  bucket                  = aws_s3_bucket.financials.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "logs_pab" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "operations_pab" {
  bucket                  = aws_s3_bucket.operations.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data_sse" {
  bucket = aws_s3_bucket.data.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data_science_sse" {
  bucket = aws_s3_bucket.data_science.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "financials_sse" {
  bucket = aws_s3_bucket.financials.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "operations_sse" {
  bucket = aws_s3_bucket.operations.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_versioning" "data_versioning" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "financials_versioning" {
  bucket = aws_s3_bucket.financials.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "data_access_logs_pab" {
  bucket                  = aws_s3_bucket.data_access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "financials_access_logs_pab" {
  bucket                  = aws_s3_bucket.financials_access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "logs_access_logs_pab" {
  bucket                  = aws_s3_bucket.logs_access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "operations_access_logs_pab" {
  bucket                  = aws_s3_bucket.operations_access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_sns_topic" "data_access_logs_events" {
  name = "data_access_logs-events"
}

resource "aws_sns_topic_policy" "data_access_logs_events_policy" {
  arn = aws_sns_topic.data_access_logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.data_access_logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.data_access_logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "data_access_logs_notifications" {
  bucket = aws_s3_bucket.data_access_logs.id
  topic {
    topic_arn = aws_sns_topic.data_access_logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.data_access_logs_events_policy]
}

resource "aws_sns_topic" "financials_access_logs_events" {
  name = "financials_access_logs-events"
}

resource "aws_sns_topic_policy" "financials_access_logs_events_policy" {
  arn = aws_sns_topic.financials_access_logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.financials_access_logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.financials_access_logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "financials_access_logs_notifications" {
  bucket = aws_s3_bucket.financials_access_logs.id
  topic {
    topic_arn = aws_sns_topic.financials_access_logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.financials_access_logs_events_policy]
}

resource "aws_sns_topic" "logs_access_logs_events" {
  name = "logs_access_logs-events"
}

resource "aws_sns_topic_policy" "logs_access_logs_events_policy" {
  arn = aws_sns_topic.logs_access_logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.logs_access_logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.logs_access_logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "logs_access_logs_notifications" {
  bucket = aws_s3_bucket.logs_access_logs.id
  topic {
    topic_arn = aws_sns_topic.logs_access_logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.logs_access_logs_events_policy]
}

resource "aws_sns_topic" "operations_access_logs_events" {
  name = "operations_access_logs-events"
}

resource "aws_sns_topic_policy" "operations_access_logs_events_policy" {
  arn = aws_sns_topic.operations_access_logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.operations_access_logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.operations_access_logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "operations_access_logs_notifications" {
  bucket = aws_s3_bucket.operations_access_logs.id
  topic {
    topic_arn = aws_sns_topic.operations_access_logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.operations_access_logs_events_policy]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data_access_logs_sse" {
  bucket = aws_s3_bucket.data_access_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "financials_access_logs_sse" {
  bucket = aws_s3_bucket.financials_access_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_access_logs_sse" {
  bucket = aws_s3_bucket.logs_access_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "operations_access_logs_sse" {
  bucket = aws_s3_bucket.operations_access_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
}

resource "aws_s3_bucket_versioning" "data_access_logs_versioning" {
  bucket = aws_s3_bucket.data_access_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "financials_access_logs_versioning" {
  bucket = aws_s3_bucket.financials_access_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "logs_access_logs_versioning" {
  bucket = aws_s3_bucket.logs_access_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "operations_access_logs_versioning" {
  bucket = aws_s3_bucket.operations_access_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}
