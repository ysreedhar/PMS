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
using System.Data.Odbc;
using PMSApp.BusinessLogicLayer;
using PMSdbTableAdapters;

public partial class ERS_SupplySC : System.Web.UI.Page
{
    private int NumofAttempts;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            txtReferenceNumber.Text = txtReferenceNumber.Text;
            txtRemarks.Text = txtRemarks.Text;
            txtTransactionDate.Text = txtTransactionDate.Text;

            FillSubconCartFromCookies();
            hlInsertItems.NavigateUrl = String.Format("javascript:window.open('SubConMD.aspx?Loc=" + ddlSupplyFromLocation.SelectedItem.Text + "&WH=" + ddlSupplyFromWarehouse.SelectedItem.Text + "', 'mywindow', 'menubar=0,resizable=0,width=450,height=250,toolbars=0');void('');");
            hlInsertItems.Visible = true;
        }
        if (!Page.IsPostBack)
        {
            
        }
        if (lblSupplyViaWH.Text == "")
            GetSupplyViaWHLOC();
    }
    protected void gvSupply_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Get the index of the clicked row
        int rowindex = Convert.ToInt32(e.CommandArgument);

        switch (e.CommandName)
        {
            case "SelectItem":
                /*                mvSupply.SetActiveView(vwItemTransaction);
                                GridViewRow thisGridViewRow = gvRequisitionTransaction.Rows[rowindex];
                                HiddenField hfItemName = (HiddenField)thisGridViewRow.FindControl("hfItemName");
                                HiddenField hfRDetailID = (HiddenField)thisGridViewRow.FindControl("hfRDetailID");
                                strSelectedItemName = hfItemName.Value;
                                BindGridItemSupply(strSelectedItemName);
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
                                lblITSRequiredQuantity.Text = gvRequisitionTransaction.Rows[rowindex].Cells[9].Text;
                                lblITSRequiredDate.Text = gvRequisitionTransaction.Rows[rowindex].Cells[8].Text;
                                lblITSRequiredSequence.Text = gvRequisitionTransaction.Rows[rowindex].Cells[10].Text;
                                lblITSRequiredTime.Text = gvRequisitionTransaction.Rows[rowindex].Cells[11].Text;
                 */
                break;
        }

    }

    void GetSupplyViaWHLOC()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        lblSupplyViaWH.Text = settings.InvControlWarehouse.ToString();
        lblSupplyViaLocation.Text = settings.InvControlLocation.ToString();
        lblSupplyViaWHDesc.Text = DataFunctions.FunGetWarehouseDesc(lblSupplyViaWH.Text);
        lblSupplyViaLocationDesc.Text = DataFunctions.FunGetLocationDesc(lblSupplyViaWH.Text, lblSupplyViaLocation.Text);
    }
    private void FillSubconCartFromCookies()
    {
        HttpCookie c = HttpContext.Current.Request.Cookies["SCSupply"];
        ArrayList items = new ArrayList();
        //Response.Write(items.Count);
        if (c != null)
        {
            if (c.Values.Count > 0)
            {
                for (int i = 0; i < c.Values.Count; i++)
                {
                    string[] vals = c.Values[i].Split('|');
                    STray item = new STray();
                    item.ItemCount = vals[0];
                    item.SupplyItemName = vals[1];
                    item.SCItemDesc = vals[2];
                    item.SCItemUOM = vals[3];
                    item.SupplyQuantity = vals[4];
                    item.SupplyItemType = vals[5];
                    items.Add(item);
                }
            }
            gvSupply.DataSource = items;
            gvSupply.DataBind();
        }
    }
    protected void gvSupply_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        if (NumofAttempts < 1)
        {
            HttpCookie c = HttpContext.Current.Request.Cookies["SCSupply"];
            c.Values.Remove(gvSupply.Rows[e.RowIndex].Cells[0].Text);
            Response.Cookies.Add(c);
            FillSubconCartFromCookies();
            NumofAttempts++;
        }
        if (gvSupply.Rows.Count == 0)
        {
            Response.Cookies["SCSupply"].Expires = DateTime.Now;
        }
    }
    protected void ddlSupplyFromWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFromWareHousedesc.Text = ddlSupplyFromWarehouse.SelectedValue.ToString();
    }
    protected void ddlSupplyFromLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblLocationdesc.Text = ddlSupplyFromLocation.SelectedValue.ToString();
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
            lblLocationdesc.Text = ddlSupplyFromLocation.Items[0].Value;
        }
        else
        {
            lblLocationdesc.Text = "";
        }
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        
        tblSalesSupplyTableAdapter SalesSupplyTableAdapter = new tblSalesSupplyTableAdapter();
        int new_SupplyID = Convert.ToInt32(SalesSupplyTableAdapter.InsertSalesSupply(ddlSupplyFromWarehouse.SelectedItem.Text,ddlSupplyFromLocation.SelectedItem.Text,ddlToWarehouse.SelectedItem.Text,ddlToLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text),txtVendorNumber.Text.Trim(),  txtReferenceNumber.Text, txtRemarks.Text, rblTransactionType.SelectedItem.Text, HttpContext.Current.User.Identity.Name));

        //Response.Write("new value :" + new_SupplyID);
        tblSalesSupplyDetailsTableAdapter SalesSupplyItemAdapter = new tblSalesSupplyDetailsTableAdapter();
        foreach (GridViewRow RItem in gvSupply.Rows)
        {
            SalesSupplyItemAdapter.InsertSalesSupplyDetails(new_SupplyID, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[4].Text));
            GridViewRow thisGridViewRow = gvSupply.Rows[RItem.RowIndex];
            HiddenField hfItemType = (HiddenField)thisGridViewRow.FindControl("hfItemType");
            decimal dechfItemType = Convert.ToDecimal(hfItemType.Value);
            if (dechfItemType == 0)
            {
                MapicsSupplyTransactions.WriteSubConSupplyTransaction(RItem.Cells[1].Text, ddlSupplyFromWarehouse.SelectedItem.Text, RItem.Cells[3].Text, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text), ddlSupplyFromLocation.SelectedItem.Text, ddlToWarehouse.SelectedItem.Text, ddlToLocation.SelectedItem.Text, Convert.ToDecimal(RItem.Cells[4].Text), RItem.Cells[2].Text, Convert.ToDecimal(DateTime.Now.ToString("yyyyMMdd")), Convert.ToDecimal(DateTime.Now.ToString("hhmmss")), HttpContext.Current.User.Identity.Name);
                //Response.Write(RItem.Cells[1].Text + " : " + ddlSupplyFromWarehouse.SelectedItem.Text + " : " + RItem.Cells[3].Text + " : " + CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text) + " : " + ddlSupplyFromLocation.SelectedItem.Text + " : " + ddlToWarehouse.SelectedItem.Text + " : " + ddlToLocation.SelectedItem.Text + " : " + Convert.ToDecimal(RItem.Cells[4].Text) + " : " + RItem.Cells[2].Text + " : " + Convert.ToDecimal(DateTime.Now.ToString("yyyyMMdd")) + " : " + Convert.ToDecimal(DateTime.Now.ToString("hhmmss")) + " : " + HttpContext.Current.User.Identity.Name + " : " + CommonFunctions.ConvertAppDateToCMapicsFormat(CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text)));
            }
            
        }
        // Show Message

        lblMessage.Text = "Supply Operation successful. Delivery Number: " + String.Format("{0:0000000}", new_SupplyID);
        // Set The View to next search and show the link for Delivery Note
        hlDeliveryNote.NavigateUrl = String.Format("javascript:window.open('../SubConDeliveryNote.aspx?DlNo=" + new_SupplyID + "', null, 'height=500,width=650,status=yes,toolbar=no,menubar=no,location=no'); void('');");
        Response.Cookies["SCSupply"].Expires = DateTime.Now;
        mvSupplyWR.SetActiveView(vwSuccess);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/ICSupply/ICSupplySC.aspx");
        Response.Cookies["SCSupply"].Expires = DateTime.Now;
    }

    protected void ddlSupplyFromWarehouse_OnDataBound(object sender, EventArgs e)
    {
        lblFromWareHousedesc.Text = ddlSupplyFromWarehouse.Items.FindByText("1").Value;
    }
    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/ICSupply/ICSupplySC.aspx");
    }
    protected void ddlToWarehouse_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlSupplyToLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void rblTransactionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblTransactionType.SelectedItem.Text == "Sales")
        {
            pnlVendorData.Visible = true;
        }
        else
        {
            pnlVendorData.Visible = false;
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
    protected void gvSupply_DataBound(object sender, EventArgs e)
    {
        if (gvSupply.Rows.Count > 0)
            btnOK.Visible = true;
    }

}
