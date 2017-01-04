$files = Get-ChildItem -Exclude *e.mp4 -File -Filter *.mp4 *.mov -Name
   

foreach ($f in $files) {
    $name=[io.path]::GetFileNameWithoutExtension($f)
    $ext=[io.path]::GetExtension($f).ToLower()
    
    $outname=$name + "e.mp4"
    $Exist = Test-Path $outname
    if (!$Exist){
        if ($ext -eq ".mp4")
        {
            C:\MYGP\ffmpeg-20161230-6993bb4-win64-static\bin\ffmpeg.exe -i $f -f mp4 -acodec copy -c:v libx264 -q:v 5 $outname
        }
        elseif ($ext -eq ".mov")
        {
            C:\MYGP\ffmpeg-20161230-6993bb4-win64-static\bin\ffmpeg.exe -i $f -f mp4 -c:a libmp3lame -vbr 5 -ac 2 -c:v libx264 -q:v 5 $outname
        }
        $i1 = Get-Item $f
        $i2 = Get-Item $outname
        $i2.CreationTime= $i1.CreationTime
        $i2.LastWriteTime = $i1.LastWriteTime
    }
}
