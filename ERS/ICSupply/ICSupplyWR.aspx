<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    CodeFile="ICSupplyWR.aspx.cs" Inherits="ERS_ICSupplyWR" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center">
        <asp:MultiView ID="mvSupplyWR" ActiveViewIndex="0" runat="server">
            <asp:View ID="vwSearch" runat="server">
                <table cellpadding="2" cellspacing="0" class="clsStd">
                    <tr>
                        <th colspan="3">
                            Inventory Control Supply (Without Requisition)</th>
                    </tr>
                    <tr>
                        <td align="right">
                            Transaction Type:</td>
                        <td align="left" colspan="2">
                            <asp:RadioButtonList ID="rblTransactionType" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow">
                                <asp:ListItem Selected="True">Supply</asp:ListItem>
                                <asp:ListItem>Line Return</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td align="right">
                            Supply from Warehouse Code:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlSupplyFromWarehouse" runat="server" DataValueField="Description"
                                DataTextField="WAREHOUSE" DataSourceID="dsWareHouse" AutoPostBack="True" OnSelectedIndexChanged="ddlSupplyFromWarehouse_SelectedIndexChanged"
                                OnDataBound="ddlSupplyFromWarehouse_DataBound">
                            </asp:DropDownList><asp:SqlDataSource ID="dsWareHouse" runat="server" SelectCommand="select * from vUserWarehouseDesc where (UserName = @USRNAME) ORDER BY WAREHOUSE"
                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <asp:HiddenField ID="hfUserID" runat="server" />
                        <td align="left">
                            &nbsp;<asp:Label ID="lblFromWareHousedesc" runat="server" CssClass="description"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right">
                            Location:</td>
                        <td align="left">
                            <asp:DropDownList ID="ddlSupplyFromLocation" runat="server" DataValueField="BLR021"
                                DataTextField="LocationsAccess" DataSourceID="dsToLocation" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlSupplyFromLocation_SelectedIndexChanged" OnDataBound="ddlSupplyFromLocation_DataBound">
                            </asp:DropDownList><asp:SqlDataSource ID="dsToLocation" runat="server" SelectCommand="select * from vuserlocationdesc WHERE (WareHOUSE  = @WareHOUSE) and  (username = @UsrName)"
                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlSupplyFromWarehouse" Name="WareHOUSE" PropertyName="SelectedItem.Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblFromLocationdesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            Supply to Warehouse Code:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlToWarehouse" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                DataValueField="Description" DataTextField="HOUSE" OnDataBound="ddlToWarehouse_DataBound"
                                OnSelectedIndexChanged="ddlToWarehouse_SelectedIndexChanged">
                            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" SelectCommand="SELECT DISTINCT itembl.HOUSE, tblWarehouseMaster.Description FROM itembl INNER JOIN tblWarehouseMaster ON itembl.HOUSE = tblWarehouseMaster.WarehouseName ORDER BY itembl.HOUSE">
                            </asp:SqlDataSource>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblToWarehouseDesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            Location:</td>
                        <td align="left">
                            <asp:DropDownList ID="ddlToLocation" runat="server" DataValueField="BLR021" DataTextField="WHSLC"
                                DataSourceID="SqlDataSource2" AutoPostBack="True" OnSelectedIndexChanged="ddlToLocation_SelectedIndexChanged"
                                OnDataBound="ddlToLocation_DataBound">
                            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="SELECT DISTINCT itembl.WHSLC, PIBUDLOC.BLR021 FROM itembl INNER JOIN PIBUDLOC ON itembl.WHSLC = PIBUDLOC.BLR004 WHERE (itembl.HOUSE = @HOUSE) and  (PIBUDLOC.BLR001 = @HOUSE)"
                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlToWarehouse" Name="HOUSE" PropertyName="SelectedItem.Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td align="left">
                            &nbsp;<asp:Label ID="lblToLocationDesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            PO Number:</td>
                        <td align="left">
                            <asp:TextBox ID="txtPoNumber" runat="server"></asp:TextBox></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            Transaction Date:</td>
                        <td align="left">
                            <asp:TextBox ID="txtTransactionDate" runat="server" Width="100"></asp:TextBox>&nbsp;
                            <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtTransactionDate','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                runat="server"></asp:HyperLink></td>
                        <td>
                            <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvTransactionDate"
                                ValidationGroup="vgReqRange" ControlToValidate="txtTransactionDate" Text="* Transaction Date is required!"
                                runat="server" />
                            <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                ControlToValidate="txtTransactionDate" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revTransactionDate" /></td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button CssClass="button" CausesValidation="true" ValidationGroup="vgReqRange"
                                ID="btnOK" runat="server" OnClick="btnOK_Click" Text="OK" /></td>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel" /></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3" align="left">
                            <asp:ValidationSummary ValidationGroup="vgReqRange" CssClass="Validation" ID="vsValidRange"
                                runat="server" />
                            <asp:Label ID="lblErrorMessage" CssClass="Validation" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vwResults" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table width="100%" class="SelectionSummary">
                                <tr>
                                    <td align="left">
                                        Transaction Type:<asp:Label ID="lblTransactionType" runat="server"></asp:Label></td>
                                    <td align="left">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Supply from Warehouse:<asp:Label ID="lblResultsSFromWh" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Supply to Warehouse:<asp:Label ID="lblResultsSToWh" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsSFromLoc" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsSToLoc" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Transaction Date:<asp:Label ID="lblTransactionDate" runat="server"></asp:Label></td>
                                    <td align="left">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td align="right">
                                                    Item Number:</td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtItemName" Columns="10" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvSupplyItemNo"
                                                        ValidationGroup="vgValidItemNo" ControlToValidate="txtItemName" Text="* Item Number is required!"
                                                        runat="server" />
                                                    <asp:HyperLink ID="hlPickItems" NavigateUrl="javascript:calendar_window=window.open('../../ItemsControl.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtItemName&formname2=aspnetForm.ctl00$ContentPlaceHolder1$hfItemDesc&formname3=aspnetForm.ctl00$ContentPlaceHolder1$hfItemUOM&ctrlDesc=ctl00_ContentPlaceHolder1_lblItemDesc&ctrlUOM=ctl00_ContentPlaceHolder1_lblItemUOM','ItemsPicker','width=500,height=400,left=360,top=180');calendar_window.focus();"
                                                        Text="PICK ITEMS" runat="server" ImageUrl="~/Images/picker.png"></asp:HyperLink>
                                                </td>
                                                <td align="left" class="description">
                                                    <asp:Label ID="lblItemDesc" runat="server"></asp:Label>
                                                    &nbsp;<asp:HiddenField ID="hfItemDesc" runat="server" />
                                                    <asp:HiddenField ID="hfItemUOM" runat="server" />
                                                    <asp:Label ID="lblItemUOM" runat="server"></asp:Label>
                                                    &nbsp;<asp:Button CssClass="button" ID="btnGetInventory" runat="server" OnClick="btnGetInventory_Click"
                                                        CausesValidation="true" ValidationGroup="vgValidItemNo" Text="Get Inventory"
                                                        Width="100px" /></td>
                                            </tr>
                                        </table>
                                        &nbsp;
                                        <asp:CheckBox ID="chkTUAI" runat="server" Text="Transfer Using Alternate Item" /></td>
                                    <td align="left">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvSupply" Width="99%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                EmptyDataText="Item Quantity Not Available" AllowSorting="True" ForeColor="#333333"
                                GridLines="None" OnRowDataBound="gvSupply_RowDataBound" OnDataBound="gvSupply_DataBound">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Font-Size="Small" BackColor="#5D7B9D">
                                </HeaderStyle>
                                <EmptyDataRowStyle Width="100%" Wrap="false" BackColor="LightBlue" Font-Size="Medium"
                                    ForeColor="Red" />
                                <Columns>
                                    <asp:BoundField DataField="HOUS01" HeaderText="W/H"></asp:BoundField>
                                    <asp:BoundField DataField="RLLOCN" HeaderText="Location"></asp:BoundField>
                                    <asp:BoundField DataField="ORDN01" HeaderText="PO Number"></asp:BoundField>
                                    <asp:BoundField DataField="RSRVCD" HeaderText="Vendor"></asp:BoundField>
                                    <asp:BoundField DataField="RECD02" HeaderText="Recieved Dt." HtmlEncode="false"></asp:BoundField>
                                    <asp:BoundField DataField="RSRDON" HeaderText="Delivery Order No."></asp:BoundField>
                                    <asp:BoundField DataField="PALN01" HeaderText="Pallet Number"></asp:BoundField>
                                    <asp:BoundField HeaderText="Box Number"></asp:BoundField>
                                    <asp:BoundField DataField="UNIT01" HeaderText="UOM"></asp:BoundField>
                                    <asp:BoundField DataField="RECQ01" HeaderText="Recieved Qty." HtmlEncode="False"
                                        DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                    <asp:BoundField DataField="TOSQ01" HeaderText="Supplied Qty." HtmlEncode="False"
                                        DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                    <asp:BoundField DataField="TOBQ01" HeaderText="Balance Inv." HtmlEncode="False" DataFormatString="{0:N3}"
                                        ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Supply Qty">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtSupply">
                                            </asp:TextBox>
                                            <asp:CompareValidator ID="cvSupplyAty" runat="server" Type="Double" Operator="DataTypeCheck"
                                                ControlToValidate="txtSupply" ErrorMessage="Supply Quantity - Numeric value expected">! </asp:CompareValidator>
                                            <asp:CompareValidator ID="cvSupplyQty" runat="server" Type="Double" Operator="LessThanEqual"
                                                ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "TOBQ01")%>' ControlToValidate="txtSupply"
                                                ErrorMessage="Supply Quantity - Cannot be greater!" ValidationGroup="ConfirmSupplyQty">! </asp:CompareValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle Font-Size="X-Small" BackColor="#EFF3FB" />
                                <EditRowStyle BackColor="#2461BF" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle Font-Size="Small" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnSupplyConfirm" Visible="false" CausesValidation="true"
                                ValidationGroup="ConfirmSupplyQty" runat="server" Text="Confirm" OnClick="btnSupplyConfirm_Click" />
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
                                <asp:GridView ID="gvSupplyTray" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    EmptyDataText="No Items choosen for Supply" Width="100%" ForeColor="#333333"
                                    GridLines="None" Font-Size="Small" OnDataBound="gvSupplyTray_DataBound" OnRowDeleting="gvSupplyTray_RowDeleting">
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <EmptyDataRowStyle Width="100%" Wrap="false" BackColor="LightBlue" Font-Size="Medium"
                                        ForeColor="Red" />
                                    <Columns>
                                        <asp:BoundField DataField="SupplyItemCount" HeaderText="Sno."></asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemName" HeaderText="Item Name" ItemStyle-Wrap="False">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemDesc" HtmlEncode="false" HeaderText="Item Desc"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyQuantity" HeaderText="Quantity" HtmlEncode="False"
                                            DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyItemUOM" HeaderText="UOM"></asp:BoundField>
                                        <asp:BoundField DataField="SupplyDate" HeaderText="Supply Date"></asp:BoundField>
                                        <asp:BoundField DataField="PONumber" HeaderText="PO. Number"></asp:BoundField>
                                        <asp:BoundField DataField="DONumber" HeaderText="DO. Number"></asp:BoundField>
                                        <asp:BoundField DataField="PalletNumber" HeaderText="Pallet Number"></asp:BoundField>
                                        <asp:BoundField DataField="BoxNumber" HeaderText="Box Number"></asp:BoundField>
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
                                <asp:Button CssClass="button" ID="btnConfirm" runat="server" Text="Post" OnClick="btnConfirm_Click"
                                    Visible="False" />
                                <asp:Button CssClass="button" ID="btnBack" runat="server" Text="Back"
                                        OnClick="btnBack_Click" /></td>
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
