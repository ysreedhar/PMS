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

public partial class ERS_SubConMD : System.Web.UI.Page
{
    private int RCount;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SiteSettings settings = SiteSettings.GetSharedSettings();
            // Allow users to Implement Transfer Using Alternate Item Policy:
            chkTUAI.Visible = settings.ImplementsTUAIP;
        }
        
    }
    protected void AddItems(string ItemName, string strDescription, string strUOM, string Quantity, string strItemType)
    {
        HttpCookie c = null;
        if (HttpContext.Current.Request.Cookies["SCSupply"] == null)
        {
            c = new HttpCookie("SCSupply");
            RCount = 1;
        }
        else
        {
            c = HttpContext.Current.Request.Cookies["SCSupply"];
            RCount = c.Values.Count + 1;
        }
        string itemdetails;
        itemdetails = RCount + "|" + ItemName + "|" + strDescription + "|" + strUOM + "|"  + Quantity + "|" + strItemType;
        c.Values[RCount.ToString()] = itemdetails;
        //Response.Write(c.Values.ToString());
        Response.Cookies.Add(c);
        string scriptString = "<script language=JavaScript>window.opener.location.reload();window.close(); </script>";
        // Write the script to reload
        if (!Page.ClientScript.IsClientScriptBlockRegistered(scriptString))
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "script", scriptString);
        }
    }
    protected void BtnAddItem_Click(object sender, EventArgs e)
    {
        AddItems(ddlItems.SelectedItem.Text, lblItemDescription.Text, lblUOM.Text, txtQuantity.Text, "0");
    }
    protected void ddlItems_DataBound(object sender, EventArgs e)
    {
        if (ddlItems.Items.Count > 0)
        {
            lblItemDescription.Text = ddlItems.Items[0].Value;
        }
        else
        {
            lblItemDescription.Text = "";
        } 
    }
    protected void ddlItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblItemDescription.Text = ddlItems.SelectedItem.Value.ToString();
    }
    protected void btnViewMapicsItems_Click(object sender, EventArgs e)
    {
        mvSMD.SetActiveView(vwItems);
    }
    protected void btnViewNonMapicsItems_Click(object sender, EventArgs e)
    {
        mvSMD.SetActiveView(vwNMItems);
    }
    protected void btnNMItemAdd_Click(object sender, EventArgs e)
    {
        AddItems(ddlNMItems.SelectedItem.Text, "","", txtNMItemQuantity.Text, "1");
    }
}
