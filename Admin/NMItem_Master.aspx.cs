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

public partial class Admin_NMItem_Master : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
       dvNMItems.ChangeMode(DetailsViewMode.Insert);
    }
    protected void dvNMItems_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvNMItems.DataBind();
    }
    protected void dvNMItems_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvNMItems.DataBind();
    }
    protected void dvNMItems_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        gvNMItems.DataBind();
    }
}
