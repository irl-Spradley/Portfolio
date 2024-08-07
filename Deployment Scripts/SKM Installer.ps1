Invoke-ImmyCommand{
    $PackagePath    = "C:\Windows\Temp\ImmyBot\__Instance_GUID__"
    $SKM_Folder     = "C:\PTW32_v11"
    $SKM_Exe        = "PTW32_V11000b1.exe"
    $SKM_LIC        = "ptw32x.lic"
    $Install_Args   = "/s /f1""$PackagePath\setup.iss"""

    $SKM_Lic_Folder = Join-Path $SKM_Folder "bin"
    $SKM_Installer  = Join-Path $PackagePath $SKM_Exe
   
    Write-Host "Installer Package $SKM_Installer"

    #Start-Process -FilePath $SKM_Installer -ArgumentList $Install_Args
    Start-Process -FilePath $SKM_Installer -ArgumentList $Install_Args -Wait
    
    If(!(Test-Path $SKM_Folder)){
       $Rvalue = $False
       Write-Host "Install Folder not found!"
    }#End If
    Else{
        Write-Host "Install Folder found!"
        Copy-Item (Join-path $PackagePath $SKM_LIC) -Destination ($SKM_Lic_Folder) -Force
        Copy-Item (Join-path $PackagePath "uninstall.iss") -Destination ($SKM_Folder) -Force
        Copy-Item (Join-path $PackagePath "setup.iss") -Destination ($SKM_Folder) -Force
        If (Test-Path (Join-Path $SKM_Lic_Folder $SKM_LIC) -PathType Leaf){
            Write-Host "License file copied."
            $Rvalue = $True
        }#End If
        Else{
            Write-Host "License file not found."
            $Rvalue = $False
        }#End Else
    }#End ELse
    Return $Rvalue
}#End Invoke-ImmyCommand