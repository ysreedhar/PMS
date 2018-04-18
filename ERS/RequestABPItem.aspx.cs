using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Configuration;
using PMSdbTableAdapters;
using PMSApp.BusinessLogicLayer;

public partial class RequestABPItem : System.Web.UI.Page
{

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hfUserID.Value = Context.User.Identity.Name;
            
        }
    }
    private void BindDataList()
    {
        dtABPItemsTableAdapter ABPItemsAdapter = new dtABPItemsTableAdapter();
        dlPickListData.DataSource = ABPItemsAdapter.GetDataByPickListData(Convert.ToSingle(txtCEPNumber.Text));
        dlPickListData.DataBind();
    }
    private void BindGrid()
    {

        dtABPItemsTableAdapter ABPItemsAdapter = new dtABPItemsTableAdapter();
        gvRequirement.DataSource = ABPItemsAdapter.GetDataByOrderNo(Convert.ToSingle(txtCEPNumber.Text));
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





    protected void btnOK_Click(object sender, EventArgs e)
    {
        lblResultsRFromWh.Text = ddlFromWarehouse.SelectedItem.Text + " - " + lblWareHousedesc.Text;
        lblResultsRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWareHouseDesc.Text;
        lblResultsRFromLoc.Text = ddlFromLocation.SelectedItem.Text + " - " + lblLocationdesc.Text;
        lblResultsRToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
        lblResultsCEP.Text = txtCEPNumber.Text;
        MultiView1.SetActiveView(vwResults);
        BindGrid();
        BindDataList();
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        tblRequisitionTableAdapter RequisitionTableAdapter = new tblRequisitionTableAdapter();
        int new_RequestID = Convert.ToInt32(RequisitionTableAdapter.InsertABPItemRequisition(ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), 1, ddlFromWarehouse.SelectedItem.Text, ddlFromLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtRequiredDateFrom.Text), 10, Context.User.Identity.Name, txtCEPNumber.Text));
        tblRequestDetailsTableAdapter RequestItemAdapter = new tblRequestDetailsTableAdapter();
        
        foreach (GridViewRow RItem in gvRequirement.Rows)
        {
            RequestItemAdapter.InsertNewRequestABPItem(new_RequestID, RItem.Cells[0].Text, Convert.ToDecimal(RItem.Cells[3].Text), CommonFunctions.ConvertToUniversalDate(txtRequiredDateFrom.Text), txtRqTime.Text, 0, 10);
        }
        // Show Message
        lblSuccessfulTransactionNumber.Text = " - " + String.Format("{0:0000000}", new_RequestID);
        // Generate Email
        bool EmailSentBool = CommonFunctions.SendNewRequisitionEmail(new_RequestID, ddlFromWarehouse.SelectedItem.Text, ddlFromLocation.SelectedItem.Text, ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), Server.HtmlEncode("PMS-II - New Requisition Alert"), Server.HtmlEncode(String.Format("{0:0000000}", new_RequestID)));

        // Set The View to next search and show the link for Requisition Note
        hlRequisitionNote.NavigateUrl = String.Format("javascript:window.open('RequisitionNote.aspx?RqNo=" + new_RequestID + "', null, 'height=500,width=750,status=yes,toolbar=no,menubar=no,location=no'); void('');"); ;
        MultiView1.SetActiveView(vwSuccess);


    }
    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/RequestABPItem.aspx");
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
    
    protected void gvRequirement_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRequirement.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void gvRequirement_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[10].Text.Length > 6)
            {
                btnConfirm.Enabled = false;
            }
            e.Row.Cells[4].Text = CommonFunctions.ConvertMapicsStrToAppDateFormat(e.Row.Cells[4].Text);
        }
    }
    protected void gvRequirement_DataBound(object sender, EventArgs e)
    {
        foreach (GridViewRow iRow in gvRequirement.Rows)
        {
            iRow.Cells[5].Text = txtRequiredDateFrom.Text;
            iRow.Cells[6].Text = iRow.Cells[3].Text;
            iRow.Cells[8].Text = txtRqTime.Text;

        }
        if (gvRequirement.Rows.Count == 0)
        {
            btnConfirm.Enabled = false;
        }
    }

    protected void dlPickListData_ItemDataBound(object sender, DataListItemEventArgs e)
    {

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
}