function prompt {
    $time = Get-Date -Format "HH:mm:ss"
    $pwd = Get-Location 
    return "[$time]` Alex@Divinci [$pwd]> "
}