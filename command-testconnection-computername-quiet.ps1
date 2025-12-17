#.\function-testconnection-computername-quiet.ps1

# Reinicie o serviço de rede e depois reinicie o PC
#ipconfig /flushdns
#ipconfig /registerdns
#netsh winsock reset

Test-Connection -ComputerName google.com -Quiet