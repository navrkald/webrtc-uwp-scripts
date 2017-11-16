
#param([string]$path)
#param([string]$fileNameFilter)
#param([string]$searchFor)
#param([string]$replaceWith)

$path=$args[0]
$fileNameFilter=$args[1]
$searchFor=$args[2]
$replaceWith=$args[3]

$configFiles = Get-ChildItem $path $fileNameFilter -rec
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace $searchFor, $replaceWith } |
    # -NoNewline is from powershell 5 and is needed to replace sdk version in environment.* files in out dir to be than correctly parsed by tool_wrapper.py
    Set-Content -NoNewline $file.PSPath
}
