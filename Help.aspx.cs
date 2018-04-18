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

public partial class Help : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }
    private void BindData()
    {
        string pageName = Request.QueryString["pageName"] as String;
        if (!String.IsNullOrEmpty(pageName))
        {
            lblHelpMessage.Text = PCacheManager.GetHelpByPageName(pageName);
        }
    }
}
