param(
    [switch]$Silent,
    [string]$TomcatZipUrl = "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.117/bin/apache-tomcat-9.0.117.zip",
    [string]$TomcatInstallPath = "C:\Tomcat9"
)

$ErrorActionPreference = "Stop"

function Write-Info($msg) {
    Write-Host "[INFO] $msg" -ForegroundColor Cyan
}

function Write-Ok($msg) {
    Write-Host "[OK]   $msg" -ForegroundColor Green
}

function Write-WarnMsg($msg) {
    Write-Host "[WARN] $msg" -ForegroundColor Yellow
}

function Write-Err($msg) {
    Write-Host "[ERR]  $msg" -ForegroundColor Red
}

function Ensure-Admin {
    $current = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($current)
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        throw "Este script debe ejecutarse como Administrador."
    }
}

function Ensure-Java {
    $javaCmd = Get-Command java -ErrorAction SilentlyContinue
    if (-not $javaCmd) {
        throw "No se encontro Java en PATH. Instala primero JDK 21."
    }

    $javaVersionText = & java --version 2>&1 | Out-String
    if ($javaVersionText -notmatch "21") {
        Write-WarnMsg "Java detectado pero no parece ser version 21. Continuando de todos modos."
        Write-Host $javaVersionText
    } else {
        Write-Ok "Java detectado correctamente para Tomcat."
    }
}

function Ensure-Directory([string]$path) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -ItemType Directory | Out-Null
    }
}

function Install-Tomcat9 {
    Write-Info "Descargando Tomcat 9 desde URL oficial..."

    $tempRoot = Join-Path $env:TEMP "tomcat9-installer"
    $zipPath = Join-Path $tempRoot "apache-tomcat-9.zip"
    $extractPath = Join-Path $tempRoot "extract"

    Ensure-Directory $tempRoot
    if (Test-Path $extractPath) {
        Remove-Item $extractPath -Recurse -Force
    }
    Ensure-Directory $extractPath

    Invoke-WebRequest -Uri $TomcatZipUrl -OutFile $zipPath

    Write-Info "Descomprimiendo Tomcat en ruta fija de clase..."
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

    $tomcatFolder = Get-ChildItem -Path $extractPath -Directory | Where-Object { $_.Name -like "apache-tomcat-9*" } | Select-Object -First 1
    if (-not $tomcatFolder) {
        throw "No se encontro carpeta de Tomcat en el ZIP descargado."
    }

    if (Test-Path $TomcatInstallPath) {
        Write-WarnMsg "La ruta $TomcatInstallPath ya existe. Se reemplazara para estandarizar la clase."
        Remove-Item -Path $TomcatInstallPath -Recurse -Force
    }

    Move-Item -Path $tomcatFolder.FullName -Destination $TomcatInstallPath
    Write-Ok "Tomcat 9 instalado en: $TomcatInstallPath"
}

function Verify-Tomcat9 {
    $catalinaBat = Join-Path $TomcatInstallPath "bin\catalina.bat"
    $versionBat = Join-Path $TomcatInstallPath "bin\version.bat"

    if (-not (Test-Path $catalinaBat)) {
        throw "No se encontro catalina.bat en $TomcatInstallPath."
    }

    [Environment]::SetEnvironmentVariable("CATALINA_HOME", $TomcatInstallPath, "Machine")
    Write-Ok "CATALINA_HOME configurado a $TomcatInstallPath"

    if (Test-Path $versionBat) {
        $versionOutput = & $versionBat 2>&1 | Out-String
        if ($versionOutput -match "Tomcat/9") {
            Write-Ok "Version de Tomcat 9 validada correctamente."
        } else {
            Write-WarnMsg "Tomcat instalado, pero no se pudo validar claramente version 9."
        }
    }

    $desktop = [Environment]::GetFolderPath("Desktop")
    $startShortcutPath = Join-Path $desktop "Iniciar Tomcat 9.lnk"
    $stopShortcutPath = Join-Path $desktop "Detener Tomcat 9.lnk"

    try {
        $wsh = New-Object -ComObject WScript.Shell

        $startShortcut = $wsh.CreateShortcut($startShortcutPath)
        $startShortcut.TargetPath = Join-Path $TomcatInstallPath "bin\startup.bat"
        $startShortcut.WorkingDirectory = Join-Path $TomcatInstallPath "bin"
        $startShortcut.Save()

        $stopShortcut = $wsh.CreateShortcut($stopShortcutPath)
        $stopShortcut.TargetPath = Join-Path $TomcatInstallPath "bin\shutdown.bat"
        $stopShortcut.WorkingDirectory = Join-Path $TomcatInstallPath "bin"
        $stopShortcut.Save()

        Write-Ok "Accesos directos creados en escritorio para iniciar/detener Tomcat 9."
    } catch {
        Write-WarnMsg "No se pudieron crear accesos directos: $($_.Exception.Message)"
    }
}

try {
    Ensure-Admin
    Ensure-Java
    Install-Tomcat9
    Verify-Tomcat9

    Write-Ok "Proceso completado. Reinicia sesion para refrescar variables de entorno."
} catch {
    Write-Err $_.Exception.Message
    exit 1
}
