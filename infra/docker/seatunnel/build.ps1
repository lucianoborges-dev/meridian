#Requires -Version 5.1
<#
.SYNOPSIS
    Builds a SeaTunnel Docker image and loads it into minikube.
.EXAMPLE
    .\build.ps1 -Image master -t seatunnel-master:0.0.1
.EXAMPLE
    .\build.ps1 -Image worker -t seatunnel-worker:0.0.1
.EXAMPLE
    .\build.ps1 -Dockerfile .\master\dockerfile -t seatunnel-master:0.0.1
#>
[CmdletBinding()]
param(
    # Select a built-in image (resolves to .\<image>\dockerfile automatically)
    [Parameter(Mandatory, ParameterSetName = 'ByImage')]
    [ValidateSet('master', 'worker')]
    [string] $Image,

    # Explicit path to any dockerfile
    [Parameter(Mandatory, ParameterSetName = 'ByDockerfile')]
    [string] $Dockerfile,

    # Image tag  (alias -t mirrors docker build convention)
    [Parameter(Mandatory)]
    [Alias('t')]
    [string] $Tag
)

function Assert-Command ([string] $Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command not found: '$Name'. Make sure it is installed and on PATH."
    }
}

Assert-Command 'docker'
Assert-Command 'minikube'

# Repo root is three levels above this script (infra/docker/seatunnel → repo root)
$repoRoot = Split-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -Parent

if ($PSCmdlet.ParameterSetName -eq 'ByImage') {
    $Dockerfile = Join-Path $PSScriptRoot "$Image\dockerfile"
} else {
    $Dockerfile = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Dockerfile)
}

if (-not (Test-Path $Dockerfile)) {
    throw "Dockerfile not found: $Dockerfile"
}

Clear-Host

docker image inspect $Tag 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Removing existing image: $Tag" -ForegroundColor Yellow
    docker rmi $Tag
}

Write-Host "Building image: $Tag" -ForegroundColor Cyan
docker build -t $Tag -f $Dockerfile $repoRoot --progress=plain

if ($LASTEXITCODE -ne 0) {
    throw "Docker build failed with exit code $LASTEXITCODE."
}

Write-Host 'Loading image into minikube...' -ForegroundColor Green
$tarPath = [IO.Path]::ChangeExtension([IO.Path]::GetTempFileName(), '.tar')
docker save -o $tarPath $Tag
minikube image load $tarPath --overwrite=true
Remove-Item $tarPath -Force

Write-Host 'Image loaded into minikube successfully.' -ForegroundColor Green