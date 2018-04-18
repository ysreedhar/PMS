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

public partial class AppLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        SiteSettings settings = SiteSettings.GetSharedSettings();
        lblCompanyName.Text = settings.CompanyName.ToString();
        
    }
    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
}
