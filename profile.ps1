oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/half-life.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

function vim ($File){
	$File = $File -replace “\\”, “/” -replace “ “, “\ “
	bash -c “vim $File”
}

function nvim ($File){
	$File = $File -replace “\\”, “/” -replace “ “, “\ “
	bash -c “nvim $File”
}

function dirsizes () {
	Get-ChildItem . -directory -force | ForEach-Object { $_.FullName + ": " + [math]::Round((Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB,2) + " MB" }
}

function lsda { lsd -lah --group-directories-first --hyperlink=auto }

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

New-Alias grep findstr
