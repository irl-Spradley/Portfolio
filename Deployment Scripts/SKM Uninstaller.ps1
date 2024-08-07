$Version        = "11.0.0.0 build 1"
$SKM_Folder     = "C:\PTW32_v11"
$SKM_Exe        = "PTW32_V11000b1.exe"
$SKM_LIC        = "ptw32x.lic"
$Uninstall_Args   = "/s /f1""c:\ptw32_v11\uninstall.iss"""

$programs = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction Stop
$programs += Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction Stop

foreach ($program in $programs){
    $Name = $program.DisplayName
    if (($Name -eq "Power*Tools For Windows") -or ($Name -eq "Power Tools For Windows")){
        if ($program.DisplayVersion -eq $Version){
            if($program.UninstallString -ne $Null){
                $Name
                $program.DisplayVersion
                $Array_String = $program.UninstallString.trim('"').split('"')
                $Uninstall_String = $Array_String[0]
                $Remove_String = """$Uninstall_String"""
                & cmd /c "$Remove_String $Uninstall_Args"
            }
        }
    }
}