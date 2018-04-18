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
using PMSdbTableAdapters;
using PMSApp.BusinessLogicLayer;
using System.Text;

public partial class ERS_RequisitionInquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hfUserID.Value = Context.User.Identity.Name;

    }

    private void BindGrid()
    {
        dtRequisitionItemsTableAdapter RequisitionItemsAdapter = new dtRequisitionItemsTableAdapter();
        gvRequisitionInquiry.DataSource = RequisitionItemsAdapter.GetDataByRequestInquiryParams(ddlToLocation.SelectedItem.Text.Trim(), ddlFromLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtRequiredDateFrom.Text), CommonFunctions.ConvertToUniversalDate(txtRequiredDateTo.Text), ddlToWarehouse.SelectedItem.Text, ddlFromWarehouse.SelectedItem.Text);
        gvRequisitionInquiry.DataBind();
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (ValidationFunctions.IsValidDateRange(txtRequiredDateFrom.Text, txtRequiredDateTo.Text))
        {
            lblResultsRFromWh.Text = ddlFromWarehouse.SelectedItem.Text + " - " + lblWareHousedesc.Text;
            lblResultsRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWareHouseDesc.Text;
            lblResultsRFromLoc.Text = ddlFromLocation.SelectedItem.Text + " - " + lblLocationdesc.Text;
            lblResultsRToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
            lblReqFrom.Text = txtRequiredDateFrom.Text;
            lblReqTo.Text = txtRequiredDateTo.Text;
            // view Request Modification Labels
            lblvmrRFromWh.Text = ddlFromWarehouse.SelectedItem.Text + " - " + lblWareHousedesc.Text;
            lblvmrRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWareHouseDesc.Text;
            lblvmrRFromLoc.Text = ddlFromLocation.SelectedItem.Text + " - " + lblLocationdesc.Text;
            lblvmrRToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
            lblvmrReqDateFrom.Text = txtRequiredDateFrom.Text;
            lblvmrReqDateTo.Text = txtRequiredDateTo.Text;
            mvRequisitionInquiry.SetActiveView(vwResults);
            lblErrorMessage.Text = "";
            BindGrid();
        }
        else
        {
            lblErrorMessage.Text = "Not a Valid Date range";
        }
    }
    protected void btnResultsBack_Click(object sender, EventArgs e)
    {
        mvRequisitionInquiry.SetActiveView(vwSearch);
        gvRequisitionInquiry.SelectedIndex = -1;
    }
    protected void btnMRBack_Click(object sender, EventArgs e)
    {
        mvRequisitionInquiry.SetActiveView(vwResults);
        gvRequisitionInquiry.SelectedIndex = -1;
    }

    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {

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

    protected void gvRequisitionInquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRequisitionInquiry.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btnShowRequisitonDetails_Click(object sender, GridViewCommandEventArgs e)
    {
        mvRequisitionInquiry.SetActiveView(vwModifyRequisition);

    }
    protected void gvRequisitionInquiry_DataBound(object sender, EventArgs e)
    {

    }
    protected void gvRequisitionInquiry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        ((BoundField)gvRequisitionInquiry.Columns[6]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }
    protected void gvReqDetails_DataBound(object sender, EventArgs e)
    {

    }
    protected void gvReqDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //((BoundField)gvReqDetails.Columns[4]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }
    protected void gvRequisitionInquiry_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Get the index of the clicked row
        int rowindex = Convert.ToInt32(e.CommandArgument);

        switch (e.CommandName)
        {
            case "Select":
                mvRequisitionInquiry.SetActiveView(vwModifyRequisition);
                // Response.Write(gvRequisitionInquiry.Rows[rowindex].Cells[2].Text);
                if (gvRequisitionInquiry.Rows[rowindex].Cells[2].Text != "New")
                {

                    gvReqDetails.Columns[0].Visible = false; ;

                }
                break;
            case "EditEvent":

                break;
        }

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
