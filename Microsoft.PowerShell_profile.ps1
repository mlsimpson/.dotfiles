function vim ($File){
  $File = $File -replace “\\”, “/”
  bash -c “vim $File”
}

Set-PSReadLineOption -EditMode Emacs
