<%@ Page Language="c#" MasterPageFile="~/DefaultMaster.master" Inherits="RequestABPItem"
    CodeFile="RequestABPItem.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center">
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwSearch" runat="server">
                <table cellpadding="2" cellspacing="0" class="clsStd">
                    <tbody>
                        <tr>
                            <th colspan="3">
                                Issue Requisition - Accessory Buy Part Item</th>
                        </tr>
                        <tr>
                            <td align="right">
                                Request from Warehouse Code:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlFromWarehouse" runat="server" DataValueField="Description"
                                    DataTextField="WAREHOUSE" DataSourceID="dsWareHouse" AutoPostBack="True" OnSelectedIndexChanged="ddlFromWarehouse_SelectedIndexChanged"
                                    OnDataBound="ddlFromWarehouse_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="dsWareHouse" runat="server" SelectCommand="select * from vUserWarehouseDesc where (UserName = @USRNAME) ORDER BY WAREHOUSE"
                                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <asp:HiddenField ID="hfUserID" runat="server" />
                            <td align="left">
                                <asp:Label ID="lblWareHousedesc" runat="server" CssClass="description"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Location:</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlFromLocation" runat="server" DataValueField="BLR021" DataTextField="LocationsAccess"
                                    DataSourceID="dsToLocation" AutoPostBack="true" OnSelectedIndexChanged="ddlFromLocation_SelectedIndexChanged"
                                    OnDataBound="ddlFromLocation_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="dsToLocation" runat="server" SelectCommand="select * from vuserlocationdesc WHERE (WareHOUSE  = @WareHOUSE) and  (username = @UsrName)"
                                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlFromWarehouse" Name="WareHOUSE" PropertyName="SelectedItem.Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="hfUserID" Name="UsrName" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblLocationdesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right">
                                Request to Warehouse Code:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlToWarehouse" runat="server" DataValueField="Description"
                                    DataTextField="HOUSE" DataSourceID="dsToWarehouse" AutoPostBack="True" OnSelectedIndexChanged="ddlToWarehouse_SelectedIndexChanged"
                                    OnDataBound="ddlToWarehouse_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="dsToWarehouse" runat="server" SelectCommand="Select * from vWarehouseDesc order by house"
                                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>">
                                </asp:SqlDataSource>
                            </td>
                            <td align="left">
                                &nbsp;<asp:Label ID="lblToWareHouseDesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
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
                                CEP / Pick List Number:</td>
                            <td align="left">
                                <asp:TextBox ID="txtCEPNumber" runat="server"></asp:TextBox></td>
                            <td>
                                &nbsp;<asp:RequiredFieldValidator CssClass="Validation" ID="rfvCEPNumber" ValidationGroup="vgABPReqs"
                                    ControlToValidate="txtCEPNumber" Text="* Pick List Number is required!" runat="server" />
                                    <asp:RegularExpressionValidator runat="server" CssClass="Validation" ControlToValidate="txtCEPNumber" ValidationGroup="vgABPReqs"
                                    ErrorMessage="Please enter a valid Pick List Number" ValidationExpression="^([0-9]{5,7})$"               ID="revCEPNumber" Display="Dynamic"/></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Required Date:</td>
                            <td align="left">
                                <asp:TextBox ID="txtRequiredDateFrom" runat="server" Width="100"></asp:TextBox>&nbsp;
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequiredDateFrom','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink></td>
                            <td>
                                &nbsp;<asp:RequiredFieldValidator Display="Dynamic" CssClass="Validation" ID="rfvReqDateFrom" ValidationGroup="vgABPReqs"
                                    ControlToValidate="txtRequiredDateFrom" Text="* Required Date is required!" runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation" ControlToValidate="txtRequiredDateFrom" ValidationGroup="vgABPReqs"
                                    ErrorMessage="Please enter a valid date" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$"
                                    ID="revReqDate" /></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Required Time:</td>
                            <td align="left">
                                <asp:TextBox ID="txtRqTime" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator Display="Dynamic" CssClass="Validation" ID="rfvRqTime" ValidationGroup="vgABPReqs"
                                    ControlToValidate="txtRqTime" Text="* Required Time is required!" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button CssClass="button" CausesValidation="true" ValidationGroup="vgABPReqs"
                                    ID="btnOK" OnClick="btnOK_Click" runat="server" Text="OK"></asp:Button></td>
                            <td align="left">
                                <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel"></asp:Button></td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left">
                                <asp:ValidationSummary CssClass="Validation" ValidationGroup="vgABPReqs" ID="vsValidRange" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </asp:View>
            <asp:View ID="vwResults" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table class="SelectionSummary">
                                <tr>
                                    <td>
                                        Request from Warehouse:<asp:Label ID="lblResultsRFromWh" runat="server" Text="Label"></asp:Label></td>
                                    <td>
                                    </td>
                                    <td>
                                        Request to Warehouse:<asp:Label ID="lblResultsRToWh" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        Location:<asp:Label ID="lblResultsRFromLoc" runat="server" Text="Label"></asp:Label></td>
                                    <td>
                                    </td>
                                    <td>
                                        Location:<asp:Label ID="lblResultsRToLoc" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        CEP/ Pisk List:<asp:Label ID="lblResultsCEP" runat="server" Text="Label"></asp:Label></td>
                                    <td colspan="3">
                                        <asp:DataList ID="dlPickListData" Width="100%" runat="server" OnItemDataBound="dlPickListData_ItemDataBound">
                                            <HeaderTemplate>
                                                <table width="100%">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        Customer Abbr:</td>
                                                    <td>
                                                        <asp:Label ID="lblResultsCustAbbr" Text='<%# Eval("orderno")%>' runat="server"></asp:Label></td>
                                                    <td>
                                                        Order No.</td>
                                                    <td>
                                                        <asp:Label ID="lblResultsCustOrdNo" Text='<%# Eval("orcusab")%>' runat="server"></asp:Label></td>
                                                    <td>
                                                        Sales Co. Order No:</td>
                                                    <td>
                                                        <asp:Label ID="lblResultsSalesOrdNo" Text='<%# Eval("odcusor")%>' runat="server"></asp:Label></td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvRequirement" Width="99%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" OnRowDataBound="gvRequirement_RowDataBound"
                                EmptyDataText="No Pick List found, please choose another Pick List Number" OnDataBound="gvRequirement_DataBound"
                                Font-Size="Small" OnPageIndexChanging="gvRequirement_PageIndexChanging">
                                <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#5D7B9D"></HeaderStyle>
                                <FooterStyle ForeColor="White" BackColor="#5D7B9D" Font-Bold="True"></FooterStyle>
                                <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                <Columns>
                                    <asp:BoundField DataField="ORITMNO" HeaderText="Item No." SortExpression="ORITMNO" />
                                    <asp:BoundField DataField="ITDSC" HeaderText="Description" SortExpression="ITDSC" />
                                    <asp:BoundField DataField="ORUOMSR" HeaderText="UOM" SortExpression="ORUOMSR" />
                                    <asp:BoundField DataField="ORTOTQT" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}"
                                        ItemStyle-HorizontalAlign="Right" SortExpression="ORTOTQT">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ODETDDT" HtmlEncode="false" HeaderText="ETD Date" SortExpression="ORTOTQT" />
                                    <asp:BoundField HeaderText="Required Date"></asp:BoundField>
                                    <asp:BoundField HtmlEncode="False" DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"
                                        HeaderText="Required Quantity">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Required Sequence"></asp:BoundField>
                                    <asp:BoundField HeaderText="Required Time"></asp:BoundField>
                                    <asp:BoundField DataField="RequestID" HtmlEncode="false" DataFormatString="{0:0000000}"
                                        HeaderText="Requisiton Number"></asp:BoundField>
                                    <asp:BoundField DataField="UserIDName" HeaderText="Requested By"></asp:BoundField>
                                </Columns>
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button CssClass="button" ID="btnConfirm" runat="server" Text="Confirm" OnClick="btnConfirm_Click" /></td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="vwSuccess" runat="server">
                The Transaction is Successful.<asp:Label ID="lblSuccessfulTransactionNumber" runat="server"></asp:Label>
                <br />
                <asp:HyperLink ID="hlRequisitionNote" NavigateUrl="" runat="server">Show Requisition Note</asp:HyperLink><br />
                <asp:LinkButton ID="lbReturnToStart" runat="server" OnClick="lbReturnToStart_Click">Issue Request for Another Pick List</asp:LinkButton>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
