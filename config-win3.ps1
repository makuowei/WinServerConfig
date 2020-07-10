# 1. Enable Remote Desktop
Set-ItemProperty 'HKLM:System\CurrentControlSet\Control\TerminalServer' -Name fDenyTSConnections -Value 0 

# 2. Set Time Zone
tzutil /s 'China Standard Time'

# 3. Disable IPv6
# New-ItemProperty “HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\” -Name “DisabledComponents” -Value 0xffffffff -PropertyType “DWord"

# 4. Set Network IP Address, NetworkMask, Default Gateway, DNS
$IPAddress = Read-Host -Prompt 'IP Address: '
Set-NetIPAddress –IPAddress $IPAddress -DefaultGateway 172.16.1.1 -PrefixLength 16 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses 172.16.1.5

# 5. Set Computer Name
$NewComputerName = Read-Host -Prompt 'Computer Name: '
Rename-Computer -NewName $NewComputerName

# 6. Join Domain
$Domain = Read-Host -Prompt 'Domain: '
Add-Computer -Domain $Domain
