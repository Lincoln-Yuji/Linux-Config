#!/bin/env bash

# Use rclone to mount my s3 bucket into the file system
rclone mount amazon-desktop-backup:desktop-backup-lincolnyuji-490004636721 ~/.local/aws-s3-bucket --vfs-cache-mode full
