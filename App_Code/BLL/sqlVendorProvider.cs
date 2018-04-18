using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public static class sqlVendorProvider
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

    public static String[] GetVendorNames(String VendorNameLike)
    {
        using (SqlConnection connection = new SqlConnection())
        {
            connection.ConnectionString = ConnectionString;
            SqlCommand command = new SqlCommand("SELECT [VNAME] FROM [vennam] where VNAME like '" + VendorNameLike + "%' ;", connection);
            connection.Open();
            //return all records whose Title starts with the prefix input string
            List<String> titleArList = new List<string>();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                String strTemp = Convert.ToString(reader["VNAME"]);
                titleArList.Add(strTemp);
            }
            return titleArList.ToArray();
        }
    }
}