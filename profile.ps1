oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/half-life.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

function vim ($File) {
	$File = $File -replace “\\”, “/” -replace “ “, “\ “
	bash -c “nvim $File”
}

function gvim ($File) {
	$File = $File -replace “\\”, “/” -replace “ “, “\ “
	bash -c “nvim-qt --geometry 768x968 $File”
}

function dirsizes () {
	Get-ChildItem . -directory -force | ForEach-Object { $_.FullName + ": " + [math]::Round((Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB, 2) + " MB" }
}

function gitreup () {
	# Get all child directories that contain a .git folder
	$gitRepos = Get-ChildItem -Directory -Recurse -Filter ".git" | ForEach-Object { $_.Parent.FullName }

	# Iterate through each child repository and pull the latest changes
	foreach ($gitRepo in $gitRepos) {
		Write-Host "Updating repository: $gitRepo" -ForegroundColor Cyan
		Push-Location
		Set-Location -Path $gitRepo
    
		# Optional: Stash local changes if needed to prevent merge conflicts
		# git stash 

		# Pull the latest changes from the remote
		git pull
		Pop-Location
	}
}

function repair-system {
	sfc /scannow
	dism /Online /Cleanup-Image /CheckHealth
	dism /Online /Cleanup-Image /ScanHealth
	dism /Online /Cleanup-Image /RestoreHealth
	dism /Online /Cleanup-Image /AnalyzeComponentStore
	dism /Online /Cleanup-Image /StartComponentCleanup
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
