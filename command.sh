#!/usr/bin/env bash
echo $(date --utc +%Y%m%d_%H%M%SZ) > $(date --utc +%Y%m%d_%H%M%SZ).tmp
ls
sleep 5
exit -1