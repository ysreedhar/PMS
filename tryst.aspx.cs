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
public partial class tryst : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(Convert.ToDecimal(DateTime.Now.ToString("ddMMyyyy")));
        Response.Write(CommonFunctions.ConvertToUniversalDate(DateTime.Now.ToString("yyyy/MM/dd")));
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Write(CommonFunctions.ConvertAppDateToCMapicsFormat(CommonFunctions.ConvertToUniversalDate(TextBox1.Text)));

    }
}
