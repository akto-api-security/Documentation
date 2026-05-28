$ErrorActionPreference = "Stop"

$installerUrl = "<AKTO_WINDOWS_INSTALLER_EXE_URL>"
$installerPath = Join-Path $env:TEMP "akto-endpoint-shield-setup.exe"
$installerArgs = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"

Write-Host "[Akto] Downloading installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -UseBasicParsing

Write-Host "[Akto] Running installer..."
$p = Start-Process -FilePath $installerPath -ArgumentList $installerArgs -Wait -PassThru

if ($null -eq $p -or $p.ExitCode -ne 0) {
    throw "Akto installer failed. Exit code: $($p.ExitCode)"
}

Write-Host "[Akto] Installation finished successfully."
