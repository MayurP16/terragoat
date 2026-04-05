resource "aws_s3_bucket" "flowbucket_access_logs" {
  bucket_prefix = "flowbucket-access-logs-"
}

resource "aws_s3_bucket_logging" "flowbucket_logging" {
  bucket        = aws_s3_bucket.flowbucket.id
  target_bucket = aws_s3_bucket.flowbucket_access_logs.id
  target_prefix = "logs/"
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

resource "aws_sns_topic" "flowbucket_events" {
  name = "flowbucket-events"
}

resource "aws_sns_topic_policy" "flowbucket_events_policy" {
  arn = aws_sns_topic.flowbucket_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.flowbucket_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.flowbucket.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "flowbucket_notifications" {
  bucket = aws_s3_bucket.flowbucket.id
  topic {
    topic_arn = aws_sns_topic.flowbucket_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.flowbucket_events_policy]
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

resource "aws_s3_bucket_public_access_block" "flowbucket_pab" {
  bucket                  = aws_s3_bucket.flowbucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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

resource "aws_s3_bucket_server_side_encryption_configuration" "flowbucket_sse" {
  bucket = aws_s3_bucket.flowbucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "alias/aws/s3"
    }
  }
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

resource "aws_s3_bucket_versioning" "flowbucket_versioning" {
  bucket = aws_s3_bucket.flowbucket.id
  versioning_configuration {
    status = "Enabled"
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


resource "aws_s3_bucket_public_access_block" "flowbucket_access_logs_pab" {
  bucket                  = aws_s3_bucket.flowbucket_access_logs.id
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

resource "aws_sns_topic" "flowbucket_access_logs_events" {
  name = "flowbucket_access_logs-events"
}

resource "aws_sns_topic_policy" "flowbucket_access_logs_events_policy" {
  arn = aws_sns_topic.flowbucket_access_logs_events.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3Publish"
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.flowbucket_access_logs_events.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.flowbucket_access_logs.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "flowbucket_access_logs_notifications" {
  bucket = aws_s3_bucket.flowbucket_access_logs.id
  topic {
    topic_arn = aws_sns_topic.flowbucket_access_logs_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_sns_topic_policy.flowbucket_access_logs_events_policy]
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

resource "aws_s3_bucket_server_side_encryption_configuration" "flowbucket_access_logs_sse" {
  bucket = aws_s3_bucket.flowbucket_access_logs.id
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

resource "aws_s3_bucket_versioning" "flowbucket_access_logs_versioning" {
  bucket = aws_s3_bucket.flowbucket_access_logs.id
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
