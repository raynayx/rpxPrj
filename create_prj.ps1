$DIR_NAME=$args[0]
$DIR_LOC=$PWD
$PSScriptRoot

If($args.Count -eq 0)
{
    Write-Host "Supply project folder name" -f Green
}
Else
{
    Write-Host "Creating Project Folder" -f Green

    New-Item -ItemType Directory -Path .\$DIR_NAME

}

If((Test-Path -Path $DIR_NAME))
{
    Write-Host "Copying project resources into " -f Green
    
    cd $PSScriptRoot

    Copy-Item -Path .\flash.jlink -Destination $DIR_LOC\$DIR_NAME

    Copy-Item -Path .\setup_env.ps1 -Destination $DIR_LOC\$DIR_NAME

    Copy-Item -Path .\tasks.py -Destination $DIR_LOC\$DIR_NAME

    Copy-Item -Path .\CMakeLists.txt -Destination $DIR_LOC\$DIR_NAME

    Copy-Item -Path .\.vscode -Destination $DIR_LOC\$DIR_NAME -Recurse

    cd $DIR_LOC
}
Else
{
Write-Host "Project folder not found. Exitting... " -f Green
return
}

