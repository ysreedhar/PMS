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
using MPPDATATableAdapters;


public partial class ERS_ICSupplyWR : System.Web.UI.Page
{
    protected int RCount, NumofAttempts, intClickedRowId;
    private string itemdetails;
    protected double dblTotalCurrentSupply;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            hfUserID.Value = Context.User.Identity.Name;
            // Allow users to Implement Transfer Using Alternate Item Policy:
            chkTUAI.Visible = ReturnSiteVariables.ReturnAppImplementsTUAIP();
            //Response.Write(settings.ImplementsTUAIP);
            
            //CheckConnection();
            
        }
    }
    void CheckConnection()
    {
        /*try
        {
            conn.Open();
        }
        catch (Exception)
        {
            if (conn.State != ConnectionState.Closed)
            {
                Response.Redirect("~/Offline.aspx");
            }
        }*/
    }
    void BindGridItemSupply(string ItemName)
    {
        MI5RSRDPTableAdapter SupplyItemAdapter = new MI5RSRDPTableAdapter();
        if (rblTransactionType.SelectedIndex == 0)
        {
            gvSupply.DataSource = SupplyItemAdapter.GetDataByWhLocItemNo(ItemName, ddlSupplyFromWarehouse.SelectedItem.Text, ddlSupplyFromLocation.SelectedItem.Text);
        }
        else
        {
            gvSupply.DataSource = SupplyItemAdapter.GetDataByWhLocItemNoReturnTransaction(ItemName, ddlSupplyFromWarehouse.SelectedItem.Text, ddlSupplyFromLocation.SelectedItem.Text);
        }
        
        gvSupply.DataBind();
    
    }
    protected void btnGetInventory_Click(object sender, EventArgs e)
    {
        BindGridItemSupply(txtItemName.Text);
        lblItemDesc.Text = hfItemDesc.Value;
        lblItemUOM.Text = hfItemUOM.Value;
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        
        lblTransactionType.Text = rblTransactionType.SelectedItem.Text;
        lblResultsSFromWh.Text = ddlSupplyFromWarehouse.SelectedItem.Text + " - " + lblFromLocationdesc.Text;
        lblResultsSToWh.Text = ddlToWarehouse.SelectedItem.Text + " - " + lblToWarehouseDesc.Text;
        lblResultsSFromLoc.Text = ddlSupplyFromLocation.SelectedItem.Text + " - " + lblFromLocationdesc.Text;
        lblResultsSToLoc.Text = ddlToLocation.SelectedItem.Text.Trim() + " - " + lblToLocationDesc.Text;
        lblTransactionDate.Text = txtTransactionDate.Text;

        mvSupplyWR.SetActiveView(vwResults);
    }
    protected void btnSupplyConfirm_Click(object sender, EventArgs e)
    {

        HttpCookie c = null;
        if (HttpContext.Current.Request.Cookies["supplyWRtray"] == null)
            c = new HttpCookie("supplyWRtray");
        else
            c = HttpContext.Current.Request.Cookies["supplyWRtray"];
        foreach (GridViewRow SupplyItemRow in gvSupply.Rows)
        {

            //  Response.Write(((System.Web.UI.WebControls.TextBox)SupplyItemRow.Cells[6].Controls[1]).Text);
            double dblSupplyQuantity = 0;
            try
            {
                dblSupplyQuantity = Double.Parse(((System.Web.UI.WebControls.TextBox)SupplyItemRow.Cells[12].Controls[1]).Text);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
            if (dblSupplyQuantity > 0)
            {
                InsertNewSupplyItem(txtItemName.Text.Trim(), hfItemDesc.Value, ((System.Web.UI.WebControls.TextBox)SupplyItemRow.Cells[12].Controls[1]).Text, hfItemUOM.Value, txtTransactionDate.Text, SupplyItemRow.Cells[2].Text, SupplyItemRow.Cells[5].Text, SupplyItemRow.Cells[6].Text, SupplyItemRow.Cells[7].Text);
                FillSupplyCartFromCookies();
            }
        }

        mvSupplyWR.SetActiveView(vwConfirm);
    }
    protected void InsertNewSupplyItem(string strSupplyItemName, string strSupplyItemDesc, string strSupplyQuantity, string strSupplyItemUOM, string strTransactionDate, string strPONumber, string strDONumber, string strPalletNumber, string strBoxNumber)
    {
        HttpCookie c = null;
        if (HttpContext.Current.Request.Cookies["supplyWRtray"] == null)
        {
            c = new HttpCookie("supplyWRtray");
            RCount = 1;
        }
        else
        {
            c = HttpContext.Current.Request.Cookies["supplyWRtray"];
            RCount = c.Values.Count + 1;
        }

        itemdetails = RCount + "|" + strSupplyItemName + "|" + strSupplyItemDesc + "|" + strSupplyQuantity + "|" + strSupplyItemUOM + "|" + strTransactionDate + "|" + strPONumber + "|" + strDONumber + "|" + strPalletNumber + "|" + strBoxNumber;
        c.Values[RCount.ToString()] = itemdetails;
        //Response.Write(c.Values.ToString());
        Response.Cookies.Add(c);
    }
    protected void gvSupply_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //((BoundField)gvSupply.Columns[4]).DataFormatString = CommonFunctions.GetAppDateFormat();


    }
    protected void gvSupplyTray_DataBound(object sender, EventArgs e)
    {
        if (gvSupplyTray.Rows.Count > 0)
            btnConfirm.Visible = true;
    }
    private void FillSupplyCartFromCookies()
    {
        HttpCookie c = HttpContext.Current.Request.Cookies["supplyWRtray"];
        ArrayList items = new ArrayList();
        //Response.Write(items.Count);
        if (c.Values.Count > 0)
        {
            for (int i = 0; i < c.Values.Count; i++)
            {
                string[] vals = c.Values[i].Split('|');
                SupplyTray item = new SupplyTray();
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
                item.DONumber = vals[7];
                item.PalletNumber = vals[8];
                item.BoxNumber = vals[9];
                items.Add(item);
            }
        }
        gvSupplyTray.DataSource = items;
        gvSupplyTray.DataBind();

    }
    protected void gvSupplyTray_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (NumofAttempts < 1)
        {
            HttpCookie c = HttpContext.Current.Request.Cookies["supplyWRtray"];
            c.Values.Remove(gvSupplyTray.Rows[e.RowIndex].Cells[0].Text);
            Response.Cookies.Add(c);
            FillSupplyCartFromCookies();
            NumofAttempts++;
        }
        if (gvSupplyTray.Rows.Count == 0)
        {
            mvSupplyWR.SetActiveView(vwResults);
            Response.Cookies["supplyWRtray"].Expires = DateTime.Now;
            btnConfirm.Visible = false;
        }
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {

    }
    protected void btnSupplyCancel_Click(object sender, EventArgs e)
    {
        mvSupplyWR.SetActiveView(vwSearch);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvSupplyWR.SetActiveView(vwResults);
    }
    protected void lbReturnToStart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Ers/ICSupply/ICSupplyWR.aspx");
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        
        tblSupplyTableAdapter SupplyTableAdapter = new tblSupplyTableAdapter();
        int new_SupplyID = Convert.ToInt32(SupplyTableAdapter.InsertSupply(ddlToWarehouse.SelectedItem.Text,ddlToLocation.SelectedItem.Text,ddlSupplyFromWarehouse.SelectedItem.Text,ddlSupplyFromLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text), HttpContext.Current.User.Identity.Name));
        //Response.Write("new value :" + new_SupplyID);
        tblSupplyDetailsTableAdapter SupplyItemAdapter = new tblSupplyDetailsTableAdapter();
        foreach (GridViewRow RItem in gvSupplyTray.Rows)
        {
            if (Convert.ToDecimal(RItem.Cells[3].Text) > 0)
            {
                SupplyItemAdapter.InsertSupplyDetailsWithoutRequisition(new_SupplyID, RItem.Cells[1].Text, Convert.ToDecimal(RItem.Cells[3].Text), RItem.Cells[6].Text.Trim());
                MapicsSupplyTransactions.WriteSupplyTransactions(RItem.Cells[6].Text.Trim(), RItem.Cells[1].Text.Trim(), RItem.Cells[2].Text.Trim(), ddlToWarehouse.SelectedItem.Text, ddlSupplyFromWarehouse.SelectedItem.Text, Convert.ToDecimal(RItem.Cells[3].Text.Trim()), RItem.Cells[4].Text.Trim(), (RItem.Cells[9].Text.Trim() == "&nbsp;" ? " " : RItem.Cells[9].Text.Trim()), RItem.Cells[7].Text.Trim(), RItem.Cells[8].Text.Trim(), ddlSupplyFromLocation.SelectedItem.Text, CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text), ddlToLocation.SelectedItem.Text.Trim(), HttpContext.Current.User.Identity.Name);
                //Response.Write(RItem.Cells[6].Text.Trim() +  " : " + RItem.Cells[1].Text.Trim() +  " : " + RItem.Cells[2].Text.Trim() +  " : " + ddlToWarehouse.SelectedItem.Text +  " : " + ddlSupplyFromWarehouse.SelectedItem.Text +  " : " + Convert.ToDecimal(RItem.Cells[3].Text.Trim()) +  " : " + RItem.Cells[4].Text.Trim() +  " : " + RItem.Cells[9].Text.Trim() +  " : " + RItem.Cells[7].Text.Trim() +  " : " + RItem.Cells[8].Text.Trim() +  " : " + ddlSupplyFromLocation.SelectedItem.Text +  " : " + CommonFunctions.ConvertToUniversalDate(txtTransactionDate.Text) +  " : " + ddlToLocation.SelectedItem.Text.Trim() +  " : " + HttpContext.Current.User.Identity.Name);
            }
        }
        // Show Message

        lblMessage.Text = "Supply Operation successful. Delivery Number: " + String.Format("{0:0000000}", new_SupplyID);
        // Set The View to next search and show the link for Delivery Note
        hlDeliveryNote.NavigateUrl = String.Format("javascript:window.open('../DeliveryNote.aspx?DlNo=" + new_SupplyID + "', null, 'height=500,width=650,status=yes,toolbar=no,menubar=no,location=no'); void('');");
        Response.Cookies["supplyWRtray"].Expires = DateTime.Now;
        mvSupplyWR.SetActiveView(vwSuccess);


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
            btnSupplyConfirm.Visible = true;

    }
}
