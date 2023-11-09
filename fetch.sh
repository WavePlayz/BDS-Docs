#!/bin/bash

LINUX_PREVIEW_LATEST=`curl -s 'https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/versions.json' | jq -r '.linux.preview'`
LINUX_PREVIEW="https://raw.githubusercontent.com/Bedrock-OSS/BDS-Versions/main/linux_preview/$LINUX_PREVIEW_LATEST.json"

DOWNLOAD_URL=`curl -s $LINUX_PREVIEW | jq -r '.download_url'`
echo "Minecraft v$LINUX_PREVIEW_LATEST - $DOWNLOAD_URL"

wget $DOWNLOAD_URL -q -O bds.zip
unzip bds.zip -d bds

rm bds.zip
rm -rf docs
cd bds

echo '{ "generate_documentation": true }' > 'test_config.json'
./bedrock_server

mv docs ../docs
cd ..
rm -r bds
