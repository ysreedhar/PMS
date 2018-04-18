<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    Title="PMS - II Inventory Control With Requisition" CodeFile="ICSupplyR.aspx.cs"
    Inherits="Ers_ICSupplyR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center">
        <asp:HiddenField ID="hfRowClicked" runat="server" />
        <asp:HiddenField ID="hfTotalSupplyQty" runat="server" />
        <asp:MultiView ID="mvSupply" ActiveViewIndex="0" runat="server">
            <asp:View ID="vwSearch" runat="server">
                <table cellpadding="2" cellspacing="0" class="clsStd">
                    <tr>
                        <th colspan="3">
                            Inventory Control Supply (With Requisition)</th>
                    </tr>
                    <tr>
                        <td align="right">
                            Warehouse Code:
                        </td> 
                        <td align="left">
                                <asp:DropDownList ID="ddlToWarehouse" runat="server" DataValueField="Description"
                                    DataTextField="WAREHOUSE" DataSourceID="dsWareHouse" AutoPostBack="True" OnSelectedIndexChanged="ddlToWarehouse_SelectedIndexChanged"
                                    OnDataBound="ddlToWarehouse_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="dsWareHouse" runat="server" SelectCommand="select * from vUserWarehouseDesc where (UserName = @USRNAME) ORDER BY WAREHOUSE"
                                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <asp:HiddenField ID="hfUserID" runat="server" />
                            <td align="left">
                                <asp:Label ID="lblToWareHouseDesc" runat="server" CssClass="description"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Location:</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlToLocation" runat="server" DataValueField="BLR021" DataTextField="LocationsAccess"
                                    DataSourceID="dsToLocation" AutoPostBack="true" OnSelectedIndexChanged="ddlToLocation_SelectedIndexChanged"
                                    OnDataBound="ddlToLocation_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="dsToLocation" runat="server" SelectCommand="select * from vuserlocationdesc WHERE (WareHOUSE  = @WareHOUSE) and  (username = @UsrName)"
                                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlToWarehouse" Name="WareHOUSE" PropertyName="SelectedItem.Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                           
                        <td align="left">
                            <asp:Label ID="lblToLocationDesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            Requested Date From:</td>
                        <td align="left">
                            <asp:TextBox ID="txtRequestedDateFrom" runat="server" Width="100"></asp:TextBox>
                            <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequestedDateFrom','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                runat="server"></asp:HyperLink></td>
                        <td>
                            <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvRequestedDateFrom"
                                ValidationGroup="vgReqRange" ControlToValidate="txtRequestedDateFrom" Text="* Requested Date From is required!"
                                runat="server" />
                                 <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation" ControlToValidate="txtRequestedDateFrom" ValidationGroup="vgReqRange"
                                    ErrorMessage="Please enter a valid date" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$"
                                    ID="revRequestedDateFrom" /></td>
                    </tr>
                    <tr>
                        <td align="right">
                            To:</td>
                        <td align="left">
                            <asp:TextBox ID="txtRequestedDateTo" runat="server" Width="100"></asp:TextBox>
                            <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink1" NavigateUrl="javascript:calendar_window=window.open('../../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequestedDateTo','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                runat="server"></asp:HyperLink></td>
                        <td>
                            &nbsp;<asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvRequestedDateTo"
                                ValidationGroup="vgReqRange" ControlToValidate="txtRequestedDateTo" Text="* Required Date To is required!"
                                runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation" ControlToValidate="txtRequestedDateTo" ValidationGroup="vgReqRange"
                                    ErrorMessage="Please enter a valid date" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$"
                                    ID="revRequestedDateTo" /></td>
                    </tr>
                    <tr>
                        <td align="right">
                                        Transaction Date:</td>
                        <td align="left">
                                        <asp:TextBox ID="txtTransactionDate"  Width="100" runat="server"></asp:TextBox>
                                        <asp:HyperLink ID="hlTrasactionDatePicker" ImageUrl="~/Images/Calender.gif" 
                                        NavigateUrl="javascript:calendar_window=window.open('../../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtTransactionDate','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                     runat="server"></asp:HyperLink></td>
                        <td> <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvTransactionDate"
                                ValidationGroup="vgReqRange" ControlToValidate="txtTransactionDate" Text="* Transaction Date is required!"
                                runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation" ControlToValidate="txtTransactionDate" ValidationGroup="vgReqRange"
                                    ErrorMessage="Please enter a valid date" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$"
                                    ID="revTransactionDate" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button CssClass="button" ID="btnOK" CausesValidation="true" ValidationGroup="vgReqRange" runat="server" Text="OK" OnClick="btnOK_Click" /></td>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel" /></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                        <tr>
                        <td colspan="3" align="left">
                            <asp:ValidationSummary ValidationGroup="vgReqRange" CssClass="Validation" ID="vsValidRange" runat="server" />
                            <asp:Label ID="lblErrorMessage" CssClass="Validation" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vwResults" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table class="SelectionSummary" width="100%">
                                <tr>
                                    <td align="left" colspan="2">
                                        Request to Warehouse:<asp:Label ID="lblResultsRToWh" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        Location:
                                        <asp:Label ID="lblResultsRToLoc" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Requested Date From:<asp:Label ID="lblReqFrom" runat="server"></asp:Label></td>
                                    <td align="left">
                                        To:<asp:Label ID="lblReqTo" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:CheckBox ID="chkShowClosedRequisition" AutoPostBack="true" OnCheckedChanged="chkShowClosedRequisition_OnCheckedChanged" Text="Show Closed Requisitions:" runat="server"
                                            TextAlign="Left" /></td>
                                    <td align="left">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:MultiView ID="mvSupplyTransactions" ActiveViewIndex="0" runat="server">
                                            <asp:View ID="vwRequisitionSummary" runat="server">
                                                <asp:GridView ID="gvRequisitionInquiry" runat="server" AllowPaging="True" AllowSorting="True"
                                                    AutoGenerateColumns="False" CellPadding="4" EmptyDataText="No Requisitions found, please Search again for different date range" DataKeyNames="RequestID" Font-Size="X-Small"
                                                    ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvRequisitionInquiry_PageIndexChanging"
                                                    OnRowCommand="gvRequisitionInquiry_RowCommand" OnRowDataBound="gvRequisitionInquiry_RowDataBound"
                                                    Width="99%">
                                                    <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                                    <Columns>
                                                        <asp:BoundField DataField="WarehouseToID" HeaderText="W/H" />
                                                        <asp:BoundField DataField="Requestedby" HeaderText="Location" />
                                                        <asp:ButtonField ButtonType="Link" CommandName="SelectRequisition" DataTextField="RequestID"
                                                            DataTextFormatString="{0:0000000}" HeaderText="Requisition Number" />
                                                        <asp:BoundField DataField="ReqStatus" HeaderText="Requisition Status" />
                                                        <asp:BoundField DataField="ItemName"  HeaderText="Item Name" ItemStyle-Wrap="False"/>
                                                        <asp:BoundField DataField="ITDSC" HeaderText="Description" />
                                                        <asp:BoundField DataField="UNMSR" HeaderText="UOM" />
                                                        <asp:BoundField DataField="RequiredDate" HeaderText="Required Date" HtmlEncode="False" />
                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"  />
                                                        <asp:BoundField DataField="RequiredSequence" HeaderText="Seq." />
                                                        <asp:BoundField DataField="RequiredTime" HeaderText="Req. Time" HtmlEncode="False" />
                                                        <asp:BoundField DataField="LocationID" HeaderText="Requested To" />
                                                        <asp:BoundField DataField="StatusDescription" HeaderText="Item Status" />
                                                        <asp:BoundField DataField="LASTSUPPLIEDDT" HeaderText="Supplied Date" HtmlEncode="False"/>
                                                        <asp:BoundField DataField="TOTALSUPPLYQTY" HeaderText="Supplied Quantity" HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"/>
                                                    </Columns>
                                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                    <EditRowStyle BackColor="#999999" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                </asp:GridView>
                                                <br />
                                                <asp:Button CssClass="button" ID="btnResultsBack" runat="server" Text="Back" OnClick="btnResultsBack_Click" />
                                                &nbsp;</asp:View>
                                            <asp:View ID="vwRequisitionTransaction" runat="server">
                                                <asp:GridView ID="gvRequisitionTransaction" runat="server" AllowPaging="True" AllowSorting="True"
                                                    AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RequestID" Font-Size="X-Small"
                                                    ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvRequisitionTransaction_PageIndexChanging"
                                                    OnRowCommand="gvRequisitionTransaction_RowCommand" OnRowDataBound="gvRequisitionTransaction_RowDataBound"
                                                    Width="99%">
                                                    <Columns>
                                                        <asp:BoundField DataField="WarehouseToID" HeaderText="W/H" />
                                                        <asp:BoundField DataField="Requestedby" HeaderText="Location" />
                                                        <asp:BoundField DataField="RequestID" HtmlEncode="false" DataFormatString="{0:0000000}"
                                                            HeaderText="Requisition Number" />
                                                        <asp:BoundField DataField="ReqStatus" HeaderText="Requisition Status" />
                                                        <asp:ButtonField ButtonType="Link" CommandName="SelectItem" DataTextField="ItemName"
                                                            HeaderText="Item Name"  ItemStyle-Wrap="False" />
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hfItemName" runat="server" Value='<%# Bind("ItemName") %>' />
                                                                <asp:HiddenField ID="hfRDetailID" runat="server" Value='<%# Bind("RDetailID") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ITDSC" HeaderText="Description" />
                                                        <asp:BoundField DataField="UNMSR" HeaderText="UOM" />
                                                        <asp:BoundField DataField="RequiredDate" HeaderText="Required Date" HtmlEncode="False" />
                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"  />
                                                        <asp:BoundField DataField="RequiredSequence" HeaderText="Seq." />
                                                        <asp:BoundField DataField="RequiredTime" HeaderText="Req. Time" HtmlEncode="False" />
                                                        <asp:BoundField DataField="LocationID" HeaderText="Requested To" />
                                                        <asp:BoundField DataField="StatusDescription" HeaderText="Item Status" />
                                                        <asp:BoundField DataField="LASTSUPPLIEDDT" HeaderText="Supplied Date" HtmlEncode="false"/>
                                                        <asp:BoundField DataField="TOTALSUPPLYQTY" HeaderText="Supplied Quantity" HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"   />
                                                        <asp:BoundField HeaderText="Current Supply" />
                                                    </Columns>
                                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                    <EditRowStyle BackColor="#999999" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                </asp:GridView>
                                                <br />
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Button CssClass="button" Width="160px" ID="btnForceClose" runat="server" Text="Force Close / Re-Open"
                                                                OnClick="btnForceClose_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button CssClass="button" ID="btnRSummaryBack" runat="server" Text="Back" OnClick="btnRSummaryBack_Click" />
                                                            &nbsp;</td>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                        </asp:MultiView></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vwItemTransaction" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table class="SelectionSummary">
                                <tr>
                                    <td>
                                        Supply From Warehouse:</td>
                                    <td>
                                        <asp:Label ID="lblITSFromWarehouse" runat="server"></asp:Label></td>
                                    <td>
                                        Supply To Warehouse:</td>
                                    <td>
                                        <asp:Label ID="lblITSToWarehouse" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Location:</td>
                                    <td>
                                        <asp:Label ID="lblITSFromLocation" runat="server"></asp:Label></td>
                                    <td>
                                        Location:</td>
                                    <td>
                                        <asp:Label ID="lblITSToLocation" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Requisition No.:</td>
                                    <td>
                                        <asp:Label ID="lblITSRequsitionNumber" runat="server"></asp:Label></td>
                                    <td>
                                        Item Number:</td>
                                    <td>
                                        <asp:Label ID="lblITSItemNumber" runat="server"></asp:Label>&nbsp;-&nbsp;
                                        <asp:Label ID="lblITSItemDesc" runat="server"></asp:Label>
                                        <asp:Label ID="lblITHRDetailID" runat="server" Visible="false"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Required Qty.:</td>
                                    <td>
                                        <asp:Label ID="lblITSRequiredQuantity" runat="server"></asp:Label>&nbsp;
                                        <asp:Label ID="lblITSItemUOM" runat="server"></asp:Label></td>
                                    <td>
                                        Required Date:</td>
                                    <td>
                                        <asp:Label ID="lblITSRequiredDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Required Sequence:</td>
                                    <td>
                                        <asp:Label ID="lblITSRequiredSequence" runat="server"></asp:Label></td>
                                    <td>
                                        Required Time:</td>
                                    <td>
                                        <asp:Label ID="lblITSRequiredTime" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkTUAIP" runat="server" Text="Transfer using Alternate Item#" /></td>
                                    <td>
                                        <asp:Label ID="lblAlternateItemName" runat="server"></asp:Label></td>
                                    <td>
                                        </td>
                                    <td>
                                        </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvSupply" Width="99%" runat="server" EmptyDataText="Item Quantity Not Available"
                                CellPadding="4" OnDataBound="gvSupply_DataBound" AutoGenerateColumns="False" AllowSorting="True" ForeColor="#333333"
                                GridLines="None">
                                <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                <Columns>
                                    <asp:BoundField DataField="HOUS01" HeaderText="W/H"></asp:BoundField>
                                    <asp:BoundField DataField="RLLOCN" HeaderText="Location"></asp:BoundField>
                                    <asp:BoundField DataField="ORDN01" HeaderText="PO Number"></asp:BoundField>
                                    <asp:BoundField DataField="RSRVCD" HeaderText="Vendor"></asp:BoundField>
                                    <asp:BoundField DataField="RECD02" HeaderText="Recieved Dt."></asp:BoundField>
                                    <asp:BoundField DataField="RSRDON" HeaderText="Delivery Order No."></asp:BoundField>
                                    <asp:BoundField DataField="PALN01" HeaderText="Pallet Number"></asp:BoundField>
                                    <asp:BoundField HeaderText="Box Number" HtmlEncode="false"></asp:BoundField>
                                    <asp:BoundField DataField="UNIT01" HeaderText="UOM"></asp:BoundField>
                                    <asp:BoundField DataField="RECQ01" HeaderText="Recieved Qty."></asp:BoundField>
                                    <asp:BoundField DataField="TOSQ01" HeaderText="Supplied Qty."></asp:BoundField>
                                    <asp:BoundField DataField="TOBQ01" HeaderText="Balance Inv."></asp:BoundField>
                                    <asp:TemplateField HeaderText="Supply Qty">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtSupply">
                                            </asp:TextBox>
                                            <asp:CompareValidator ID="cvSupplyAty" runat="server" Type="Double" Operator="DataTypeCheck"
                                                ControlToValidate="txtSupply" ErrorMessage="Supply Quantity - Numeric value expected">! </asp:CompareValidator>
                                                <asp:CompareValidator ID="cvSupplyQty" runat="server" Type="Double" Operator="LessThanEqual" ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "TOBQ01")%>' ControlToValidate="txtSupply"
                                                ErrorMessage="Supply Quantity - Cannot be greater!" ValidationGroup="ConfirmSupplyQty">! </asp:CompareValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <RowStyle Font-Size="X-Small" BackColor="#F7F6F3" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle Font-Size="Small" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnSupplyConfirm" CausesValidation="true" ValidationGroup="ConfirmSupplyQty" runat="server" Text="Confirm"
                                OnClick="btnSupplyConfirm_Click" visible="false" />
                            <asp:Button CssClass="button" ID="btnSupplyCancel" runat="server" Text="Back" OnClick="btnSupplyCancel_Click" /></td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vwConfirm" runat="server">
                <div style="text-align: left">
                    <table>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="gvSupplyTray"  runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    Width="100%" ForeColor="#333333" GridLines="None" Font-Size="Small" OnDataBound="gvSupplyTray_DataBound" OnRowDeleting="gvSupplyTray_RowDeleting">
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                    <Columns>
                                    <asp:BoundField DataField="SupplyItemCount" HeaderText="Sno."></asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemName" HeaderText="Item Name"  ItemStyle-Wrap="False"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemDesc" HeaderText="Item Desc"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyQuantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right" ></asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemUOM" HeaderText="UOM"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyDate" HeaderText="Supply Date"></asp:BoundField>
                                        <asp:BoundField DataField="PONumber" HeaderText="PO. Number"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hfRDetailID" runat="server" Value='<%# Bind("RDetailID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:BoundField DataField="DONumber" HeaderText="DO. Number"></asp:BoundField>
                                        <asp:BoundField DataField="PalletNumber" HeaderText="Pallet Number"></asp:BoundField>
                                        <asp:BoundField DataField="BoxNumber" HeaderText="Box Number" ></asp:BoundField>
                                         <asp:ButtonField CommandName="Delete" Text="Delete"></asp:ButtonField>
                                    </Columns>
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <EditRowStyle BackColor="#999999" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button CssClass="button" ID="btnConfirm" runat="server" Text="Post" OnClick="btnPostSupplyTransaction_Click" Visible="false" /><asp:Button
                                    CssClass="button" ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" /></td>
                        </tr>
                    </table>
                </div>
            </asp:View>
            <asp:View ID="vwSuccess" runat="server">
                <asp:Label ID="lblMessage" runat="server"></asp:Label><br />
                <asp:HyperLink ID="hlDeliveryNote" NavigateUrl="" runat="server">Show Delivery Note</asp:HyperLink><br />
                <asp:LinkButton ID="lbReturnToStart" runat="server" OnClick="lbReturnToStart_Click">Supply Another Item</asp:LinkButton>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
