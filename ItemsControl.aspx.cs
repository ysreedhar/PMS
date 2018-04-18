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

public partial class ItemsControl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strjscript = "<script language=\"javascript\">";
        strjscript += "window.opener." + HttpContext.Current.Request.QueryString["formname"] + ".value = '" + gvItems.SelectedRow.Cells[1].Text.ToString() + "';window.opener." + HttpContext.Current.Request.QueryString["formname2"] + ".value = '" + gvItems.SelectedRow.Cells[2].Text.ToString() + "';window.opener." + HttpContext.Current.Request.QueryString["formname3"] + ".value = '" + gvItems.SelectedRow.Cells[3].Text.ToString() + "';window.close();";
        strjscript += "window.opener.window.document.getElementById('" + HttpContext.Current.Request.QueryString["ctrlDesc"] + "').innerHTML = '" + gvItems.SelectedRow.Cells[2].Text.ToString() + "'; ";
        strjscript += "window.opener.window.document.getElementById('" + HttpContext.Current.Request.QueryString["ctrlUOM"] + "').innerHTML = '" + gvItems.SelectedRow.Cells[3].Text.ToString() + "'; ";
        strjscript = strjscript + "</scr" + "ipt>";
        
        Literal1.Text = strjscript;
    }
    private void BindGrid()
    {
        ITEMASATableAdapter ItemsAdapter = new ITEMASATableAdapter();
        if (txtItemDescription.Text.Trim() == "" && txtItemNumber.Text.Trim() == "")
        {
           gvItems.DataSource = ItemsAdapter.GetData();
        }
        else if (txtItemDescription.Text.Trim() != "")
        {
             gvItems.DataSource = ItemsAdapter.GetDataByItemDescription(txtItemDescription.Text);
        }
        else if (txtItemNumber.Text.Trim() != "")
        {
            gvItems.DataSource = ItemsAdapter.GetDataByItemNumber(txtItemNumber.Text);
        }
        gvItems.DataBind();

    }
    protected void btnFetchItems_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
}
