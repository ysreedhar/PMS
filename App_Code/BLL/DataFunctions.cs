using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using PMSdbTableAdapters;
using System.Data.Sql;
using System.Data.SqlClient;


/// <summary>
/// Summary description for DataFunctions
/// </summary>
public class DataFunctions
{
    public static string FunGetWarehouseDesc(string Warehouse)
    {
        string ConnStr = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString; 
        SqlConnection conn = new SqlConnection(ConnStr);
        SqlCommand cmd = new SqlCommand();
        Object returnValue;
        cmd.CommandText = "SELECT Description FROM tblWarehouseMaster where WarehouseName = '" + Warehouse + "'";
        cmd.CommandType = CommandType.Text;
        cmd.Connection = conn;
        conn.Open();
        returnValue = cmd.ExecuteScalar();
        conn.Close();
        string WarehouseDesc = (string)returnValue;
        return WarehouseDesc;
    }
    public static string FunGetLocationDesc(string Warehouse, string Location)
    {
        string ConnStr = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
        SqlConnection conn = new SqlConnection(ConnStr);
        SqlCommand cmd = new SqlCommand();
        Object returnValue;
        cmd.CommandText = "SELECT PIBUDLOC.BLR021 FROM PIBUDLOC WHERE PIBUDLOC.BLR001 = '" + Warehouse + "' and BLR004 = '" + Location + "'";
        cmd.CommandType = CommandType.Text;
        cmd.Connection = conn;
        conn.Open();
        returnValue = cmd.ExecuteScalar();
        conn.Close();
        string LocationDesc = (string)returnValue;
        return LocationDesc;
    }
    public static string FunGetLocationEmail(string Warehouse, string Location)
    {
        string ConnStr = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
        SqlConnection conn = new SqlConnection(ConnStr);
        SqlCommand cmd = new SqlCommand();
        Object returnValue;
        cmd.CommandText = "SELECT Email FROM vwLocationEmailAddress WHERE Warehouse = '" + Warehouse + "' and LocationsAccess = '" + Location + "'";
        cmd.CommandType = CommandType.Text;
        cmd.Connection = conn;
        conn.Open();
        returnValue = cmd.ExecuteScalar();
        conn.Close();
        string LocationEmail = (string)returnValue;
        if (LocationEmail != "")
        {
            return LocationEmail;
        }
        else
        {
            return ReturnSiteVariables.ReturnAppEmailAddress();
        }


    }
    
}

