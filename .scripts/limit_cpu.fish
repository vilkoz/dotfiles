#!/usr/bin/fish

sudo cpupower frequency-set -u 1.7GHz
sudo bash -c 'echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo'
