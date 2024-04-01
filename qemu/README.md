# How to Install Windows 11 Virtual Machine on QEMU

Host OS: Debian 11

I don't configure network for the installation.
```
apt update
apt -y install qemu-system
qemu-img create -f qcow2 win11v23h2jan.qcow2 60G
sudo qemu-system-x86_64 -enable-kvm --nographic -m 8196 -smp 4 -name vm01 -vnc 0.0.0.0:1 win11v23h2jan.qcow2 -cdrom en-us_windows_11_business_editions_version_23h2_updated_jan_2024_x64_dvd_12855bc9.iso
```

Open the VNC client to connect to "vm01".
First we need to disable Windows 11 checking.
```
Shift + F10 for cmd and regedit
HKEY_LOCAL_MACHINE\SYSTEM\Setup
new key: LabConfig
add DWORD BypassTPMCheck and set 1
add DWORD BypassSecureBootCheck and set 1
add DWORD BypassRAMCheck and set 1
```
Next we need to skip Network requirement.
```
Shift+F10
OOBE\BYPASSNRO
```
It takes me around 60 minutes to install a nested QEMU Win11 under a GCP instance.

Remember to disable the hibernation mode and shutdown the machine.
```
Run a cmd.exe with the Administrator permission
powercfg -h off
```

After the installation, we can launch the machine the following way by creating a snapshot "vm01.qcow2" and run "qemu-system-x86_64"
```
qemu-img create -b win11v23h2jan.qcow2 -F qcow2 -f qcow2 -o lazy_refcounts vm01.qcow2
sudo qemu-system-x86_64 -enable-kvm --nographic -m 8196 -smp 4 -name vm01 -nic user,id=localnet,net=192.168.200.0/24,dhcpstart=192.168.200.11,hostfwd=tcp::3389-:3389,hostfwd=tcp::443-:443 -vnc 0.0.0.0:1 -monitor telnet:127.0.0.1:50001,server,nowait vm01.qcow2 -D ./vm01.log
```

This is the example base [image](https://ice-eu-89714.icedrive.io/download?p=WWS9WuGnUYr0BGyDIG1Co14XbWoeonbXwFzOaf.rPE315XE2vauL_Mw39gZIl47uRa8iyFUHVghXQKAW4SKdJegyuQZQcF9pD5q0K6gq46AGWlzV5STu05OZkwDwCbjvRdsbDBSW93_qlHMmTnwb_5SnwTN_INQsOfYapESMo9.xmyInsNLdQ10zAbXQLAYxloKlotPTKezFzWWUYlbTJw--)

```
md5sum win11v23h2jan.qcow2
75c468daee191fa48b2a45fb9d4b82ea  win11v23h2jan.qcow2
```
