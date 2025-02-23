# Run as administrator for necessary privileges

# Install Winget package manager if not installed
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget not found. Please install it manually or ensure it's available on your system."
    Exit
}

# Install necessary tools via Winget
Write-Host "Installing necessary tools..."

# Firefox (Internet Browser)
winget install Mozilla.Firefox -y

# Chrome (Internet Browser)
winget install Google.Chrome -y

# Spotify (Not from Microsoft Store)
winget install Spotify.Spotify -y

# VSCode (Visual Studio Code)
winget install Microsoft.VisualStudioCode -y

# PowerToys (via winget)
winget install Microsoft.PowerToys -y

# Install TranslucentTB (from Microsoft Store)
Write-Host "Installing TranslucentTB from the Microsoft Store..."
Start-Process "ms-windows-store://pdp/?productid=9PF4KZ2VN4W9"

# Install GlazeWM
winget install GlazeWM.GlazeWM -y

# Download GlazeWM config
Write-Host "Downloading GlazeWM configuration..."
git clone https://example.com/glazewm-config.git

Write-Host "GlazeWM installation complete! Please check the Downloads folder for manual installation."

# Install Zen Browser
winget install Zen-Team.Zen-Browser -y

# Install WezTerm
winget install WezWez.WezTerm -y

# Download WezTerm config
Write-Host "Downloading WezTerm configuration..."
git clone https://example.com/wezterm-config.git

# Final message
Write-Host "All installations complete! Please check for any installation prompts."

# Install League of Legends (NA)
winget install RiotGames.LeagueOfLegends -y

# Install Unix Tab Completion (if applicable)
winget install Microsoft.WindowsTerminal -y

# Add programs to Startup Folder
$startupFolder = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Startup'))

# Function to create shortcut in Startup folder
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

# Create shortcuts for TranslucentTB, Zen, PowerToys Run, and Glaze
Write-Host "Adding apps to Startup..."

# TranslucentTB
$translucentTBPath = "C:\Program Files\TranslucentTB\TranslucentTB.exe" # Update this path if needed
Create-Shortcut -shortcutName "TranslucentTB" -targetPath $translucentTBPath

# Zen
$zenPath = "C:\Program Files\Zen\Zen.exe" # Update this path if needed
Create-Shortcut -shortcutName "Zen" -targetPath $zenPath

# PowerToys Run (Assuming PowerToys Run is part of PowerToys)
$powerToysPath = "C:\Program Files\PowerToys\PowerToys.exe" # Update this path if needed
Create-Shortcut -shortcutName "PowerToys Run" -targetPath $powerToysPath

# Glaze (Assuming Glaze is installed at a specific path)
$glazePath = "C:\Program Files\GlazeWM\Glaze.exe" # Update this path if needed
Create-Shortcut -shortcutName "Glaze" -targetPath $glazePath

Write-Host "All apps added to Startup!"


# install steam

# start steam on launch