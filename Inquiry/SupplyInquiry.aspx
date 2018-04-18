<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DefaultMaster.master"
    CodeFile="SupplyInquiry.aspx.cs" Inherits="ERS_SupplyInquiry" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="contentPlaceHolder1" runat="server">
    <div style="text-align: center">
        <asp:MultiView ID="mvSupplyInquiry" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwSearch" runat="server">
                <table class="clsStd" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <th colspan="3">
                                Supply Inquiry</th>
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
                                Supplied Date From:</td>
                            <td align="left">
                                <asp:TextBox ID="txtSupplyDtFrom" Columns="10" runat="server"></asp:TextBox>
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink1" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtSupplyDtFrom','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator CssClass="Validation" ID="rfvSupplyDtFrom" ValidationGroup="vgReqRange"
                                    ControlToValidate="txtSupplyDtFrom" Text="* Required Date From is required!"
                                    runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                    ControlToValidate="txtSupplyDtFrom" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revSupplyDtFrom" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                To:</td>
                            <td align="left">
                                <asp:TextBox ID="txtSupplyDtTo" Columns="10" runat="server"></asp:TextBox>
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtSupplyDtTo','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator CssClass="Validation" ID="rfvSupplyDtTo" ValidationGroup="vgReqRange"
                                    ControlToValidate="txtSupplyDtTo" Text="* Required Date To is required!" runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                    ControlToValidate="txtSupplyDtTo" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revSupplyDtTo" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button CssClass="button" ID="btnOK" CausesValidation="true" ValidationGroup="vgReqRange"
                                    runat="server" OnClick="btnOK_Click" Text="OK" /></td>
                            <td align="left">
                                <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel" /></td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left">
                                <asp:ValidationSummary ValidationGroup="vgReqRange" ID="vsValidRange" runat="server" />
                                <asp:Label ID="lblErrorMessage" CssClass="Validation" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </asp:View>
            <asp:View ID="vwResults" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table width="100%" class="SelectionSummary">
                                <tr>
                                    <td align="left">
                                        Supply from Warehouse:<asp:Label ID="lblResultsRFromWh" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Supply to Warehouse:<asp:Label ID="lblResultsRToWh" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsRFromLoc" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsRToLoc" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Supplied Date From:<asp:Label ID="lblReqFrom" runat="server"></asp:Label></td>
                                    <td align="left">
                                        To:<asp:Label ID="lblReqTo" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvSupplyInquiry" Width="99%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                ForeColor="#333333" GridLines="None" EmptyDataText="No Supply found in the date range, please search again"
                                AllowPaging="True" AllowSorting="True" OnRowDataBound="gvSupplyInquiry_RowDataBound"
                                OnPageIndexChanging="gvSupplyInquiry_PageIndexChanging" Font-Size="X-Small">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Font-Size="Small" BackColor="#5D7B9D">
                                </HeaderStyle>
                                <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                <FooterStyle ForeColor="White" BackColor="#5D7B9D" Font-Bold="True"></FooterStyle>
                                <Columns>
                                    <asp:BoundField DataField="WareHouseTo" HeaderText="W/H"></asp:BoundField>
                                    <asp:BoundField DataField="LocationTo" HeaderText="Location"></asp:BoundField>
                                    <asp:BoundField DataField="RequestID" HeaderText="Req. #" HtmlEncode="false" DataFormatString="{0:0000000}" />
                                    <asp:BoundField DataField="StatusDescription" HeaderText="Req. Status"></asp:BoundField>
                                    <asp:BoundField DataField="ItemNo" HeaderText="Item Name" ItemStyle-Wrap="False"></asp:BoundField>
                                    <asp:BoundField DataField="ITDSC" HeaderText="Desc"></asp:BoundField>
                                    <asp:BoundField DataField="UNMSR" HeaderText="UOM"></asp:BoundField>
                                    <asp:BoundField DataField="RequiredDate" HtmlEncode="False" HeaderText="Required Date">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Quantity" HtmlEncode="False" DataFormatString="{0:N3}"
                                        ItemStyle-HorizontalAlign="Right" HeaderText="Quantity"></asp:BoundField>
                                    <asp:BoundField DataField="RequiredSequence" HeaderText="Seq."></asp:BoundField>
                                    <asp:BoundField DataField="RequiredTime" HtmlEncode="False" HeaderText="Req. Time"></asp:BoundField>
                                    <asp:BoundField DataField="UserIDName" HeaderText="Requested by"></asp:BoundField>
                                    <asp:BoundField DataField="ItemStatus" HeaderText="Item Status"></asp:BoundField>
                                    <asp:BoundField DataField="SupplyDt" HtmlEncode="False" HeaderText="Supply Dt."></asp:BoundField>
                                    <asp:BoundField DataFormatString="{0:N3}" HtmlEncode="False" DataField="SupplyQuantity"
                                        ItemStyle-HorizontalAlign="Right" HeaderText="Sup. Qty"></asp:BoundField>
                                    <asp:BoundField DataFormatString="{0:N3}" HtmlEncode="False" DataField="Difference"
                                        HeaderText="Diff" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <a href="javascript:window.open('../ERS/DeliveryNote.aspx?DlNo=<%# Eval("SupplyID") %>', null, 'height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes'); void('');">
                                                Show D/Note</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnResultsBack" runat="server" Text="Back" OnClick="btnResultsBack_Click" /></td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
