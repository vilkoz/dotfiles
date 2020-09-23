#!/usr/bin/fish

sudo cpupower frequency-set -u 4.2GHz
sudo bash -c 'echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo'
