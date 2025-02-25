# Ensure the script is run as administrator for necessary privileges
# Check if 'winget' is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget not found. Attempting to install winget..."

    # Check if the Microsoft Store is available to install winget
    $wingetInstallerUrl = "https://aka.ms/Get-Help-Winget"
    
    try {
        Write-Host "Downloading Winget installer..."
        # Attempt to download the installer for winget
        Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile "$env:temp\winget-installer.exe"
        
        Write-Host "Starting Winget installation..."
        Start-Process -FilePath "$env:temp\winget-installer.exe" -Wait
        
        # Check if winget was installed successfully
        if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
            Write-Host "Failed to install Winget. Please install it manually or troubleshoot further."
            Exit
        } else {
            Write-Host "Winget installed successfully!"
        }
    } catch {
        Write-Host "An error occurred while downloading or installing Winget: $_"
        Exit
    }
}

# Function to install programs using winget
Function Install-Program {
    param (
        [string]$packageName
    ) 
    Write-Host "Installing $packageName..."
    winget install $packageName --accept-package-agreements --accept-source-agreements
}

$username = $env:USERNAME
$domain = $env:USERDOMAIN

# Install necessary tools via Winget
Write-Host "Installing essential tools..."

# Install Browsers
Install-Program -packageName "Mozilla.Firefox"    # Firefox
Install-Program -packageName "Google.Chrome"     # Chrome
Install-Program -packageName "Zen-Team.Zen-Browser"  # Zen Browser

# Install Media and Development Tools
Install-Program -packageName "Git.Git"
Install-Program -packageName "Microsoft.VisualStudioCode"  # VSCode
Install-Program -packageName "Microsoft.PowerToys"    # PowerToys
Install-Program -packageName "wez.wezterm"   # WezTerm
Install-Program -packageName "RiotGames.LeagueOfLegends.NA"  # League of Legends
Install-Program -packageName "Microsoft.WindowsTerminal"  # Unix Tab Completion (Windows Terminal)
Install-Program -packageName "Valve.Steam"  # Steam (for installation)
Install-Program -packageName "GlazeWM"   # GlazeWM

Write-Host "Spotify Downloading..."
Start-Process winget -ArgumentList 'install', 'Spotify.Spotify', '--accept-package-agreements', '--accept-source-agreements' -Verb RunAs

# Download configurations for GlazeWM and WezTerm
Write-Host "Downloading configuration files..."


cd ~\Documents

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd C:\Users\$username\Documents; Remove-Item -Path C:\Users\$username\Documents\windows-config\ -Recurse -Force -ErrorAction SilentlyContinue; git clone https://github.com/A-Waters/windows-config.git"

Start-Sleep -Seconds 5

cp windows-config\.wezterm.lua ~ 
cp windows-config\Microsoft.PowerShell_profile.ps1 ~
cp -Recurse windows-config\.glzr ~
Write-Host "GlazeWM and WezTerm configurations downloaded! Please check the Downloads folder for manual installation."



# Add Programs to Startup Folder
$startupFolder = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Startup'))

# Function to create a shortcut in the Startup folder
Function Create-Shortcut {
    param (
        [string]$shortcutName,
        [string]$targetPath
    )
    try {
        $wsh = New-Object -ComObject WScript.Shell
        $shortcut = $wsh.CreateShortcut([System.IO.Path]::Combine($startupFolder, "$shortcutName.lnk"))
        $shortcut.TargetPath = $targetPath
        $shortcut.Save()
        Write-Host "$shortcutName added to Startup."
    } catch {
        Write-Host "Failed to create shortcut for $shortcutName : $_"
    }
}

# Set up paths for the programs to be added to Startup
$appsToAddToStartup = @{
    "Zen"              = "C:\Program Files\Zen Browser\Zen.exe"
    "PowerToys Run"    = "C:\Program Files\PowerToys\PowerToys.exe"
    "Glaze"            = "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"
    "Steam"            = "C:\Program Files\Steam\steam.exe"
}

# Add programs to startup
Write-Host "Adding programs to startup..."

foreach ($app in $appsToAddToStartup.Keys) {
    $appPath = $appsToAddToStartup[$app]
    if (Test-Path $appPath) {
        Create-Shortcut -shortcutName $app -targetPath $appPath
    } else {
        Write-Host "$app not found at $appPath, skipping."
    }
}

# Final messages
Write-Host "All installations complete!"
Write-Host "Please check for any installation prompts and ensure the shortcuts are created in the Startup folder."

Write-Host "For further configuration, please visit the configuration repositories: https://github.com/A-Waters/windows-config"


net USER $username /passwordreq:yes
# Optional restart (uncomment if needed)
# restart
