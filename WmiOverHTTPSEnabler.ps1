# Run this PS1 in your Windows machine to enable WMI with HTTPS using a self-signed certificate.

# This part gets your local machine hostname, it will be required in the next step.
$server = hostname

# This part will create a new self signed cert and will select only the Thumbprint, which is the part that you realy need.
$certificado = New-SelfSignedCertificate -DnsName $server -CertStoreLocation Cert:\LocalMachine\My | Select-Object Thumbprint | findstr /v \- | findstr /v Thumbprint | findstr /v "^$"

# Here the magic happens, you will enable WMI using the Thumbprint extracted in the last step.
New-Item WSMan:\localhost\Listener -Address * -Transport HTTPS -HostName $servidor -CertificateThumbPrint $certificado -Force
