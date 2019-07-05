$server = Read-Host 'Server? if null = (local)'
$dataBase = Read-Host 'Database?'
$login = Read-Host 'Login?'
$password = Read-Host 'Password?'

if ($server -eq "") {
    $server = "(local)"
}

# $StringArray = "DataBase='" + $dataBase + "'" , "Login='" + $login + "'", "Password='" + $password + "'"
$StringArray = "DataBase='test'"
Write-Output   $StringArray
Invoke-Sqlcmd -ServerInstance $server -Variable $StringArray -InputFile "MSSQL_1_UnisParLeSystem.sql"
Invoke-Sqlcmd -ServerInstance $server -Database $dataBase -Variable $StringArray -InputFile "MSSQL_2_UnisUser.sql"

<# sqlcmd -E -S $server -d UNIS -i MSSQL_3_Unis.sql -o log_MSSQL_3_Unis.log
sqlcmd -E -S $server -d UNIS -i MSSQL_4_Unis_InsD.sql -o log_MSSQL_4_Unis_InsD.log
sqlcmd -E -S $server -d UNIS -i MSSQL_5_Unis_tablereference.sql -o log_MSSQL_5_tablereference.log
sqlcmd -E -S $server -d UNIS -i MSSQL_6_UnisUserOwner.sql -o log_MSSQL_6_UNISUserOwner.log
sqlcmd -E -S $server -d UNIS -i MSSQL_7_Unis_Vues.sql -o log_MSSQL_7_Unis_Vues.log
sq lcmd -E -S $server -d UNIS -i MSSQL_8_Unis_ProcStockees.sql -o log_MSSQL_8_Unis_ProcStockees.log#>