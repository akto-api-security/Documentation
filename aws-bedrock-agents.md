# AKTO AWS Bedrock Monitoring - Client Setup Guide

## Overview

This guide provides step-by-step instructions for setting up AKTO's AWS Bedrock monitoring solution in your AWS account. This solution automatically captures, processes, and sends AWS Bedrock agent conversations to your AKTO instance for security analysis.

## What You'll Achieve

✅ **Automated Bedrock Monitoring**: Capture all AWS Bedrock agent conversations  
✅ **Real-time Processing**: Process logs every 5 minutes automatically  
✅ **Security Analysis**: Send conversation data to AKTO for threat detection  
✅ **Multi-Model Support**: Works with Amazon Nova, Claude, and other Bedrock models  
✅ **Client-Side Deployment**: Complete data isolation in your AWS account

## Prerequisites

### 1. AWS Account Requirements
- AWS CLI installed and configured
- IAM permissions for:
    - Lambda functions
    - S3 buckets
    - EventBridge rules
    - Bedrock service access
    - IAM role creation

### 2. AKTO Instance Requirements
- AKTO instance running and accessible
- Data ingestion service running on port 9095
- AKTO API key for authentication

### 3. System Requirements
- macOS, Linux, or Windows with bash support
- Node.js 18+ (for local testing)
- Internet connectivity

## Step-by-Step Setup

### **Step 1: Install AWS CLI**
```bash
# On Mac:
brew install awscli

# On Windows: Download from https://aws.amazon.com/cli/
# On Linux:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### **Step 1.1: Install Node.js**
```bash
# On Mac:
brew install node

# On Windows/Linux: Download from https://nodejs.org/
```

### **Step 1.2: Configure AWS Credentials**

You need to tell AWS who you are:

```bash
aws configure
```

It will ask for:
- **AWS Access Key ID**: Get from AWS Console → IAM → Users → Your User → Security credentials
- **AWS Secret Access Key**: Same place as above
- **Default region**: Use `us-east-1` (or your preferred region)
- **Default output format**: Just press Enter

### **Step 1.3: Test AWS Access**
```bash
aws sts get-caller-identity
```

# Verify your AWS identity
aws sts get-caller-identity
```

**Expected Output:**
```json
{
    "UserId": "AIDACKXXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/your-username"
}
```
✅ **Should show your account ID** - You're ready!  
❌ **Shows error** - Fix your credentials first

### Step 2: Download the Solution

```bash
# Clone the repository
git clone https://github.com/akto-api-security/akto_aws_bedrock_discovery.git

# Navigate to the solution directory
cd akto_aws_bedrock_discovery

# Make scripts executable
chmod +x simple-deploy.sh test-solution.sh
```

### Step 3: Prepare Your Information

Before running the deployment, gather this information:

1. **S3 Bucket Name**: A unique bucket name for storing Bedrock logs
    - Example: `my-company-bedrock-logs-2024`
    - Must be globally unique across all AWS accounts

2. **AKTO Data Ingestion URL**: Your AKTO endpoint
    - Format: `https://your-akto-instance.com:9095/api/ingestData`
    - Replace `your-akto-instance.com` with your actual AKTO domain/IP

3. **AKTO API Key**: Authentication key for your AKTO instance
    - Obtain from your AKTO dashboard
    - Example: `ak_live_xxxxxxxxxxxxxxxxxxxx`

### Step 4: Run the Deployment

Execute the deployment script:

```bash
./simple-deploy.sh
```

The script will prompt you for the required information:

```
🚀 AKTO Bedrock Monitor - Simple Manual Deployment
=================================================

📊 Deployment Information:
   AWS Account ID: 123456789012
   AWS Region: us-east-1

S3 Bucket Configuration:
  - S3 bucket name is REQUIRED for Bedrock logging
  - The bucket should already exist and be accessible
  - Lambda will configure Bedrock to log to this bucket

Enter S3 bucket name (required): my-company-bedrock-logs-2024
✅ Using S3 bucket: my-company-bedrock-logs-2024

AKTO Data Ingestion Configuration:
  - Data ingestion service URL is REQUIRED
  - API key is REQUIRED for authentication

Enter AKTO Data Ingestion URL (e.g., https://your-akto-instance.com:9095/api/ingestData): https://my-akto.company.com:9095/api/ingestData
✅ Using Data Ingestion URL: https://my-akto.company.com:9095/api/ingestData

Enter AKTO API Key: ak_live_xxxxxxxxxxxxxxxxxxxx
✅ Using API Key: ak_live_...
```

### Step 5: Wait for Deployment

The script will automatically:

1. **Create IAM Role**: Set up permissions for Lambda
2. **Deploy Lambda Function**: Upload and configure the processing function
3. **Set Up EventBridge**: Schedule processing every 5 minutes
4. **Configure Environment**: Set all required variables

