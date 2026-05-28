$ErrorActionPreference = "Stop"

$regPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$extensionValue = "<AKTO_CHROME_EXTENSION_ID>;<AKTO_CHROME_UPDATE_XML_URL>"

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

New-ItemProperty -Path $regPath -Name "1" -PropertyType String -Value $extensionValue -Force | Out-Null
Write-Host "[Akto] Chrome extension force-install policy set: $extensionValue"
