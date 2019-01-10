#!/bin/bash
echo "gasdf" | nc "172.22.89.39" -v 1337 || echo "REBOOT FAILED"
# MULTI_FOLDER=/home/vrybalko/large/int/multi/
MULTI_FOLDER=/home/vrybalko/large/int/ghs_1900/multi/
WORKAROUND_PATH=/home/vrybalko/large/int/multi/workaround
LD_LIBRARY_PATH=$WORKAROUND_PATH/lib64:$WORKAROUND_PATH/lib LD_PRELOAD=$WORKAROUND_PATH/lib/libmulti.so $MULTI_FOLDER/multi
