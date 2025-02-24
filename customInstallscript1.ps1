# Ensure the script is run as administrator for necessary privileges
# Check if 'winget' is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget not found. Please install it manually or ensure it's available on your system."
    Exit
}

# Function to install programs using winget
Function Install-Program {
    param (
        [string]$packageName
    )
    Write-Host "Installing $packageName..."
    winget install $packageName -y
}

# Install necessary tools via Winget
Write-Host "Installing essential tools..."

# Install Browsers
Install-Program -packageName "Mozilla.Firefox"    # Firefox
Install-Program -packageName "Google.Chrome"     # Chrome
Install-Program -packageName "Zen-Team.Zen-Browser"  # Zen Browser

# Install Media and Development Tools
Install-Program -packageName "Spotify.Spotify"   # Spotify
Install-Program -packageName "Microsoft.VisualStudioCode"  # VSCode
Install-Program -packageName "Microsoft.PowerToys"    # PowerToys
Install-Program -packageName "WezWez.WezTerm"   # WezTerm
Install-Program -packageName "RiotGames.LeagueOfLegends"  # League of Legends
Install-Program -packageName "Microsoft.WindowsTerminal"  # Unix Tab Completion (Windows Terminal)

# Install GlazeWM via winget
Install-Program -packageName "GlazeWM.GlazeWM"   # GlazeWM

# Download configurations for GlazeWM and WezTerm
Write-Host "Downloading configuration files..."
cd "~\desktop"
git clone https://github.com/A-Waters/windows-config.git
cp windows-config\.wezterm.lua ~\.wezterm.lua 
cp windows-config\Microsoft.PowerShell_profile.ps1 $PROFILE

Write-Host "GlazeWM and WezTerm configurations downloaded! Please check the Downloads folder for manual installation."

# Add Steam to the installation
Install-Program -packageName "Steam.Steam"  # Steam (for installation)

# Add Programs to Startup Folder
$startupFolder = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Startup'))

# Function to create a shortcut in the Startup folder
Function Create-Shortcut {
    param (
        [string]$shortcutName,
        [string]$targetPath
    )
    $wsh = New-Object -ComObject WScript.Shell
    $shortcut = $wsh.CreateShortcut([System.IO.Path]::Combine($startupFolder, "$shortcutName.lnk"))
    $shortcut.TargetPath = $targetPath
    $shortcut.Save()
}

# Set up paths for the programs to be added to Startup
$appsToAddToStartup = @{
    "Zen"              = "C:\Program Files\Zen\Zen.exe"
    "PowerToys Run"    = "C:\Program Files\PowerToys\PowerToys.exe"
    "Glaze"            = "C:\Program Files\GlazeWM\Glaze.exe"
    "Steam"            = "C:\Program Files\Steam\steam.exe"
}

# Add programs to startup
Write-Host "Adding programs to startup..."

foreach ($app in $appsToAddToStartup.Keys) {
    $appPath = $appsToAddToStartup[$app]
    if (Test-Path $appPath) {
        Create-Shortcut -shortcutName $app -targetPath $appPath
        Write-Host "$app added to Startup."
    } else {
        Write-Host "$app not found at $appPath, skipping."
    }
}

# Final messages
Write-Host "All installations complete!"
Write-Host "Please check for any installation prompts and ensure the shortcuts are created in the Startup folder."

Write-Host "For further configuration, please visit the configuration repositories: https://github.com/A-Waters/windows-config"


restart