write-host "welcome to the file renamer"

$fileName = read-host "enter the name of the file you want to rename (including extension)"



if (Test-Path $fileName){
    write-host "file found! preparing the name..."

    $fileInfo = Get-Item $fileName

    echo "file info"

    $fileInfo

    $newFileName = "$($fileInfo.BaseName)_$(Get-Date -Format 'yyyyMMdd')$($fileInfo.Extension)"

    Rename-Item $fileName $newFileName

    write-host "file successfully renamed from $($fileInfo.Name) to $newFileName"

    $creationDate = $fileInfo.creationTime

    write-host "file was cretaed on: $($creationDate.ToString('yyyy-MM-dd'))"

} else {
    write-host "error: the file $fileName does not exist in the current directory"
    exit
}