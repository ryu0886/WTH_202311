apt update
apt -y install qemu-system
cat <<EOF > /tmp/index.html
<html><body><p>Linux startup script added directly.<br><a href="main.html">go to main page</a></p></body></html>
EOF