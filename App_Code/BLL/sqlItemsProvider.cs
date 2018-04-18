using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public static class sqlItemsProvider
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

    public static String[] GetItemdescriptions(String ItemDescLike)
    {
        using (SqlConnection connection = new SqlConnection())
        {
            connection.ConnectionString = ConnectionString;
            SqlCommand command = new SqlCommand("SELECT distinct ITEMASA.ITDSC FROM ITEMASA WHERE VALUC <> 'D' AND ITDSC like '" + ItemDescLike + "%' ;", connection);
            connection.Open();
            //return all records whose Title starts with the prefix input string
            List<String> titleArList = new List<string>();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                String strTemp = Convert.ToString(reader["ITDSC"]);
                titleArList.Add(strTemp);
            }
            return titleArList.ToArray();
        }
    }
    public static String[] GetItemNumber(String ItemNumberLike)
    {
        using (SqlConnection connection = new SqlConnection())
        {
            connection.ConnectionString = ConnectionString;
            SqlCommand command = new SqlCommand("SELECT distinct ITEMASA.ITNBR FROM ITEMASA WHERE VALUC <> 'D' AND ITNBR like '" + ItemNumberLike + "%' ;", connection);
            connection.Open();
            //return all records whose Title starts with the prefix input string
            List<String> titleArList = new List<string>();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                String strTemp = Convert.ToString(reader["ITNBR"]);
                titleArList.Add(strTemp);
            }
            return titleArList.ToArray();
        }
    }
}