using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using PMSApp.BusinessLogicLayer;

public partial class Admin_Messages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        dvMessages.ChangeMode(DetailsViewMode.Insert);
    }

    protected void gvMessages_DataBound(object sender, EventArgs e)
    {
        ((BoundField)gvMessages.Columns[4]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }
    protected void dvMessages_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvMessages.DataBind();
    }
    protected void dvMessages_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvMessages.DataBind();
    }
    protected void dvMessages_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        gvMessages.DataBind();
    }
}
