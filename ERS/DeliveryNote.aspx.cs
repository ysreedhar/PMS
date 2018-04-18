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
using PMSApp.BusinessLogicLayer;
using System.Data.SqlClient;

public partial class DeliveryNote : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadDocFormat();
        SiteSettings settings = SiteSettings.GetSharedSettings();
        lblCompanyName.Text = settings.CompanyName.ToString();
        lblDeliveryNoteDate.Text = CommonFunctions.ConvertToAppDateFormat(DateTime.Now);
        lblDeliveryNoteTime.Text = Convert.ToString(DateTime.Now.ToShortTimeString());
        lblNumber.Text =  String.Format("{0:0000000}", Int32.Parse(Request.QueryString["DlNo"]));
        lblRNBarcode.Text = "!" + lblNumber.Text + "!";
        
    }
    protected void LoadDocFormat()
    {
        string connectionInfo = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionInfo))
        {
            connection.Open();
            // perform work with connection
            SqlCommand cmd = new SqlCommand("SELECT TOPLEFT,TOPRIGHT,BOTTOMLEFT,BOTTOMRIGHT FROM tblDocumentFormatMaster where DocumentName = 'RequisitionNote' ", connection);
            SqlDataReader reader;
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                lblBottomLeft.Text = reader.GetString(2);
            }
            reader.Close();
            connection.Close();
        }

    }
    protected decimal TotalItemQuantity = 0;
    protected decimal GetItemUnitQuantity(decimal ItemQuantity)
    {
        TotalItemQuantity += ItemQuantity;
        return ItemQuantity;

    }
    protected decimal GetTotalItemQuantity()
    {
        return TotalItemQuantity;
    }
}
