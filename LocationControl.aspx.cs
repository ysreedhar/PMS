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

public partial class LocationControl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvLocations_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strjscript = "<script language=\"javascript\">";
        strjscript += "window.opener." + HttpContext.Current.Request.QueryString["formname"] + ".value = '" + gvLocations.SelectedRow.Cells[1].Text.ToString() + "';window.opener." + HttpContext.Current.Request.QueryString["formname2"] + ".value = '" + gvLocations.SelectedRow.Cells[2].Text.ToString() + "';window.close();";
        strjscript = strjscript + "</scr" + "ipt>";
        Literal1.Text = strjscript;
    }
    private void BindGrid()
    {
        itemblTableAdapter LocationsAdapter = new itemblTableAdapter();
        if (txtLocationDescription.Text != "")
        {
            gvLocations.DataSource = LocationsAdapter.GetDataByLocationName(txtLocationDescription.Text);
        }
        else
        {
            gvLocations.DataSource = LocationsAdapter.GetData();
        }
        gvLocations.DataBind();

    }
    protected void btnFetchLocations_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
}
