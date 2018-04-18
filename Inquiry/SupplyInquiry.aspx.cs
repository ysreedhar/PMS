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
using PMSdbTableAdapters;

public partial class ERS_SupplyInquiry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hfUserID.Value = Context.User.Identity.Name;
        }
    }
    private void BindGrid()
    {
        dtSupplyInquiryTableAdapter SupplyInquiryAdapter = new dtSupplyInquiryTableAdapter();
        gvSupplyInquiry.DataSource = SupplyInquiryAdapter.GetDataBySupplyInquiryParams(ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text.Trim(), ddlSupplyFromWarehouse.SelectedItem.Text, ddlSupplyFromLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtSupplyDtFrom.Text), CommonFunctions.ConvertToUniversalDate(txtSupplyDtTo.Text));
        gvSupplyInquiry.DataBind();
    }
    protected void btnResultsBack_Click(object sender, EventArgs e)
    {
        mvSupplyInquiry.SetActiveView(vwSearch);
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (ValidationFunctions.IsValidDateRange(txtSupplyDtFrom.Text, txtSupplyDtTo.Text))
        {
            BindGrid();
            lblResultsRFromWh.Text = ddlSupplyFromWarehouse.SelectedItem.Text + " - " + lblFromWareHousedesc.Text;
            lblResultsRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWarehouseDesc.Text;
            lblResultsRFromLoc.Text = ddlSupplyFromLocation.SelectedItem.Text + " - " + lblFromLocationdesc.Text;
            lblResultsRToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
            lblReqFrom.Text = txtSupplyDtFrom.Text;
            lblReqTo.Text = txtSupplyDtTo.Text;
            lblErrorMessage.Text = "";
            mvSupplyInquiry.SetActiveView(vwResults);
        }
        else
        {
            lblErrorMessage.Text = "Not a Valid Date range";
        }
    }
    protected void gvSupplyInquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSupplyInquiry.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void gvSupplyInquiry_DataBound(object sender, EventArgs e)
    {

    }
    protected void gvSupplyInquiry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        ((BoundField)gvSupplyInquiry.Columns[7]).DataFormatString = CommonFunctions.GetAppDateFormat();
        ((BoundField)gvSupplyInquiry.Columns[13]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }

    protected void ddlSupplyFromWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFromWareHousedesc.Text = ddlSupplyFromWarehouse.SelectedValue.ToString();
    }
    protected void ddlSupplyFromLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFromLocationdesc.Text = ddlSupplyFromLocation.SelectedValue.ToString();
    }
    protected void ddlToWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblToWarehouseDesc.Text = ddlToWarehouse.SelectedValue.ToString();
    }

    protected void ddlSupplyFromWarehouse_DataBound(object sender, EventArgs e)
    {
        if (ddlSupplyFromWarehouse.Items.Count > 0)
        {
            lblFromWareHousedesc.Text = ddlSupplyFromWarehouse.Items[0].Value;
        }
        else
        {
            lblFromWareHousedesc.Text = "";
        }
    }
    protected void ddlSupplyFromLocation_DataBound(object sender, EventArgs e)
    {
        if (ddlSupplyFromLocation.Items.Count > 0)
        {
            ddlSupplyFromLocation.SelectedIndex = ddlSupplyFromLocation.Items.IndexOf(ddlSupplyFromLocation.Items.FindByText(ReturnSiteVariables.ReturnAppInvControl().ToString()));
            lblFromLocationdesc.Text = ddlSupplyFromLocation.SelectedItem.Value;
        }
        else
        {
            lblFromLocationdesc.Text = "";
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

            lblToLocationDesc.Text = ddlToLocation.Items[0].Value;
        }
        else
        {
            lblToLocationDesc.Text = "";
        }

    }
    protected void ddlToWarehouse_DataBound(object sender, EventArgs e)
    {
        if (ddlToWarehouse.Items.Count > 0)
        {
            lblToWarehouseDesc.Text = ddlToWarehouse.Items[0].Value;
        }
        else
        {
            lblToWarehouseDesc.Text = "";
        }
    }

}
