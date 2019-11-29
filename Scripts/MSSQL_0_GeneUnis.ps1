#Prerequisites
#Install-Module -Name PublishDacPac

#Get SqlPackage path
#$sqlPackageFileName = "${env:ProgramFiles(x86)}\Microsoft SQL Server\120\DAC\bin\sqlpackage.exe"
$sqlPackageFileName = Get-SqlPackagePath -Version 120

if (Get-Command sqlcmd -errorAction SilentlyContinue) {

}
else {
    Write-Host "sqlcmd command don't exist"
    Exit-PSHostProcess
}

if (Get-Command $sqlPackageFileName -errorAction SilentlyContinue) {

}
else {
    Write-Host "sqlpackage command don't exist"
    Exit-PSHostProcess
}

#Create Output folder
$path = Get-Location
if (Test-Path "$path\Output") {
}
else {
    New-Item -Name Output -Path $path -ItemType Directory
}

#Input command
<# Do {
    $mode = Read-Host 'Choose your authentication mode (1 - SQL, 2 - Windows)'
}
Until($mode -eq 1 -Or $mode -eq 2) #>
$mode = 1
$server = Read-Host 'Server? if null = (local)'
$dataBase = Read-Host 'Database?'

if ($null -eq $server) {
    $server = "(local)"
}

$login = Read-Host 'Login?'

if ($mode -eq 1) {

    $password = Read-Host 'Password?' -AsSecureString

    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $value = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    # Create datebase and user
    sqlcmd -E -S $server -v DataBase=$dataBase -i "$path\MSSQL_1_UnisParLeSystem.sql" -o "$path\Output\MSSQL_1_UnisParLeSystem.txt"
    sqlcmd -E -S $server -d $dataBase -v DataBase=$dataBase Login=$login Password=$value -i "$path\MSSQL_2_UnisUser.sql" -o "$path\Output\MSSQL_2_UnisUser.txt"

    # Extract schema model client
    & "$sqlPackageFileName" /Action:Extract /SourceConnectionString:"Data Source=$server;Initial Catalog=$dataBase;User ID=$login;Password=$value" /tf:"$path\Output\Client.dacpac" /p:IgnoreExtendedProperties=True /p:IgnorePermissions=False /p:ExtractApplicationScopedObjectsOnly=True /p:IgnoreUserLoginMappings=True /p:VerifyExtraction=True

    # Generate script
    & "$sqlPackageFileName" /a:Script /sf:"$path\Master.dacpac" /tf:"$path\Output\Client.dacpac" /tdn:"$dataBase" /op:"$path\Output\DifferenceScript.sql" /p:GenerateSmartDefaults=True

    # Execute script
    sqlcmd -S $server -d $dataBase -U $login -P $value -i "$path\Output\DifferenceScript.sql" -o "$path\Output\Output.txt"
}

if ($mode -eq 2) {

    # Create datebase and user
    sqlcmd -E -S $server -v DataBase=$dataBase -i "$path\MSSQL_1_UnisParLeSystem.sql" -o "$path\Output\MSSQL_1_UnisParLeSystem.txt"
    sqlcmd -E -S $server -d $dataBase -v DataBase=$dataBase Login=$login -i "$path\MSSQL_2_UnisUserAuthWindows.sql" -o "$path\Output\MSSQL_2_UnisUserAuthWindows.txt"

    # Extract schema model client
    & "$sqlPackageFileName" /Action:Extract /SourceConnectionString:"Data Source=$server;Initial Catalog=$dataBase;Integrated Security=true;" /tf:"$path\Output\Client.dacpac" /p:IgnoreExtendedProperties=True /p:IgnorePermissions=False /p:ExtractApplicationScopedObjectsOnly=True /p:IgnoreUserLoginMappings=True /p:VerifyExtraction=True

    # Generate script
    & "$sqlPackageFileName" /a:Script /sf:"$path\Master.dacpac" /tf:"$path\Output\Client.dacpac" /tdn:"$dataBase" /op:"$path\Output\DifferenceScript.sql" /p:GenerateSmartDefaults=True

    # Execute script
    sqlcmd -E -S $server -d $dataBase -i "$path\Output\DifferenceScript.sql" -o "$path\Output\Output.txt"
}