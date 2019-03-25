function vim ($File){
  $File = $File -replace "\\", "/"
  bash -c "vim $File"
}

Set-PSReadLineOption -EditMode Emacs
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Import-Module PSVirtualBox
