param(
    [string]$RemoteHost = 'PUB400',
    [string]$User = 'YOUR_USER',
    [int]$SshPort = 22
)

$ErrorActionPreference = 'Stop'

$localDir = Split-Path -Parent $PSCommandPath
$remoteDir = '/tmp/FGUTIERRM1_SQL'
$remoteScript = '/tmp/subir_qsqlsrc_qsh.sh'

if (-not (Get-Command scp.exe -ErrorAction SilentlyContinue)) {
    throw 'No se encontró scp.exe en PATH. Ajusta tu PATH o usa OpenSSH/Putty.'
}

if (-not (Get-Command ssh.exe -ErrorAction SilentlyContinue)) {
    throw 'No se encontró ssh.exe en PATH. Ajusta tu PATH o usa OpenSSH/Putty.'
}

Write-Host ("Subiendo los .sql de {0} a {1}@{2}:{3}" -f $localDir, $User, $RemoteHost, $remoteDir)

$target = "{0}@{1}" -f $User, $RemoteHost
ssh.exe -p $SshPort $target "if [ -e '$remoteDir' ] && [ ! -d '$remoteDir' ]; then rm -f '$remoteDir'; fi; mkdir -p '$remoteDir'"

$sqlFiles = Get-ChildItem -Path $localDir -Filter '*.sql' | ForEach-Object { $_.FullName }
scp.exe -P $SshPort @sqlFiles ("{0}:{1}/" -f $target, $remoteDir)

scp.exe -P $SshPort ("{0}\subir_qsqlsrc_qsh.sh" -f $localDir) ("{0}:{1}" -f $target, $remoteScript)
ssh.exe -p $SshPort $target ("chmod 755 {0} && {0} {1}" -f $remoteScript, $remoteDir)

Write-Host 'Proceso completado. Revisa los miembros en FGUTIERRM1/QSQLSRC.'
