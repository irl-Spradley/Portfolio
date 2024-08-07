#Configure Settings for package.
Invoke-HKCU{
   # Note: Had to leave out the ":" in the below line "Inc.\C:\PTW23" due to an issue with powershell not allowing the creation of
   #       ItemProperties under a registry item key with a ":" in the name.  Will rename the Registry Item Key name at the end.
   #$BasePath = 'HKCU:\SOFTWARE\SKM Systems Analysis, Inc.\C:\PTW32\bin\SKM Power*Tools\Application'
   $BasePath = 'HKCU:\SOFTWARE\SKM Systems Analysis, Inc.\C:\PTW32_V11\bin\SKM Power*Tools\Application'
   If((Test-Path -LiteralPath $BasePath) -ne $true) { New-Item $BasePath -force -ea SilentlyContinue | Out-Null };
   If((Test-Path -LiteralPath 'HKCU:\SOFTWARE\SKM Systems Analysis, Inc.\C:') -eq $true) { Rename-Item 'HKCU:\Software\SKM Systems Analysis, Inc.\C:' 'C' | Out-Null };
     
   $BasePath = 'HKCU:\SOFTWARE\SKM Systems Analysis, Inc.\C\PTW32_v11\bin\SKM Power*Tools\Application'
   New-ItemProperty -LiteralPath $BasePath -Name "Protection"            -Value ([int](7)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "BypassLogin"           -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginDapper"           -Value ([int](1)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginTMS"              -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginAFAULT"           -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginIECFAULT"         -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginCAPTOR"           -Value ([int](1)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginISIM"             -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginDeviceEvaluation" -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginHIWAVE"           -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginUnbalanced"       -Value ([int](1)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginReliability"      -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginArcFlash"         -Value ([int](1)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginBatterySizing"    -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginDCLoadFlow"       -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginDCShortCircuit"   -Value ([int](0)) -PropertyType String -Force | Out-Null
   New-ItemProperty -LiteralPath $BasePath -Name "LoginIEC61363"         -Value ([int](0)) -PropertyType String -Force | Out-Null
   
   $BasePath = 'HKCU:\SOFTWARE\SKM Systems Analysis, Inc.\C\PTW32_v11\bin\SKM Power*Tools\ComponentEditor'
   If((Test-Path -LiteralPath $BasePath) -ne $true) { New-Item $BasePath -force -ea SilentlyContinue | Out-Null };
     
   New-ItemProperty -LiteralPath $BasePath -Name "FormatLibrary" -Value "C:\\PTW32_v11\\LIB\\COMPEDIT.FMT" -PropertyType String -Force | Out-Null
   
   #Renaming the folder Item due to bug in powershell to write to Item key with a ":" in the name.
   Rename-Item 'HKCU:\Software\SKM Systems Analysis, Inc.\C' 'C:'
}
Invoke-ImmyCommand{

   # Updating License File Location
   
   #Set the license file location to the install folder location instead of the default.
   #License file discovery registry variables
   $BasePath            = 'Registry::HKCR\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\FLEXlm License Manager'
   $Key                 = 'MDAXBBWC_LICENSE_FILE'
   $KeyValue            = 'C:\PTW32_V11\bin'
   New-Item $BasePath -Force | Out-Null
   New-ItemProperty $BasePath -Name $Key -Value $KeyValue -Force | Out-Null
   
   #License file location variables
   $DestinationPath     = "C:\PTW32_v11\bin"
   $DestinationFilePath = "C:\PTW32_v11\bin\ptw32x.lic"
   $SourceFilePath      = "C:\Windows\Temp\ImmyBot\__Instance_GUID__\ptw32.lic"

   # Check if the source file exists
   if (Test-Path $SourceFilePath -PathType Leaf) {
      Copy-Item $SourceFilePath -Destination $DestinationPath -Force
      # Confirm the file has been moved

     If (Test-Path $DestinationFilePath -PathType Leaf){
        Write-Output "File successfully moved to $DestinationPath"
     } else {
        Write-Output "Failed to copy the file."
     } # End Else
   } else {
      Write-Output "Source file does not exist at $SourceFilePath"
   } # End else
} # End Invoke-ImmyCommand