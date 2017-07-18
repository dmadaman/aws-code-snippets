Fetch the S3 prefix list IDs for S3 in all AWS regions. These can then be used in route tables and security groups to allow access to S3:

```sh
#!/bin/bash

# Fetch the S3 prefix list IDs for S3 in all AWS regions.
# These can then be used in route tables and security groups to allow access to S3

aws ec2 describe-regions --query 'Regions[*].RegionName' | \
jq -r '.[]' | \
while read REGION
do
  echo ==== $REGION ====
  aws ec2 describe-prefix-lists \
    --region $REGION \
    --filters Name=prefix-list-name,Values=com.amazonaws.$REGION.s3 \
    --query 'PrefixLists[0].PrefixListId'
done
```

