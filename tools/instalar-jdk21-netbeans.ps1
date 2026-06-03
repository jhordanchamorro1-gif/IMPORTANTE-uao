param(
    [switch]$Silent,
    [string]$NetBeansVersion = "21",
    [switch]$InstallTomcat9,
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

function Ensure-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "No se encontro winget. Instala App Installer desde Microsoft Store y reintenta."
    }
}

function Ensure-Directory([string]$path) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -ItemType Directory | Out-Null
    }
}

function Install-JDK21 {
    Write-Info "Instalando Eclipse Temurin JDK 21..."
    $args = @(
        "install",
        "--id", "EclipseAdoptium.Temurin.21.JDK",
        "--exact",
        "--accept-package-agreements",
        "--accept-source-agreements"
    )

    if ($Silent) {
        $args += "--silent"
    }

    winget @args
    Write-Ok "Instalacion de JDK 21 finalizada."
}

function Install-NetBeans {
    Write-Info "Instalando Apache NetBeans $NetBeansVersion..."
    $args = @(
        "install",
        "--id", "Apache.NetBeans",
        "--exact",
        "--accept-package-agreements",
        "--accept-source-agreements"
    )

    if ($Silent) {
        $args += "--silent"
    }

    winget @args
    Write-Ok "Instalacion de NetBeans finalizada."
}

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Find-JavaExe {
    $javaCmd = Get-Command java -ErrorAction SilentlyContinue
    if ($javaCmd) {
        return $javaCmd.Source
    }

    $candidates = @(
        "$env:ProgramFiles\Eclipse Adoptium\jdk-21*\bin\java.exe",
        "$env:ProgramFiles\Java\jdk-21*\bin\java.exe"
    )

    foreach ($pattern in $candidates) {
        $found = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) {
            return $found.FullName
        }
    }

    return $null
}

function Find-NetBeansExe {
    $candidates = @(
        "$env:ProgramFiles\NetBeans*\netbeans\bin\netbeans64.exe",
        "$env:ProgramFiles\Apache NetBeans*\bin\netbeans64.exe",
        "$env:ProgramFiles\Apache NetBeans*\netbeans\bin\netbeans64.exe"
    )

    foreach ($pattern in $candidates) {
        $found = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) {
            return $found.FullName
        }
    }

    return $null
}

function Verify-JDK {
    Refresh-Path

    $javaExe = Find-JavaExe
    if (-not $javaExe) {
        throw "No se encontro java.exe despues de instalar JDK 21."
    }

    $javaVersionText = & $javaExe --version 2>&1 | Out-String
    if ($javaVersionText -notmatch "21") {
        Write-WarnMsg "Se encontro Java, pero no parece ser version 21. Salida detectada:"
        Write-Host $javaVersionText
    } else {
        Write-Ok "Java 21 detectado correctamente."
    }

    $javaHome = Split-Path (Split-Path $javaExe -Parent) -Parent
    [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "Machine")
    Write-Ok "JAVA_HOME configurado a $javaHome"
}

function Verify-NetBeans {
    $netbeansExe = Find-NetBeansExe
    if (-not $netbeansExe) {
        throw "No se encontro NetBeans despues de la instalacion."
    }

    Write-Ok "NetBeans detectado en: $netbeansExe"

    $desktop = [Environment]::GetFolderPath("Desktop")
    $shortcutPath = Join-Path $desktop "NetBeans.lnk"
    if (-not (Test-Path $shortcutPath)) {
        try {
            $wsh = New-Object -ComObject WScript.Shell
            $shortcut = $wsh.CreateShortcut($shortcutPath)
            $shortcut.TargetPath = $netbeansExe
            $shortcut.WorkingDirectory = Split-Path $netbeansExe -Parent
            $shortcut.Save()
            Write-Ok "Acceso directo de NetBeans creado en escritorio."
        } catch {
            Write-WarnMsg "No se pudo crear acceso directo: $($_.Exception.Message)"
        }
    }
}

function Install-Tomcat9 {
    Write-Info "Instalando Tomcat 9 en ruta fija: $TomcatInstallPath"

    $tempRoot = Join-Path $env:TEMP "tomcat9-installer"
    $zipPath = Join-Path $tempRoot "apache-tomcat-9.zip"
    $extractPath = Join-Path $tempRoot "extract"

    Ensure-Directory $tempRoot
    if (Test-Path $extractPath) {
        Remove-Item $extractPath -Recurse -Force
    }
    Ensure-Directory $extractPath

    Invoke-WebRequest -Uri $TomcatZipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

    $tomcatFolder = Get-ChildItem -Path $extractPath -Directory | Where-Object { $_.Name -like "apache-tomcat-9*" } | Select-Object -First 1
    if (-not $tomcatFolder) {
        throw "No se encontro carpeta de Tomcat en el ZIP descargado."
    }

    if (Test-Path $TomcatInstallPath) {
        Write-WarnMsg "La ruta $TomcatInstallPath ya existe. Se reemplazara por una instalacion limpia."
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
            Write-WarnMsg "Tomcat instalado, pero no se pudo validar claramente la version 9."
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

        Write-Ok "Accesos directos para iniciar/detener Tomcat 9 creados en escritorio."
    } catch {
        Write-WarnMsg "No se pudieron crear accesos directos de Tomcat: $($_.Exception.Message)"
    }
}

try {
    Write-Info "Validando prerrequisitos..."
    Ensure-Admin
    Ensure-Winget

    Install-JDK21
    Verify-JDK

    Install-NetBeans
    Verify-NetBeans

    if ($InstallTomcat9) {
        Install-Tomcat9
        Verify-Tomcat9
    }

    Write-Ok "Proceso completado. Recomendacion: reiniciar sesion para refrescar variables de entorno."
    Write-Host ""
    Write-Host "Si NetBeans no detecta Java automaticamente, inicia NetBeans con este parametro:"
    Write-Host "--jdkhome `"$env:JAVA_HOME`""
} catch {
    Write-Err $_.Exception.Message
    exit 1
}
