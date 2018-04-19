osql -E -S (local) -i MSSQL_1_UnisParLeSystem.sql -o log_MSSQL_1_UNISParLeSystem.log
osql -E -S (local) -d UNIS -i MSSQL_2_UnisUser.sql -o log_MSSQL_2_UNISUser.log
osql -E -S (local) -d UNIS -i MSSQL_3_Unis.sql -o log_MSSQL_3_Unis.log
osql -E -S (local) -d UNIS -i MSSQL_4_Unis_InsD.sql -o log_MSSQL_4_Unis_InsD.log
osql -E -S (local) -d UNIS -i MSSQL_5_Unis_tablereference.sql -o log_MSSQL_5_tablereference.log
osql -E -S (local) -d UNIS -i MSSQL_6_UnisUserOwner.sql -o log_MSSQL_6_UNISUserOwner.log
osql -E -S (local) -d UNIS -i MSSQL_7_Unis_Vues.sql -o log_MSSQL_7_Unis_Vues.log
osql -E -S (local) -d UNIS -i MSSQL_8_Unis_ProcStockees.sql -o log_MSSQL_8_Unis_ProcStockees.log

