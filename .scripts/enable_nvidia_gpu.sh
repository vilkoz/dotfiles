#!/bin/bash

CONTROLLER_BUS_ID=0000:00:01.0
DEVICE_BUS_ID=0000:01:00.0
MODULES_LOAD=(nvidia nvidia_uvm nvidia_modeset "nvidia_drm modeset=1")

echo 'Turning the PCIe controller on to allow card rescan'
sudo tee /sys/bus/pci/devices/${CONTROLLER_BUS_ID}/power/control <<<on
echo 'Waiting 1 second'
sleep 1

if [[ ! -d /sys/bus/pci/devices/${DEVICE_BUS_ID} ]]; then
	echo 'Rescanning PCI devices'
	tee /sys/bus/pci/rescan <<<1
	echo "Waiting 1 second for rescan"
	sleep 1
fi

echo 'Turning the card on'
tee /sys/bus/pci/devices/${DEVICE_BUS_ID}/power/control <<<on

for module in "${MODULES_LOAD[@]}"
do
	echo "Loading module ${module}"
	modprobe ${module}
done
