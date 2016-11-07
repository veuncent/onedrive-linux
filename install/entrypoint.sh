#!/bin/bash

SYNC_DIR=${SYNC_DIR}
SKIP_FILE=${SKIP_FILE}
SKIP_DIR=${SKIP_DIR}

if [[ -z ${SYNC_DIR} ]]; then
	echo "Environment variable SYNC_DIR not set. Specify the local root folder that needs to be synchronized with Onedrive."
	echo "Exiting..."
	exit 1
fi

# Default files to skip if env var not set
if [[ -z ${SKIP_FILE} ]]; then
	SKIP_FILE=".*|~*|thumbs.db"
fi

# Default folders to skip if env var not set
if [[ -z ${SKIP_DIR} ]]; then
	SKIP_DIR=".*"
fi

sed -i "s/<sync_dir>/${SYNC_DIR}/g" ${CONFIG_DIR}/config
sed -i "s/<skip_file>/${SKIP_FILE}/g" ${CONFIG_DIR}/config
sed -i "s/<skip_dir>/${SKIP_DIR}/g" ${CONFIG_DIR}/config

systemctl --user enable onedrive
systemctl --user start onedrive