using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using PMSdbTableAdapters;
using PMSApp.BusinessLogicLayer;
using System.Text;

public partial class RequestItem : System.Web.UI.Page
{
    private int NumofAttempts, RCount;
    private string itemdetails;
    protected void Page_Load(object sender, System.EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            hfUserID.Value = Context.User.Identity.Name;
            
        }

    }
    protected DataTable gvReqdataTable;
    private void FillCartFromCookies()
    {
        HttpCookie c = HttpContext.Current.Request.Cookies["requesttray"];
        ArrayList items = new ArrayList();
        //Response.Write(items.Count);
        if (c.Values.Count > 0)
        {
            for (int i = 0; i < c.Values.Count; i++)
            {
                string[] vals = c.Values[i].Split('|');
                RequestTray item = new RequestTray();
                item.ReqItemCount = vals[0];
                item.ItemName = vals[1];
                item.ItemDesc = vals[2];
                item.ItemUOM = vals[3];
                item.ReqDate = vals[4];
                item.ReqQuantity = vals[5];
                item.InvAtRequestor = vals[6];
                item.Quantity = float.Parse(vals[7]);
                if (vals[8] != "")
                {
                    item.RequiredDate = vals[8];
                }
                else
                {
                    item.RequiredDate = DateTime.Now.AddDays(1).ToShortDateString();
                }
                item.RequiredTime = vals[9];
                if (vals[10] != "")
                {
                    item.RequiredSeq = vals[10];
                }
                else
                {
                    item.RequiredSeq = "0";
                }

                items.Add(item);
            }
        }
        gvTray.DataSource = items;
        gvTray.DataBind();
        Button1_Click(null, null);
    }

    private void BindGrid()
    {
        dtRequirementTableAdapter ItemsAdapter = new dtRequirementTableAdapter();
        gvRequirement.DataSource = ItemsAdapter.GetDataByReqDateandWHLoc(CommonFunctions.ConvertToUniversalDate(txtRequiredDateFrom.Text), CommonFunctions.ConvertToUniversalDate(txtRequiredDateTo.Text), ddlFromLocation.SelectedItem.Text, ddlFromWarehouse.SelectedItem.Text);
        gvRequirement.DataBind();

    }

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {

    }
    #endregion



    protected void Button1_Click(object sender, System.EventArgs e)
    {

    }
    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/RequestItem.aspx");
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (txtRequiredDateFrom.Text != "" && txtRequiredDateTo.Text == "" && revRequiredDateTo.IsValid)
        {
            txtRequiredDateTo.Text = txtRequiredDateFrom.Text;
        }
        if (ValidationFunctions.IsValidDateRange(txtRequiredDateFrom.Text,txtRequiredDateTo.Text))
        {
        lblResultsRFromWh.Text = ddlFromWarehouse.SelectedItem.Text + " - " + lblWareHousedesc.Text;
        lblResultsRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWareHouseDesc.Text;
        lblResultsRFromLoc.Text = ddlFromLocation.SelectedItem.Text + " - " + lblLocationdesc.Text;
        lblResultsRToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
        lblReqFrom.Text = txtRequiredDateFrom.Text;
        lblReqTo.Text = txtRequiredDateTo.Text;
        MultiView1.SetActiveView(vwResults);
        lblErrorMessage.Text = "";
        BindGrid();
        }
        else
        {
            lblErrorMessage.Text = "Not a Valid Date range";
        }
    }
    protected void FunctionClearNewItemEF()
    {
        txtInsertNewItem.Text = "";
        lblItemDesc.Text = "";
        lblItemUOM.Text = "";
        txtInsertNewItemQuantity.Text = "";
        txtInsertNewItemTm.Text = "";
        txtInsertNewItemSeq.Text = "";
    }
    protected void btnReqConfirm_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow ReqItem in gvRequirement.Rows)
        {

            //  Response.Write(((System.Web.UI.WebControls.TextBox)ReqItem.Cells[6].Controls[1]).Text);
            double dblReqQuantity = 0;
            try
            {
                dblReqQuantity = Double.Parse(((System.Web.UI.WebControls.TextBox)ReqItem.Cells[6].Controls[1]).Text);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }

            if (dblReqQuantity > 0)
            {
                InsertNewRequestItem(ReqItem.Cells[0].Text, ReqItem.Cells[1].Text, ReqItem.Cells[2].Text, ReqItem.Cells[3].Text, ReqItem.Cells[4].Text, ReqItem.Cells[5].Text, ((System.Web.UI.WebControls.TextBox)ReqItem.Cells[6].Controls[1]).Text, ((System.Web.UI.WebControls.TextBox)ReqItem.Cells[7].Controls[1]).Text, ((System.Web.UI.WebControls.TextBox)ReqItem.Cells[8].Controls[1]).Text.Trim(), ((System.Web.UI.WebControls.TextBox)ReqItem.Cells[9].Controls[1]).Text);
                FillCartFromCookies();
                
            }
        }
        

        MultiView1.SetActiveView(vwConfirm);
        txtInsertNewItemDt.Text = txtRequiredDateFrom.Text;
    }
    protected void btnReqCancel_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(vwSearch);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Cookies["requesttray"].Expires = DateTime.Now;
        MultiView1.SetActiveView(vwResults);
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        tblRequisitionTableAdapter RequisitionTableAdapter = new tblRequisitionTableAdapter();
        int new_RequestID = Convert.ToInt32(RequisitionTableAdapter.InsertRequisition(ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), 1, ddlFromWarehouse.SelectedItem.Text, ddlFromLocation.SelectedItem.Text, DateTime.Now, 10, Context.User.Identity.Name));
        //Response.Write("new value :" + new_RequestID);
        tblRequestDetailsTableAdapter RequestItemAdapter = new tblRequestDetailsTableAdapter();
        
        tblRequirementFileTableAdapter InsertRequirementAdapter = new tblRequirementFileTableAdapter();
        foreach (GridViewRow RItem in gvTray.Rows)
        {
            //Response.Write(RItem.Cells[5].Text); //+ " : " + Convert.ToDecimal(RItem.Cells[1].Text)+ " : " + CommonFunctions.ConvertToUniversalDate(RItem.Cells[2].Text)+ " : " + RItem.Cells[3].Text+ " : " + Int32.Parse(RItem.Cells[4].Text)));
            if (RItem.Cells[5].Text == "0")
            {
                RequestItemAdapter.InsertNewRequestItem(new_RequestID, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[7].Text), CommonFunctions.ConvertToUniversalDate(RItem.Cells[8].Text), RItem.Cells[9].Text.Trim(), Int32.Parse(RItem.Cells[10].Text), 10, CommonFunctions.ConvertToUniversalDate(RItem.Cells[4].Text));
              if (!InsertRequirementAdapter.CheckItemScalarQuery(ddlFromWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), CommonFunctions.ConvertToUniversalDate(RItem.Cells[8].Text), RItem.Cells[1].Text).HasValue)
                {
                    InsertRequirementAdapter.InsertRequirement(1, RItem.Cells[1].Text, DateTime.Now, CommonFunctions.ConvertToUniversalDate(RItem.Cells[8].Text), 0, Int32.Parse(RItem.Cells[10].Text), ddlFromLocation.SelectedItem.Text, ddlFromWarehouse.SelectedItem.Text);
                }
            }
            else
            {
                RequestItemAdapter.InsertNewRequestItem(new_RequestID, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[7].Text), CommonFunctions.ConvertToUniversalDate(RItem.Cells[8].Text), RItem.Cells[9].Text.Trim(), Int32.Parse(RItem.Cells[10].Text), 10, CommonFunctions.ConvertToUniversalDate(RItem.Cells[4].Text));
            }
        }
        // Show Message
        lblSuccessfulTransactionNumber.Text = " - " + String.Format("{0:0000000}", new_RequestID);

        // Generate Email
        bool EmailSentBool = CommonFunctions.SendNewRequisitionEmail(new_RequestID, ddlFromWarehouse.SelectedItem.Text, ddlFromLocation.SelectedItem.Text, ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), Server.HtmlEncode("PMS-II - New Requisition Alert"), Server.HtmlEncode(String.Format("{0:0000000}", new_RequestID)));

        // Set The View to next search and show the link for Requisition Note
        hlRequisitionNote.NavigateUrl = String.Format("javascript:window.open('RequisitionNote.aspx?RqNo=" + new_RequestID + "', null, 'height=500,width=750,status=yes,toolbar=no,menubar=no,location=no'); void('');"); ;
        FunctionClearNewItemEF();

        //hlRequisitionNote.Attributes.Add("onclick", "window.open('" + HttpUtility.UrlEncode(hlRequisitionNote.NavigateUrl) + "',null,'height=250, width=800,status= no, resizable= no, scrollbars=no, toolbar=no,location=no,menubar=no ');");
        MultiView1.SetActiveView(vwSuccess);
        Response.Cookies["requesttray"].Expires = DateTime.Now;
    }
    protected void ddlFromWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblWareHousedesc.Text = ddlFromWarehouse.SelectedValue.ToString();
    }
    protected void ddlFromLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblLocationdesc.Text = ddlFromLocation.SelectedValue.ToString();
    }
    protected void ddlToWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblToWareHouseDesc.Text = ddlToWarehouse.SelectedValue.ToString();
    }
    protected void ddlFromWarehouse_DataBound(object sender, EventArgs e)
    {
        if (ddlFromWarehouse.Items.Count > 0)
        {
            lblWareHousedesc.Text = ddlFromWarehouse.Items[0].Value;
        }
        else
        {
            lblWareHousedesc.Text = "";
        }
    }
    protected void ddlFromLocation_DataBound(object sender, EventArgs e)
    {
        if (ddlFromLocation.Items.Count > 0)
        {
            lblLocationdesc.Text = ddlFromLocation.Items[0].Value;
        }
        else
        {
            lblLocationdesc.Text = "";
        }
    }
    protected void ddlToWarehouse_DataBound(object sender, EventArgs e)
    {
        if (ddlToWarehouse.Items.Count > 0)
        {
            lblToWareHouseDesc.Text = ddlToWarehouse.Items[0].Value;
        }
        else
        {
            lblToWareHouseDesc.Text = "";
        }
    }
    protected void txtRequiredDateFrom_TextChanged(object sender, EventArgs e)
    {
        if (revRequiredDateFrom.IsValid)
            lblRequiredFromWeekDay.Text = CommonFunctions.DisplayWeekDay(CommonFunctions.ConvertToUniversalDate(txtRequiredDateFrom.Text));
    }
    protected void txtRequiredDateTo_TextChanged(object sender, EventArgs e)
    {
        if(revRequiredDateTo.IsValid)
            lblRequiredToWeekDay.Text = CommonFunctions.DisplayWeekDay(CommonFunctions.ConvertToUniversalDate(txtRequiredDateTo.Text));
    }
    protected void gvRequirement_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Item Template Calender
            string strTextBoxName = e.Row.FindControl("ItmTmplRDtText").ClientID;
            ((HyperLink)(e.Row.FindControl("lbtnCalendar"))).NavigateUrl = "javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm." + strTextBoxName + "','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();";

            // If the item is already requested the disable entry
            //Response.Write( e.Row.Cells[10].Text.Length + ":" + e.Row.Cells[10].Text);

            if (e.Row.Cells[10].Text.Length > 6)
            {
                e.Row.FindControl("ItmTmplQtyText").Visible = false;
                e.Row.FindControl("ItmTmplRDtText").Visible = false;
                e.Row.FindControl("lbtnCalendar").Visible = false;
                e.Row.FindControl("ItmTmplRTmText").Visible = false;
                e.Row.FindControl("ItmTmplRSeqText").Visible = false;
            }
        }
        // set Date Format to the application's Date Display format
        ((BoundField)gvRequirement.Columns[3]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }

    protected void InsertNewRequestItem(string strNRItemName, string strNRItemDesc, string strNRItemUOM, string strNRItemRequiredDate, string strNRItemRequiredQuantity, string strNRItemInvAtRequestor, string strNRItemRequestedQuantity, string strNRItemRequestedDate, string strNRItemRequestedTime, string strNRItemRequestedSequence)
    {
        HttpCookie c = null;
        if (HttpContext.Current.Request.Cookies["requesttray"] == null)
        {
            c = new HttpCookie("requesttray");
            RCount = 1;
        }
        else
        {
            c = HttpContext.Current.Request.Cookies["requesttray"];
            RCount = c.Values.Count + 1;
        }

        itemdetails = RCount + "|" + strNRItemName + "|" + strNRItemDesc + "|" + strNRItemUOM + "|" + strNRItemRequiredDate + "|" + strNRItemRequiredQuantity + "|" + strNRItemInvAtRequestor + "|" + strNRItemRequestedQuantity + "|" + strNRItemRequestedDate + "|" + strNRItemRequestedTime + "|" + strNRItemRequestedSequence;
        c.Values[RCount.ToString()] = itemdetails;
        //Response.Write(c.Values.ToString());
        Response.Cookies.Add(c);
    }
    protected void gvRequirement_DataBound(object sender, EventArgs e)
    {
        gvReqdataTable = gvRequirement.DataSource as DataTable;


    }
    protected void gvTray_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (NumofAttempts < 1)
        {
            HttpCookie c = HttpContext.Current.Request.Cookies["requesttray"];
            c.Values.Remove(gvTray.Rows[e.RowIndex].Cells[0].Text);
            Response.Cookies.Add(c);
            FillCartFromCookies();
            NumofAttempts++;
        }
        if (gvTray.Rows.Count == 0)
        {
            MultiView1.SetActiveView(vwResults);
            Response.Cookies["requesttray"].Expires = DateTime.Now;
            btnConfirm.Visible = false;
        }
    }
    protected void gvRequirement_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRequirement.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void gvRequirement_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (gvReqdataTable != null)
        {
            DataView dataView = new DataView(gvReqdataTable);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
            gvRequirement.DataSource = dataView;
            gvRequirement.DataBind();
        }

    }
    protected string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;
        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;
            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }
        return newSortDirection;
    }
    protected void AddReqItem_Click(object sender, EventArgs e)
    {
        
        //InsertNewRequestItem(txtInsertNewItem.Text, lblItemDesc.Text, lblItemUOM.Text, txtInsertNewItemDt.Text, "0", "", txtInsertNewItemQuantity.Text, txtInsertNewItemDt.Text, txtInsertNewItemTm.Text, txtInsertNewItemSeq.Text);
        InsertNewRequestItem(txtInsertNewItem.Text, hfItemDesc.Value, hfItemUOM.Value, txtInsertNewItemDt.Text, "0", "", txtInsertNewItemQuantity.Text, txtInsertNewItemDt.Text, txtInsertNewItemTm.Text, txtInsertNewItemSeq.Text);
        FillCartFromCookies();
        FunctionClearNewItemEF();
    }
    protected void ddlToLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblToLocationDesc.Text = ddlToLocation.SelectedValue.ToString();
    }
    protected void ddlToLocation_DataBound(object sender, EventArgs e)
    {
        if (ddlToLocation.Items.Count > 0)
        {
            ddlToLocation.SelectedIndex = ddlToLocation.Items.IndexOf(ddlToLocation.Items.FindByText(ReturnSiteVariables.ReturnAppInvControl().ToString()));
            lblToLocationDesc.Text = ddlToLocation.SelectedItem.Value;
        }
        else
        {
            lblToLocationDesc.Text = "";
        }

    }
    protected void gvTray_DataBound(object sender, EventArgs e)
    {
        if (gvTray.Rows.Count > 0)
            btnConfirm.Visible = true;
    }

}