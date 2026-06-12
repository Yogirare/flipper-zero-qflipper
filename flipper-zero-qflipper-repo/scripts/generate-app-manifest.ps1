# Generate the app manifest from the artifact folder
$root = 'c:\Users\VIP\Desktop\all-the-apps-extra\extra_pack_build\artifacts-extra'
$repo = Split-Path -Parent (Split-Path -LiteralPath $MyInvocation.MyCommand.Path)
$apps = Get-ChildItem -Path $root -Recurse -Filter *.fap | Sort-Object FullName | ForEach-Object {
    $rel = $_.FullName.Substring($root.Length+1).TrimStart('\')
    $rel = $rel -replace '\\','/'
    $parts = $rel.Split('/')
    [PSCustomObject]@{
        Category = $parts[0]
        Name = $_.Name
        RelativePath = $rel
        FullPath = $_.FullName
    }
}
$apps | ConvertTo-Csv -NoTypeInformation | Set-Content -Path (Join-Path $repo 'apps-list.csv')
$apps | ConvertTo-Json -Depth 4 | Set-Content -Path (Join-Path $repo 'apps-list.json')
