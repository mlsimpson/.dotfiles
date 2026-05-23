oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/half-life.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

function vim ($File) {
	$File = $File -replace “\\”, “/” -replace “ “, “\ “
	bash -c “nvim $File”
}

function dirsizes () {
	Get-ChildItem . -directory -force | ForEach-Object { $_.FullName + ": " + [math]::Round((Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB, 2) + " MB" }
}

function gitreup () {
	$gitRepos = Get-ChildItem -Recurse -Directory | Where-Object { Get-ChildItem $_.FullName -Directory -Hidden -Filter ".git" }
	foreach ($gitRepo in $gitRepos) {
		Write-Host "Pulling $($gitRepo.Fullname)"
		Push-Location
		Set-Location $gitRepo.Fullname
		git pull
		Pop-Location
	}
}

function gcam { git commit -a -m }

function gd { git diff }

function gl { git pull }

function gp { git push }

function gst { git status }

function gitclog { git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all }

function lsda { lsd -lah --group-directories-first --hyperlink=auto }

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

New-Alias grep rg

. ([ScriptBlock]::Create((& scoop-search --hook | Out-String)))

$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"
