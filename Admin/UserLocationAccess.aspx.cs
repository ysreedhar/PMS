using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class Admin_UserLocationAccess : System.Web.UI.Page
{
    private string ConnStr = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
    protected SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUserCollection users = Membership.GetAllUsers();

        foreach (MembershipUser user in users)
        {
            lbUsers.Items.Add(user.UserName);
        }
        if (!Page.IsPostBack)
        {

        }
    }
    protected void ddlWarehouse_OnDataBound(object sender, EventArgs e)
    {
        lblWareHouseDesc.Text = ddlWarehouse.Items.FindByText("1").Value;
    }
    protected void selAll(object sender, EventArgs e)
    {
        foreach (ListItem liAll in chkLocation.Items)
        {
            liAll.Selected = true;
        }
    }

    protected void selNone(object sender, EventArgs e)
    {
        foreach (ListItem liAll in chkLocation.Items)
        {
            liAll.Selected = false;
        }
    }
    protected void lbUsers_SelectedIndexChanged(object sender, EventArgs e)
    {
        chkLocation.ClearSelection();
        doRetriveDetails();
    }
    protected void doRetriveDetails()
    {
        try
        {
            conn = new SqlConnection(ConnStr);
            conn.Open();
            SqlCommand myCommand = new SqlCommand("SELECT LocationsAccess FROM tblUserLocationAccess WHERE UserName = '" + lbUsers.SelectedItem.Text + "' and WareHouse = '" + ddlWarehouse.SelectedItem.Text + "'", conn);
            myCommand.Parameters.Add("@UserName", SqlDbType.VarChar, 30).Value = lbUsers.SelectedItem.Text;
            myCommand.Parameters.Add("@Warehouse", SqlDbType.VarChar, 1).Value = ddlWarehouse.SelectedItem.Text;
            SqlDataReader reader = myCommand.ExecuteReader();
            while (reader.Read())
            {
                // retriving Details
                    ListItem currentLstItm = chkLocation.Items.FindByValue(reader["LocationsAccess"].ToString());
                    if (currentLstItm != null)
                    {
                        currentLstItm.Selected = true;
                    }
            }
            reader.Close();
        }

        catch (SqlException ex)
        {
            Response.Write(ex);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
    }

    protected void ddlWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblWareHouseDesc.Text = ddlWarehouse.SelectedValue.ToString();
        
    }
    protected void chkLocation_DataBound(object sender, EventArgs e)
    {
        if (lbUsers.SelectedIndex > -1 && ddlWarehouse.SelectedIndex > -1)
        doRetriveDetails();
    }
    protected void btnAssign_Click(object sender, EventArgs e)
    {
        if (lbUsers.SelectedIndex > -1 && ddlWarehouse.SelectedIndex > -1)
        {
            try
        {
            conn = new SqlConnection(ConnStr);
            conn.Open();
            foreach (ListItem i in chkLocation.Items)
        {
            if (i.Selected)
            {
                string SQL = "SELECT * FROM tblUserLocationAccess WHERE LocationsAccess = '" + i.Value + "' and UserName = '" + lbUsers.SelectedItem.Text + "' and Warehouse = '" + ddlWarehouse.SelectedItem.Text + "'" ;
                SqlCommand CMD = new SqlCommand(SQL, conn);
                SqlDataReader oRS;
                oRS = CMD.ExecuteReader();
                if (!(oRS.Read()))
                {
                    oRS.Close();
                    string SQL2 = "INSERT INTO tblUserLocationAccess (UserName, WareHouse, LocationsAccess) VALUES ('" + lbUsers.SelectedItem.Text + "', '" + ddlWarehouse.SelectedItem.Text + "', '" + i.Value + "')";
                    SqlCommand CMD2 = new SqlCommand(SQL2, conn);
                    CMD2.ExecuteNonQuery();
                }
                else
                {
                    oRS.Close();
                }
            }
            else
            {
                string SQL = "DELETE FROM tblUserLocationAccess WHERE LocationsAccess = '" + i.Value + "' and UserName = '" + lbUsers.SelectedItem.Text + "' and Warehouse = '" + ddlWarehouse.SelectedItem.Text + "'";
                SqlCommand CMD = new SqlCommand(SQL, conn);
                CMD.ExecuteNonQuery();
            }
        }
    }

    catch (SqlException ex)
    {
        Response.Write(ex);
    }
    catch (Exception ex)
    {
        Response.Write(ex);
    }
    finally
    {
        if (conn.State == ConnectionState.Open)
        {
            conn.Close();
        }
    }
    }
}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/UserLocationAccess.aspx");
    }
}
