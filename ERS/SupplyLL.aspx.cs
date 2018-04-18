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
using PMSdbTableAdapters;
using MPPDATATableAdapters;
using PMSApp.BusinessLogicLayer;
using System.Text;

public partial class ERS_SupplyLL : System.Web.UI.Page
{
    private string ConnStr = ConfigurationManager.ConnectionStrings["PMSdbConnection"].ConnectionString;
    protected SqlConnection conn;
    private string strSelectedItemName;
    private int RCount, NumofAttempts;
    private string itemdetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hfUserID.Value = Context.User.Identity.Name;
            chkTUAIP.Visible = ReturnSiteVariables.ReturnAppImplementsTUAIP();
        }
    }


    private void BindGrid()
    {
        dtRequisitionItemsTableAdapter RequisitionItemsAdapter = new dtRequisitionItemsTableAdapter();
        if (chkShowClosedRequisition.Checked == true)
        {
            gvRequisitionInquiry.DataSource = RequisitionItemsAdapter.GetDataBySupplierLocationAll(ddlToLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtRequestedDateFrom.Text), CommonFunctions.ConvertToUniversalDate(txtRequestedDateTo.Text), ddlToWarehouse.SelectedItem.Text);
        }
        else
        {
            gvRequisitionInquiry.DataSource = RequisitionItemsAdapter.GetDataBySupplierLocationActive(ddlToLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtRequestedDateFrom.Text), CommonFunctions.ConvertToUniversalDate(txtRequestedDateTo.Text), ddlToWarehouse.SelectedItem.Text);
        }
        gvRequisitionInquiry.DataBind();
    }
    private void BindGridRTransaction(decimal decRequestID)
    {
        dtRequisitionItemsTableAdapter RequisitionItemsAdapter = new dtRequisitionItemsTableAdapter();
        gvRequisitionTransaction.DataSource = RequisitionItemsAdapter.GetDataBySupplierLocationRequisitionNumber(ddlToLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtRequestedDateFrom.Text), CommonFunctions.ConvertToUniversalDate(txtRequestedDateTo.Text), ddlToWarehouse.SelectedItem.Text, decRequestID);
        gvRequisitionTransaction.DataBind();
    }
    protected void btnResultsBack_Click(object sender, EventArgs e)
    {
        mvSupply.SetActiveView(vwSearch);
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvSupply.SetActiveView(vwResults);
    }
    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/SupplyLL.aspx");
    }
    protected void btnForceClose_Click(object sender, EventArgs e)
    {
        tblRequisitionTableAdapter RequisitionStatusAdapter = new tblRequisitionTableAdapter();
        //Response.Write(gvRequisitionTransaction.Rows[0].Cells[3].Text);
        decimal RequestID = Convert.ToDecimal(gvRequisitionTransaction.Rows[0].Cells[2].Text);
        if (gvRequisitionTransaction.Rows[0].Cells[3].Text != "Force Closed")
        {
            RequisitionStatusAdapter.spForceCloseRequisition(RequestID);
        }
        else
        {
            RequisitionStatusAdapter.spReactivateRequisition(RequestID);
        }
        BindGridRTransaction(RequestID);

    }
    protected void btnReOpen_Click(object sender, EventArgs e)
    {

    }
    protected void btnRSummaryBack_Click(object sender, EventArgs e)
    {
        mvSupplyTransactions.SetActiveView(vwRequisitionSummary);
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (ValidationFunctions.IsValidDateRange(txtRequestedDateFrom.Text, txtRequestedDateTo.Text))
        {
            lblResultsRToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWareHouseDesc.Text;
            lblResultsRToLoc.Text = ddlToLocation.SelectedItem.Text + " - " + lblToLocationDesc.Text;
            lblReqFrom.Text = txtRequestedDateFrom.Text;
            lblReqTo.Text = txtRequestedDateTo.Text;
            mvSupply.SetActiveView(vwResults);
            lblErrorMessage.Text = "";
            BindGrid();
        }
        else
        {
            lblErrorMessage.Text = "Not a Valid Date range";
        }
    }
    protected void ddlToWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblToWareHouseDesc.Text = ddlToWarehouse.SelectedValue.ToString();
    }
    protected void ddlToLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblToLocationDesc.Text = ddlToLocation.SelectedValue.ToString();
    }
    protected void gvRequestDetails_SelectedIndexChanged(object sender, EventArgs e)
    {

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

    protected void gvRequisitionInquiry_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        // ((BoundColumn)gvRequisitionInquiry.Columns[4]).DataFormatString = CommonFunctions.GetAppDateFormat();

    }

    protected void GetOnHandItemInventory(string Warehouse, string Location, string ItemName)
    {
        try
        {
            conn = new SqlConnection(ConnStr);
            conn.Open();

            SqlCommand myCommand = new SqlCommand("SELECT Quantity FROM tblLineInventory WHERE ItemName = '" + ItemName + "' and WareHouse = '" + Warehouse + "' and Location = '" + Location + "'", conn);
            myCommand.Parameters.Add("@ItemName", SqlDbType.VarChar, 20).Value = ItemName;
            myCommand.Parameters.Add("@Warehouse", SqlDbType.VarChar, 5).Value = Warehouse;
            myCommand.Parameters.Add("@Location", SqlDbType.VarChar, 10).Value = Location;
            SqlDataReader reader = myCommand.ExecuteReader();
            while (reader.Read())
            {
                // retriving Details
                lblOnHandInventory.Text = (reader["Quantity"].ToString());
                if (lblOnHandInventory.Text == null)
                {
                    lblOnHandInventory.Text = "0";
                }
            }
            reader.Close();

        }

        catch (SqlException ex)
        {
            Response.Write(ex);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();

            }

        }

    }

    protected void gvRequisitionInquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRequisitionInquiry.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void gvRequisitionInquiry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        ((BoundField)gvRequisitionInquiry.Columns[6]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }
    protected void gvRequisitionInquiry_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Get the index of the clicked row
        int rowindex = Convert.ToInt32(e.CommandArgument);

        switch (e.CommandName)
        {
            case "SelectRequisition":
                mvSupplyTransactions.SetActiveView(vwRequisitionTransaction);
                //Response.Write(gvRequisitionInquiry.DataKeys[rowindex].Value);
                BindGridRTransaction(Convert.ToDecimal(gvRequisitionInquiry.DataKeys[rowindex].Value));
                chkShowClosedRequisition.Visible = false;
                tblRequisitionTableAdapter SetToActiveAdapter = new tblRequisitionTableAdapter();
                SetToActiveAdapter.spUpdateRequestStatusToActive(Convert.ToDecimal(gvRequisitionInquiry.DataKeys[rowindex].Value));

                break;
            case "SelectItem":
                mvSupplyTransactions.SetActiveView(vwItemTransaction);
                break;
        }

    }

    protected void gvRequisitionTransaction_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRequisitionInquiry.PageIndex = e.NewPageIndex;
        //BindGridRTransaction(Convert.ToDecimal(gvRequisitionTransaction.DataKeyNames.GetValue[0]));
    }
    protected void gvRequisitionTransaction_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        ((BoundField)gvRequisitionTransaction.Columns[6]).DataFormatString = CommonFunctions.GetAppDateFormat();
    }
    protected void gvRequisitionTransaction_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Get the index of the clicked row
        int rowindex = Convert.ToInt32(e.CommandArgument);

        switch (e.CommandName)
        {
            case "SelectItem":
                mvSupply.SetActiveView(vwItemTransaction);
                GridViewRow thisGridViewRow = gvRequisitionTransaction.Rows[rowindex];
                HiddenField hfItemName = (HiddenField)thisGridViewRow.FindControl("hfItemName");
                HiddenField hfRDetailID = (HiddenField)thisGridViewRow.FindControl("hfRDetailID");
                strSelectedItemName = hfItemName.Value;
                GetOnHandItemInventory(ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text, strSelectedItemName);
                //Show Item Transaction Data
                lblITSFromWarehouse.Text = lblResultsRToWh.Text;
                lblITSToWarehouse.Text = gvRequisitionTransaction.Rows[rowindex].Cells[0].Text;
                lblITSFromLocation.Text = lblResultsRToLoc.Text;
                lblITSToLocation.Text = gvRequisitionTransaction.Rows[rowindex].Cells[1].Text;
                lblITSRequsitionNumber.Text = gvRequisitionTransaction.Rows[rowindex].Cells[2].Text;
                lblITSItemNumber.Text = strSelectedItemName;
                lblITHRDetailID.Text = hfRDetailID.Value;
                lblITSItemDesc.Text = gvRequisitionTransaction.Rows[rowindex].Cells[6].Text;
                lblITSItemUOM.Text = gvRequisitionTransaction.Rows[rowindex].Cells[7].Text;
                txtTransactionQtyUOM.Text = lblITSItemUOM.Text;
                lblOHIOUM.Text = lblITSItemUOM.Text;
                lblITSRequiredQuantity.Text = gvRequisitionTransaction.Rows[rowindex].Cells[9].Text;
                lblITSRequiredDate.Text = gvRequisitionTransaction.Rows[rowindex].Cells[8].Text;
                lblITSRequiredSequence.Text = gvRequisitionTransaction.Rows[rowindex].Cells[10].Text;
                lblITSRequiredTime.Text = gvRequisitionTransaction.Rows[rowindex].Cells[11].Text;
                break;
        }

    }

    protected void btnPostSupplyTransaction_Click(object sender, EventArgs e)
    {
        tblSupplyTableAdapter SupplyTableAdapter = new tblSupplyTableAdapter();
        int new_SupplyID = Convert.ToInt32(SupplyTableAdapter.InsertSupply(lblITSToWarehouse.Text, lblITSToLocation.Text, ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text), HttpContext.Current.User.Identity.Name));
        //Response.Write("new value :" + new_SupplyID);
        tblSupplyDetailsTableAdapter SupplyItemAdapter = new tblSupplyDetailsTableAdapter();
        tblLineInventoryTableAdapter InvUpdateAdapter = new tblLineInventoryTableAdapter();
        foreach (GridViewRow RItem in gvSupplyTray.Rows)
        {
            GridViewRow thisGridViewRow = gvRequisitionTransaction.Rows[RItem.RowIndex];
            HiddenField hfRDetailID = (HiddenField)thisGridViewRow.FindControl("hfRDetailID");
            decimal decRDetailID = Convert.ToDecimal(hfRDetailID.Value);
            SupplyItemAdapter.InsertSupplyDetailsWithRequisition(new_SupplyID, decRDetailID, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[3].Text), RItem.Cells[6].Text.Trim());
            SupplyItemAdapter.spManageRequestStatus(decRDetailID, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text));
            InvUpdateAdapter.spUpdateOnhandInventoryForWHLocation(ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text, lblITSToWarehouse.Text, lblITSToLocation.Text, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[3].Text), CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text));
        }
        // Show Message

        lblMessage.Text = "Supply Operation successfull. Delivery Number: " + String.Format("{0:0000000}", new_SupplyID);
        // Set The View to next search and show the link for Delivery Note
        hlDeliveryNote.NavigateUrl = String.Format("javascript:window.open('DeliveryNote.aspx?DlNo=" + new_SupplyID + "', null, 'height=500,width=650,status=yes,toolbar=no,menubar=no,location=no'); void('');");
        mvSupply.SetActiveView(vwSuccess);
    }
    protected void btnAddSupply_Click(object sender, EventArgs e)
    {
        InsertNewSupplyItem(lblITSItemNumber.Text, lblITSItemDesc.Text, txtTransactionQty.Text, lblITSItemUOM.Text, txtTransactionDate.Text, "", lblITHRDetailID.Text);
        FillSupplyCartFromCookies();

        // mvSupply.SetActiveView(vwConfirm);
    }
    protected void InsertNewSupplyItem(string strSupplyItemName, string strSupplyItemDesc, string strSupplyQuantity, string strSupplyItemUOM, string strTransactionDate, string strPONumber, string strRDetailId)
    {
        HttpCookie c = null;
        if (HttpContext.Current.Request.Cookies["supplytray"] == null)
        {
            c = new HttpCookie("supplytray");
            RCount = 1;
        }
        else
        {
            c = HttpContext.Current.Request.Cookies["supplytray"];
            RCount = c.Values.Count + 1;
        }

        itemdetails = RCount + "|" + strSupplyItemName + "|" + strSupplyItemDesc + "|" + strSupplyQuantity + "|" + strSupplyItemUOM + "|" + strTransactionDate + "|" + strPONumber + "|" + strRDetailId;
        c.Values[RCount.ToString()] = itemdetails;
        //Response.Write(c.Values.ToString());
        Response.Cookies.Add(c);
    }
    protected void gvSupplyTray_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (NumofAttempts < 1)
        {
            HttpCookie c = HttpContext.Current.Request.Cookies["supplytray"];
            c.Values.Remove(gvSupplyTray.Rows[e.RowIndex].Cells[0].Text);
            Response.Cookies.Add(c);
            FillSupplyCartFromCookies();
            NumofAttempts++;
        }
        if (gvSupplyTray.Rows.Count == 0)
        {
            mvSupply.SetActiveView(vwResults);
            Response.Cookies["supplytray"].Expires = DateTime.Now;
        }
    }
    private void FillSupplyCartFromCookies()
    {
        HttpCookie c = HttpContext.Current.Request.Cookies["supplytray"];
        ArrayList items = new ArrayList();
        //Response.Write(items.Count);
        if (c.Values.Count > 0)
        {
            for (int i = 0; i < c.Values.Count; i++)
            {
                string[] vals = c.Values[i].Split('|');
                SupplyRTray item = new SupplyRTray();
                item.SupplyItemCount = vals[0];
                item.SupplyItemName = vals[1];
                item.SupplyItemDesc = vals[2];
                item.SupplyQuantity = vals[3];
                item.SupplyItemUOM = vals[4];
                if (vals[5] != "")
                {
                    item.SupplyDate = vals[5];
                }
                else
                {
                    item.SupplyDate = DateTime.Now.ToShortDateString();
                }
                item.PONumber = vals[6];
                item.RDetailID = vals[7];
                items.Add(item);
            }
        }
        gvSupplyTray.DataSource = items;
        gvSupplyTray.DataBind();

    }
    protected void btnSupplyCancel_Click(object sender, EventArgs e)
    {
        mvSupply.SetActiveView(vwSearch);
    }

    protected void chkShowClosedRequisition_OnCheckedChanged(object sender, EventArgs e)
    {
        BindGrid();

    }
}
