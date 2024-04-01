mkdir C:\inetpub
Set-MpPreference -ExclusionPath C:\inetpub,C:\windows\temp
Dism /Online /Enable-Feature /FeatureName:IIS-CGI /All
mkdir C:\inetpub\cloudscan
curl https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe -o python_installer.exe
Start-Process ".\python_installer.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0 TargetDir=C:\Python3" -NoNewWindow -Wait
Remove-Item -Path ".\python_installer.exe" -Force
py -c "import sys; print(sys.executable[:-10])"
py -m pip install wfastcgi
py -m pip install flask
C:\Python3\Scripts\wfastcgi-enable.exe
C:\Windows\System32\inetsrv\appcmd.exe unlock config /section:system.webServer/handlers
C:\Windows\System32\inetsrv\appcmd.exe add site /name:CloudAV /id:2 /bindings:https/*:443: /physicalPath:C:\inetpub\cloudscan
C:\Windows\System32\inetsrv\appcmd.exe set config -section:system.webServer/fastCGI /"[fullPath='C:\Python3\python.exe'].idleTimeout:300" /commit:apphost
C:\Windows\System32\inetsrv\appcmd.exe set config -section:system.webServer/fastCGI /"[fullPath='C:\Python3\python.exe'].activityTimeout:180" /commit:apphost
C:\Windows\System32\inetsrv\appcmd.exe set config -section:system.webServer/fastCGI /"[fullPath='C:\Python3\python.exe'].requestTimeout:300" /commit:apphost
$_cmd_output = (New-SelfSignedCertificate -HashAlgorithm sha384 -KeyAlgorithm RSA -KeyLength 4096 -Subject "CN=WTH Root Authority,O=WTH Security,C=US" -KeyUsage DigitalSignature,CertSign -NotAfter (get-date).AddYears(10) -CertStoreLocation "Cert:\CurrentUser\My" -Type Custom)
$_cmd_output -match '([0-9ABCDEF]{40})'
$_cert_res=(New-SelfSignedCertificate -Type Custom -Subject "CN=www.wthpoc2023.cc" -HashAlgorithm sha256 -KeyAlgorithm RSA -KeyLength 2048 -KeyUsage KeyEncipherment,DigitalSignature -CertStoreLocation "cert:\LocalMachine\My" -Signer cert:\CurrentUser\My\$($Matches[0]) -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.2","2.5.29.17={text}DNS=www.wthpoc2023.net&DNS=www.wthpoc2023.com&DNS=www.wthpoc2023.cc"))
$_cert_res -match '([0-9ABCDEF]{40})'
netsh http add sslcert ipport=0.0.0.0:443 certhash=$($Matches[0]) appid='{ab3c58f7-8316-42e3-bc6e-771d4ce4b201}'
netsh advfirewall firewall add rule name=https dir=in protocol=tcp localport=443 action=allow enable=yes profile=any
mkdir C:\inetpub\cloudscan\upload
icacls C:\inetpub\cloudscan /grant IIS_IUSRS:`(OI`)`(CI`)F /T
Start-Process ".\vc_redist.x64.exe" -ArgumentList "/install /passive /norestart" -NoNewWindow -Wait
Start-Process ".\vc_redist.x86.exe" -ArgumentList "/install /passive /norestart" -NoNewWindow -Wait
