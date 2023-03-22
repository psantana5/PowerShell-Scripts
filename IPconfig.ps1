Function Get-Menu{
Clear-Host
Write-Host "IP Settings"
Write-host "1.- Static IP"
Write-Host "2.- IP through DHCP"
Write-Host "3.- Exit"
}
Function Get-Adaptader {
Write-Host "IP Configuration"
Get-NetAdapter|ft -AutoSize
$script:interface = Read-Host "Set adapter Name (IfIndex)"
$script:name = Read-Host "Set its name (name)"

#Remove IP address

Remove-NetIPAddress -InterfaceIndex $interfaz -Confirm:$false
Remove-NetRoute -InterfaceIndex $interfaz -Confirm:$false
}
Function Static-IP {
Get-NetAdapter

#Establecer IP Fija

$ip = Read-host "Set the IP you want to use"
$netmask = Read-Host "Set the net mask (Number of host bits)"
$gateway = Read-Host "Set the gateway"
$dns1 = Read-host "Set the first DNS"
$dns2 = Read-host "Set the first DNS"
New-NetIPAddress -InterfaceIndex $interfaz $ip -PrefixLength $netmask -DefaultGateway $gateway
Set-DnsClientServerAddress -InterfaceIndex $interface -ServerAddresses ("$dns1","$dns2")
Restart-NetAdapter -Name $name
}
Function IP-Dhcp {
Get-NetAdapter
#IP through DHCP	

Set-NetIPInterface -InterfaceIndex $interface -Dhcp enabled
Set-DnsClientServerAddress -InterfaceIndex $interface -ResetServerAddresses

#Restart the adapter

Restart-NetAdapter -Name $name
}
#Start menu

do{
Get-Menu
$option = Read-Host "Elija una opción"
switch ($option){
'1'{Static-IP}
'2'{IP-Dhcp}
'3'{exit}
Default {Write-Host "Please, choose a correct option"}
}
$intro = Read-Host "Pulse intro para continuar"
}while ($true)