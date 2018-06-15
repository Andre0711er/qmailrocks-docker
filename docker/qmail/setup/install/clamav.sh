sed -i 's/Foreground false/Foreground true/' /etc/clamav/clamd.conf
sed -i 's/LogTime true/LogTime false/' /etc/clamav/clamd.conf
sed -i 's/LogClean false/LogClean true/' /etc/clamav/clamd.conf
sed -i 's/LogVerbose false/LogVerbose true/' /etc/clamav/clamd.conf
sed -i 's/LocalSocket/# LocalSocket/' /etc/clamav/clamd.conf
echo "LocalSocket /tmp/clamd.sock" >> /etc/clamav/clamd.conf

sed -i 's/Foreground false/Foreground true/' /etc/clamav/freshclam.conf
echo "OnUpdateExecute /opt/scripts/freshclam-good.sh" >> /etc/clamav/freshclam.conf
echo "OnErrorExecute /opt/scripts/freshclam-bad.sh" >> /etc/clamav/freshclam.conf
