#!/bin/sh

srcfolder="$(dirname "$0")";

$srcfolder/mount_remote_ams.sh
$srcfolder/mount_remote_ctb.sh

