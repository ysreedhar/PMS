<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" EnableViewState="true"
    CodeFile="ICSupplySC.aspx.cs" Inherits="ERS_SupplySC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center">
        <asp:MultiView ID="mvSupplyWR" ActiveViewIndex="0" runat="server">
            <asp:View ID="vwSearch" runat="server">
                <div style="text-align: left">
                    <table width="100%">
                        <tr>
                            <td>
                                <table width="100%" class="clsStd" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <th colspan="3">
                                            Inventory Control Supply (Sub-Con)</th>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 24px">
                                            Transaction Type:</td>
                                        <td align="left" colspan="2" style="height: 24px">
                                            <asp:RadioButtonList ID="rblTransactionType" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rblTransactionType_SelectedIndexChanged">
                                                <asp:ListItem>Transfer</asp:ListItem>
                                                <asp:ListItem>Sales</asp:ListItem>
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator ID="rfvTransactionType" ControlToValidate="rblTransactionType"
                                                ErrorMessage="Transaction Type" InitialValue="" Text="*" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Supply from Warehouse Code:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlSupplyFromWarehouse" runat="server" DataValueField="Description"
                                                DataTextField="HOUSE" DataSourceID="dsWareHouse" AutoPostBack="True" OnSelectedIndexChanged="ddlSupplyFromWarehouse_SelectedIndexChanged"
                                                OnDataBound="ddlSupplyFromWarehouse_DataBound">
                                            </asp:DropDownList>
                                        </td>
                                        
                                        <td align="left">
                                            &nbsp;<asp:Label ID="lblFromWareHousedesc" runat="server" CssClass="description"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Location:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlSupplyFromLocation" runat="server" DataValueField="BLR021" DataTextField="WHSLC"
                                                DataSourceID="dsFromLocation" AutoPostBack="True" OnSelectedIndexChanged="ddlSupplyFromLocation_SelectedIndexChanged"
                                                >
                                            </asp:DropDownList><asp:SqlDataSource ID="dsFromLocation" runat="server" SelectCommand="SELECT DISTINCT itembl.WHSLC, PIBUDLOC.BLR021 FROM itembl INNER JOIN PIBUDLOC ON itembl.WHSLC = PIBUDLOC.BLR004 WHERE (itembl.HOUSE = @HOUSE) and  (PIBUDLOC.BLR001 = @HOUSE)"
                                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlSupplyFromWarehouse" Name="HOUSE" PropertyName="SelectedItem.Text"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                         <td align="left">
                                            &nbsp;<asp:Label ID="lblLocationdesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Supply to Warehouse Code:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlToWarehouse" runat="server" DataValueField="Description"
                                                DataTextField="HOUSE" DataSourceID="dsWarehouse" AutoPostBack="True" OnSelectedIndexChanged="ddlToWarehouse_SelectedIndexChanged">
                                            </asp:DropDownList><asp:SqlDataSource ID="dsWarehouse" runat="server" SelectCommand="SELECT DISTINCT itembl.HOUSE, tblWarehouseMaster.Description FROM itembl INNER JOIN tblWarehouseMaster ON itembl.HOUSE = tblWarehouseMaster.WarehouseName ORDER BY itembl.HOUSE"
                                                ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblSupplyToWareHouseDesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
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
                                        <td align="left" colspan="3">
                                            <asp:Panel ID="pnlVendorData" Width="100%" Visible="false" runat="server">
                                                <div style="text-align: left">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td align="right">
                                                                Vendor Code:</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtVendorNumber" runat="server"></asp:TextBox>
                                                                <asp:HyperLink ID="hlVendorPicker" runat="server" ImageUrl="~/Images/picker.png"
                                                                    NavigateUrl="javascript:calendar_window=window.open('../../VendorControl.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtVendorNumber&&ctrlDesc=ctl00_ContentPlaceHolder1_lblVendorDescription','LocationPicker','width=450,height=300,left=360,top=180');calendar_window.focus();"></asp:HyperLink>&nbsp;
                                                                <asp:Label ID="lblVendorDescription" CssClass="description" runat="server" Text=" "></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                        </td>
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
                                                ValidationGroup="vgRequired" ControlToValidate="txtTransactionDate" Text="* Transaction Date is required!"
                                                runat="server" />
                                            <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                                ControlToValidate="txtTransactionDate" ValidationGroup="vgRequired" ErrorMessage="Please enter a valid date"
                                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revTransactionDate" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Reference Number:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txtReferenceNumber" runat="server" Width="100"></asp:TextBox>&nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Remarks:</td>
                                        <td colspan="2" align="left">
                                            <asp:TextBox ID="txtRemarks" TextMode="MultiLine" runat="server" Width="90%"></asp:TextBox>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" valign="top" class="SelectionSummary">
                                <table>
                                    <tr>
                                        <td align="left" valign="top">
                                            Supply via Warehouse:<asp:Label ID="lblSupplyViaWH" runat="server"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblSupplyViaWHDesc" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Location:<asp:Label ID="lblSupplyViaLocation" runat="server"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblSupplyViaLocationDesc" runat="server"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:HyperLink ID="hlInsertItems" Visible="false" runat="server">Insert Items</asp:HyperLink></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvSupply" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                ForeColor="#333333" GridLines="None" OnRowCommand="gvSupply_RowCommand" OnDataBound="gvSupply_DataBound" OnRowDeleting="gvSupply_RowDeleting">
                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"  />
                                                <Columns>
                                                    <asp:BoundField DataField="ItemCount" HeaderText="No." />
                                                    <asp:BoundField DataField="SupplyItemName" HeaderText="Item Name" ItemStyle-Wrap="False" />
                                                    <asp:BoundField DataField="SCItemDesc" HeaderText="Description" />
                                                    <asp:BoundField DataField="SCItemUOM" HeaderText="UOM" />
                                                    <asp:BoundField DataField="SupplyQuantity" HeaderText="Quantity" HtmlEncode="False"
                                                        DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hfItemType" runat="server" Value='<%# Bind("SupplyItemType") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:ButtonField CommandName="Delete" Text="Delete" />
                                                </Columns>
                                                <RowStyle BackColor="#EFF3FB" />
                                                <EditRowStyle BackColor="#2461BF" />
                                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <AlternatingRowStyle BackColor="White" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button CssClass="button" ID="btnOK" runat="server" CausesValidation="true" Visible="false" ValidationGroup="vgRequired" OnClick="btnOK_Click" Text="Post" />
                                <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" /></td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <div style="text-align: left">
                    &nbsp;</div>
            </asp:View>
            &nbsp;&nbsp;
            <asp:View ID="vwSuccess" runat="server">
                <asp:Label ID="lblMessage" runat="server"></asp:Label><br />
                <asp:HyperLink ID="hlDeliveryNote" NavigateUrl="" runat="server">Show Delivery Note</asp:HyperLink><br />
                <asp:LinkButton ID="lbReturnToStart" runat="server" OnClick="lbReturnToStart_Click">Supply Another Sub-Con</asp:LinkButton>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
