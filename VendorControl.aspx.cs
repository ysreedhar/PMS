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
using PMSdbTableAdapters;

public partial class VendorControl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvVendors_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strjscript = "<script language=\"javascript\">";
        strjscript += "window.opener." + HttpContext.Current.Request.QueryString["formname"] + ".value = '" + gvVendors.SelectedRow.Cells[1].Text.ToString() + "';window.close();";
        strjscript += "window.opener.window.document.getElementById('" + HttpContext.Current.Request.QueryString["ctrlDesc"] + "').innerHTML = '" + gvVendors.SelectedRow.Cells[2].Text.ToString() + "'; ";
        strjscript = strjscript + "</scr" + "ipt>";
        Literal1.Text = strjscript;
    }
    private void BindGrid()
    {
        vennamTableAdapter VendorsAdapter = new vennamTableAdapter();
        if (txtVendorName.Text != "")
        {
            gvVendors.DataSource = VendorsAdapter.GetDataByVendorName(txtVendorName.Text);
        }
        else
        {
            gvVendors.DataSource = VendorsAdapter.GetData();
        }
        gvVendors.DataBind();

    }
    protected void btnFetchVendors_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
}
