Get-Command "bat.exe" -ErrorAction Stop | Out-Null

if ($args.Count -lt 1) 
{
    Write-Output "usage: $MyInvocation.MyCommand.Name [--tag] FILENAME[:LINENO][:IGNORED]"
    exit
}

if ($args[0] -contains "--tag") 
{
    Write-Output "tagpreview not handled on windows yet"
    exit
}

$params = $args -join ' '
if ($params.Substring(0, 1) -eq "^") 
{
    $params = $params.Substring(1)
}
$params = $params.split(':')
$filename = $params[0]

$lineno = $params[1] 
if ($lineno -match "^\d+$") {
    bat.exe "$filename" --style=numbers --color=always --pager=never --highlight-line=$lineno 
} else {
    bat.exe "$filename" --style=numbers --color=always --pager=never
}
