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

public partial class testpicker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string strjscript = "<script language=\"javascript\">";
        strjscript += "window.opener." + HttpContext.Current.Request.QueryString["formname"] + ".value = '" + TextBox1.Text.ToString() + "';window.close();";
        strjscript = strjscript + "</scr" + "ipt>";
        Literal1.Text = strjscript;
        
    }
}
