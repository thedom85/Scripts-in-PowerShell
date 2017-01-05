/* 
#– – – – – – – – – – – – – – – – – – – – – – – – – – – – – 
#Title : Scripts-in-PowerShell
#Author : Domenico Zinzi
#URL : https://github.com/thedom85/Scripts-in-PowerShell/edit/master/Mp4FilesResize.ps1
#Description : Resize quolity mp4 e mov  
#Created : 2017/05/01
#Modified : 
#– – – – – – – – – – – – – – – – – – – – – – – – – – – – – 

#open windows powershell (run as administrator)

$cmdName="ffmpeg"
$cmdName2="choco"
if (!(Get-Command $cmdName -errorAction SilentlyContinue))
{
    if (!(Get-Command $cmdName2 -errorAction SilentlyContinue))
    {
         Write-Host "######################################################"
         Write-Host "#Installing Chocolatey #"
         Write-Host "######################################################"
         
         set-executionpolicy remotesigned
         iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
         Write-Host
    }
    Write-Host "############################################"
    Write-Host "# Installing applications from Chocolatey  #"
    Write-Host "############################################"
    Write-Host
   cinst ffmpeg -y
}


$files = Get-ChildItem -Exclude *e.mp4 -File -Filter *.mp4 *.mov -Name
   

foreach ($f in $files) {
    $name=[io.path]::GetFileNameWithoutExtension($f)
    $ext=[io.path]::GetExtension($f).ToLower()
    
    $outname=$name + "e.mp4"
    $Exist = Test-Path $outname
    if (!$Exist){
        if ($ext -eq ".mp4")
        {
            ffmpeg -i $f -f mp4 -acodec copy -c:v libx264 -q:v 5 $outname
        }
        elseif ($ext -eq ".mov")
        {
            ffmpeg -i $f -f mp4 -c:a libmp3lame -vbr 5 -ac 2 -c:v libx264 -q:v 5 $outname
        }
        $i1 = Get-Item $f
        $i2 = Get-Item $outname
        $i2.CreationTime= $i1.CreationTime
        $i2.LastWriteTime = $i1.LastWriteTime
    }
}
