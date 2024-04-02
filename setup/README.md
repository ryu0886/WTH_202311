# How to

## Create a GCP project: wtcpoc2023
```
gcloud config set project wthpoc2023
```
```
gcloud services enable compute.googleapis.com
```
```
gcloud compute firewall-rules create https-allow --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=https-server
```

## How to Enable RDP
```
runas /user:administrator cmd
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
```
