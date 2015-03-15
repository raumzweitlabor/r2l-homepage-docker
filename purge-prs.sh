#!/bin/bash

set -e

DAYS_TO_KEEP=$(( 14 - 1))
TARGET_DIR=/data/preview

find $TARGET_DIR/* -maxdepth 0 -type d -mtime +$DAYS_TO_KEEP -exec rm -vrf {} \;
