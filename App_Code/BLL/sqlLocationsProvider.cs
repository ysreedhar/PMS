using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public static class sqlLocationsProvider
{
    private static String _connectionString;
    public static String ConnectionString
    {
        get
        {
            if (_connectionString == null)
            {
                _connectionString = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
            }
            return _connectionString;
        }
    }

    public static String[] GetLocationNames(String LocationNameLike)
    {
        using (SqlConnection connection = new SqlConnection())
        {
            connection.ConnectionString = ConnectionString;
            SqlCommand command = new SqlCommand("SELECT DISTINCT BLR021 FROM PIBUDLOC WHERE BLR021 like '" + LocationNameLike + "%' ;", connection);
            connection.Open();
            //return all records whose Title starts with the prefix input string
            List<String> titleArList = new List<string>();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                String strTemp = Convert.ToString(reader["BLR021"]);
                titleArList.Add(strTemp);
            }
            return titleArList.ToArray();
        }
    }
}