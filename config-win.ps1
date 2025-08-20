# -----------------------------------------------------------------------------------------------------------------------
# Config Windows:
#	1. Enable Remote Desktop
#	2. Set Time Zone to GMT+8
#	3. Disable IPv6 (optional)
#	4. (skipped for AWS EC2) Set IP Address, NetworkMask, Default Gateway, DNS
#	5. Set Computer Name
#	6. Join Domain (Manual after reboot)
#
# Usage:
#  iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/makuowei/WinServerConfig/master/config-win.ps1'))
#  
#  OR if git has been installed...
#
#  git clone https://github.com/makuowei/WinServerConfig.git
#  cd WinServerConfig
#  config-win.ps1
  
# 1. Enable Remote Desktop
Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0
Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'

# 2. Set Time Zone
tzutil /s 'China Standard Time'

# 3. Disable IPv6
# New-ItemProperty “HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\” -Name “DisabledComponents” -Value 0xffffffff -PropertyType “DWord"

# 4. Set Network IP Address, NetworkMask, Default Gateway, DNS
# $IPAddress = Read-Host -Prompt 'IP Address: '
# $DNSServer = Read-Host -Prompt 'DNS Server: '

# Remove-NetIPAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex
# New-NetIPAddress -IPAddress $IPAddress -DefaultGateway 172.16.1.1 -PrefixLength 16 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
# Set-DNSClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses $DNSServer

# 5. Set Computer Name 
# $NewComputerName = Read-Host -Prompt 'Computer Name: '
# Rename-Computer -NewName $NewComputerName
# $restart = Read-Host -Prompt 'Restart (Y/N)? '
# if ($restart -eq 'Y') { Restart-Computer }

# 6. Join Domain
# $Domain = Read-Host -Prompt 'Domain: '
# Add-Computer -DomainName $Domain


# 5 & 6. Rename Computer and Join Domain
$NewComputerName = Read-Host -Prompt 'Computer Name: '
$Domain = Read-Host -Prompt 'Domain: '
Add-Computer -DomainName $Domain -NewName $NewComputerName -Restart

