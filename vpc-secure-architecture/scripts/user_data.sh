#!/bin/bash this was the exact things in used in bash
# Bootstraps a minimal web server on the private-subnet instances.
# Runs on first boot via EC2 user data.

set -euo pipefail
dnf update -y
dnf install -y httpd
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $(curl -s -X PUT 'http://169.254.169.254/latest/api/token' -H 'X-aws-ec2-metadata-token-ttl-seconds: 21600')" http://169.254.169.254/latest/meta-data/instance-id)
cat > /var/www/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head><title>Secure VPC Demo</title></head>
<body>
  <h1>Web app running in a private subnet</h1>
  <p>Instance ID: ${INSTANCE_ID}</p>
  <p>Reached via ALB &rarr; private subnet. No direct public IP.</p>
</body>
</html>
HTML
systemctl enable httpd
systemctl start httpd