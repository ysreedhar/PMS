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
using System.Data.Sql;
using System.Data.SqlClient;

public partial class Planning_PlanTrigger : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection("integrated security=SSPI;data source=RanteqSVR;initial catalog=pmsdb;userid=sa;password=!sa");
        SqlDataAdapter da = new SqlDataAdapter("select * from tblRequirementFile", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "tblRequirement");
        System.Data.SqlClient.SqlBulkCopy bc = new SqlBulkCopy(cn);
        bc.DestinationTableName = "tblRequirement"; // copy to self
        cn.Open();
        bc.WriteToServer(ds.Tables[0]);
        cn.Dispose();
    }
}
