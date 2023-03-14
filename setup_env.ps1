

If((Test-Path -Path .\src) -and (Test-Path -Path .\lib))
{
    Write-Host "Directory setup already. Run  " 
    Write-Host "conda activate env_name " -f Green
    Write-Host "to enable running "
    Write-Host "invoke" -f Green
	return
}
Else
{
    Write-Host "Attempting to create src lib build test docs folders" -f Green
    New-Item -ItemType Directory -Path src/

    New-Item -ItemType Directory -Path build/

    New-Item -ItemType Directory -Path test/
    
    New-Item -ItemType Directory -Path lib/

    New-Item -ItemType Directory -Path docs/

    New-Item -ItemType File -Path .\src/main.c

    git init .

}