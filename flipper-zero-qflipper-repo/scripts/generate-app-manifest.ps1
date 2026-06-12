# Generate the app manifest from the artifact folder
# Improved version with flexible path handling and safety checks

param(
    [string]$ArtifactsPath,
    [switch]$Interactive
)

# Get the script directory
$scriptDir = Split-Path -Parent (Split-Path -LiteralPath $MyInvocation.MyCommand.Path)
$repo = Split-Path -Parent $scriptDir

# Determine the artifacts path
if ([string]::IsNullOrWhiteSpace($ArtifactsPath)) {
    if ($Interactive) {
        # Interactive mode - ask user for path
        $ArtifactsPath = Read-Host "Enter the path to the artifacts folder"
    } else {
        # Try common default locations
        $commonPaths = @(
            (Join-Path $repo 'artifacts'),
            (Join-Path $repo '..\artifacts'),
            'C:\Users\VIP\Desktop\all-the-apps-extra\extra_pack_build\artifacts-extra'
        )
        
        $ArtifactsPath = $null
        foreach ($path in $commonPaths) {
            if (Test-Path $path) {
                $ArtifactsPath = $path
                Write-Host "Found artifacts folder: $ArtifactsPath" -ForegroundColor Green
                break
            }
        }
        
        if ([string]::IsNullOrWhiteSpace($ArtifactsPath)) {
            Write-Error "Artifacts folder not found. Please provide the path as a parameter: .\generate-app-manifest.ps1 -ArtifactsPath 'C:\path\to\artifacts'"
            exit 1
        }
    }
}

# Validate the path exists
if (-not (Test-Path $ArtifactsPath -PathType Container)) {
    Write-Error "Artifacts folder does not exist: $ArtifactsPath"
    exit 1
}

Write-Host "Scanning for .fap files in: $ArtifactsPath" -ForegroundColor Cyan

# Get all .fap files
$apps = Get-ChildItem -Path $ArtifactsPath -Recurse -Filter *.fap -ErrorAction SilentlyContinue | Sort-Object FullName | ForEach-Object {
    $rel = $_.FullName.Substring($ArtifactsPath.Length+1).TrimStart('\')
    $rel = $rel -replace '\\','/'
    $parts = $rel.Split('/')
    [PSCustomObject]@{
        Category = $parts[0]
        Name = $_.Name
        RelativePath = $rel
        FullPath = $_.FullName
    }
}

if ($apps.Count -eq 0) {
    Write-Warning "No .fap files found in $ArtifactsPath"
} else {
    Write-Host "Found $($apps.Count) app(s)" -ForegroundColor Green
}

# Export to CSV and JSON
$csvPath = Join-Path $repo 'apps-list.csv'
$jsonPath = Join-Path $repo 'apps-list.json'

try {
    $apps | ConvertTo-Csv -NoTypeInformation | Set-Content -Path $csvPath -ErrorAction Stop
    Write-Host "✓ CSV exported to: $csvPath" -ForegroundColor Green
} catch {
    Write-Error "Failed to export CSV: $_"
    exit 1
}

try {
    $apps | ConvertTo-Json -Depth 4 | Set-Content -Path $jsonPath -ErrorAction Stop
    Write-Host "✓ JSON exported to: $jsonPath" -ForegroundColor Green
} catch {
    Write-Error "Failed to export JSON: $_"
    exit 1
}

Write-Host "Manifest generation complete!" -ForegroundColor Green
