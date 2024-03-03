Param($scriptName)

$scriptPath       = $MyInvocation.MyCommand.Path
$myPath           = Split-Path -Parent $scriptPath

$uwscDownloadUrl  = 'https://ftp.vector.co.jp/68/82/2330/uwsc5302.zip'
$uwscArchiveName  = ($uwscDownloadUrl -Split '/')[-1]

$uwscArchiveDownloadPath = Join-Path -Path $myPath -ChildPath $uwscArchiveName
$uwscInstallPath         = Join-Path -Path $myPath -ChildPath 'uwsc'

$checkUwscInstall = Test-Path $uwscInstallPath

if (!$checkUwscInstall) {
    try {
        (New-Object System.Net.WebClient).DownloadFile($uwscDownloadUrl, $uwscArchiveDownloadPath)
        Expand-Archive -Path $uwscArchiveDownloadPath -DestinationPath $uwscInstallPath
    } catch {
        exit -1
    }
}

$Env:Path = $uwscInstallPath + ';' + $Env:Path

if (! [String]::IsNullOrEmpty($scriptName)) {
    & UWSC.exe $scriptName
}
