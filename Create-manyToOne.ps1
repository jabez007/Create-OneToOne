Import-Module WebAdministration

$user = "ceuser"
$pwd = "(312e#!"

Write-Host $env:COMPUTERNAME\$user

Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location 'Default Web Site' -filter "system.webServer/security/authentication/iisClientCertificateMappingAuthentication" -name "manyToOneCertificateMappingsEnabled" -value "True"

Remove-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location 'Default Web Site' -filter "system.webServer/security/authentication/iisClientCertificateMappingAuthentication/manyToOneMappings" -name "." -AtElement @{name='TBRHIO'}

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location 'Default Web Site' -filter "system.webServer/security/authentication/iisClientCertificateMappingAuthentication/manyToOneMappings" -name "." -value @{name='TBRHIO';userName="$env:COMPUTERNAME\$user";password="$pwd"}
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location 'Default Web Site' -filter "system.webServer/security/authentication/iisClientCertificateMappingAuthentication/manyToOneMappings/add[@name='TBRHIO']/rules" -name "." -value @{certificateField='Issuer';certificateSubField='OU';matchCriteria='Cerner Resonance'}

Write-Host "Please review the output above for any errors"
Read-Host "press enter to continue..."