**Expected Output:**
```
📦 Building Lambda package...
✅ Lambda package created

🔧 Creating IAM role...
✅ IAM role created and configured

🔧 Creating Lambda function...
✅ Lambda function created/updated

🔧 Creating EventBridge schedule...
✅ EventBridge schedule created

🎉 Deployment completed successfully!

📋 What was created:
   • Lambda Function: akto-bedrock-log-processor-123456789012
   • IAM Role: akto-bedrock-processor-role-123456789012
   • EventBridge Rule: akto-bedrock-schedule-123456789012 (runs every 5 minutes)
   • Using existing S3 Bucket: my-company-bedrock-logs-2024

🔍 Next steps:
1. Generate some AWS Bedrock conversations
2. Monitor Lambda logs: aws logs tail /aws/lambda/akto-bedrock-log-processor-123456789012 --follow
3. Test manually: aws lambda invoke --function-name akto-bedrock-log-processor-123456789012 --payload '{}' response.json

🎯 The system will automatically process Bedrock logs every 5 minutes!
```

### Step 6: Verify the Deployment

Run the verification script:

```bash
./test-solution.sh
```

This will check:
- ✅ Lambda function exists and is accessible
- ✅ S3 bucket is properly configured
- ✅ CloudWatch logs are working
- ✅ EventBridge schedule is active

### Step 7: Create S3 Bucket (If Needed)

If you don't have an S3 bucket, create one:

```bash
# Replace 'my-company-bedrock-logs-2024' with your bucket name
aws s3 mb s3://my-company-bedrock-logs-2024

# Set bucket policy for Bedrock access (optional - Lambda will handle this)
aws s3api put-bucket-versioning \
    --bucket my-company-bedrock-logs-2024 \
    --versioning-configuration Status=Enabled
```

### Step 8: Test with Bedrock

Generate a test conversation:

```bash
# Example Bedrock API call
aws bedrock-runtime invoke-model \
    --model-id anthropic.claude-3-haiku-20240307-v1:0 \
    --body '{"messages":[{"role":"user","content":[{"type":"text","text":"Hello, this is a test message for AKTO monitoring."}]}],"max_tokens":50,"anthropic_version":"bedrock-2023-05-31"}' \
    --content-type application/json \
    test-output.json
```

### Step 9: Monitor the System

**Check Lambda Logs:**
```bash
aws logs tail /aws/lambda/akto-bedrock-log-processor-YOUR_ACCOUNT_ID --follow
```

**Check S3 for Bedrock Logs:**
```bash
aws s3 ls s3://your-bucket-name/bedrock-logs/ --recursive
```

**Manual Lambda Test:**
```bash
aws lambda invoke \
    --function-name akto-bedrock-log-processor-YOUR_ACCOUNT_ID \
    --payload '{}' \
    response.json
```

## System Architecture

```
AWS Bedrock Agent → Model Invocation Logging → S3 Bucket
                                                    ↓
AKTO Dashboard ← Data Ingestion API ← Lambda Function ← EventBridge (5 min)
```

## Troubleshooting

### Common Issues

**1. Permission Denied Errors**
```bash
# Check your AWS credentials
aws sts get-caller-identity

# Ensure you have sufficient IAM permissions
aws iam list-attached-user-policies --user-name YOUR_USERNAME
```

**2. S3 Bucket Already Exists**
```bash
# Choose a different bucket name or check if you own it
aws s3 ls s3://your-bucket-name
```

**3. Lambda Function Not Processing**
```bash
# Check Lambda logs for errors
aws logs describe-log-groups --log-group-name-prefix "/aws/lambda/akto-bedrock"

# View recent logs
aws logs tail /aws/lambda/akto-bedrock-log-processor-YOUR_ACCOUNT_ID --follow
```

**4. AKTO Connection Issues**
```bash
# Test connectivity to your AKTO instance
curl -X POST "https://your-akto-instance.com:9095/api/ingestData" \
     -H "Content-Type: application/json" \
     -H "X-API-KEY: your-api-key" \
     -d '{"test": "connection"}'
```

### Important Notes

1. **Bedrock Logging Configuration**: The Lambda function automatically enables Bedrock model invocation logging on first run
2. **Processing Schedule**: Logs are processed every 5 minutes via EventBridge
3. **Data Format**: Conversations are formatted in AKTO StandardMessage format with security tags
4. **Cost Considerations**: Monitor S3 storage costs and Lambda execution costs
5. **Security**: All data remains in your AWS account; no external access required

## What Happens Next

Once deployed, the system will:

1. **Auto-Configure Bedrock**: Enable model invocation logging to your S3 bucket
2. **Process Conversations**: Extract and format conversation data every 5 minutes
3. **Send to AKTO**: Forward processed data to your AKTO instance for analysis
4. **Monitor Security**: AKTO will analyze conversations for potential threats
5. **Generate Alerts**: Receive notifications for suspicious AI agent interactions

## File Inventory

Required files for client deployment:

1. **`simple-deploy.sh`** - Main deployment script
2. **`test-solution.sh`** - Verification and testing script
3. **`lambda-function/`** directory containing:
    - `index.js` - Main Lambda function code
    - `package.json` - Node.js dependencies
4. **`README.md`** - Quick reference guide
5. **`CLIENT_SETUP_GUIDE.md`** - This comprehensive guide

## Support

For issues or questions:

1. **Check CloudWatch Logs**: Monitor Lambda execution logs
2. **Review S3 Configuration**: Ensure bucket exists and is accessible
3. **Verify AKTO Connectivity**: Test endpoint and API key

---

🎉 **You now have complete AWS Bedrock monitoring integrated with AKTO!**