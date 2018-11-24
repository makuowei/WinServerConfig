
#Enable Remote Desktop
Set-ItemProperty 'HKLM:System\CurrentControlSet\Control\TerminalServer' -Name fDenyTSConnections -Value 0 

#Set Time Zone
tzutil /s 'China Standard Time"

#--------------------------------------------------------------------------------
#Set Computer Name
$NewComputerName = Read-Host -Prompt "Computer Name: "

#$Computer = Get-WmiObject Win32_ComputerSystem
#$Computer.Rename($NewComputerName)

Rename-Computer -NewName $NewComputerName

#---------------------------------------------------------------------------------
# Disable IPv6
New-ItemProperty “HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\” -Name “DisabledComponents” -Value 0xffffffff -PropertyType “DWord"

#Set Network Address
$NICs = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE
foreach ($nic in $NICs) {
	Write-Host (Get-WmiObject Win32_NetworkAdapter | where {$_.DeviceId -eq $nic.index}).NetConnectionID
	$EnableDHCP = Read-Host -Prompt 'Enable DHCP (Default=N)'
	if ($EnableDHCP -eq 'Y') {
		$nic.EnableDHCP() }
	else {
		$IP = Read-Host -Prompt "IP Address"
		$NetMask = Read-Host -Prompt "Netmask"
		$GW =  Read-Host -Prompt "Default Gateway"
		$DNS = Read-Host -Prompt "DNS Server"

		netsh interface ip set address name=”Local Area Connection” static 192.168.0.1 255.255.255.0 192.168.0.254

		$nic.EnableStatic($IP, $NetMask)
		$nic.SetGateways($GW)
		$nic.SetDNSServerSearchOrder($DNS)
		$nic.SetDnaamicDNSRegistration($true)
	}
}




# Windows 2008 R2
slmgr.vbs -ipk CQBX4-WRTF7-69JB3-78BM7-WX937

# Windows 8
slmgr.vbs -ipk N8922-M4RM6-VWGCF-VCHCM-PRYQP

# Windows Server 2012
slmgr.vbs -ipk 2NFVD-MV88T-XRYKQ-46XD8-6MQKX


$LicService = Get-wmiObject -query "select * from SoftwareLicensingService"
$LicService.InstallProductKey($Key)
$LicService.RefreshLicenseStatus()

  