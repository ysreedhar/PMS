<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    CodeFile="RequisitionInquiry.aspx.cs" Inherits="ERS_RequisitionInquiry" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="contentPlaceHolder1" runat="server">
    <div style="text-align: center">
        <asp:MultiView ID="mvRequisitionInquiry" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwSearch" runat="server">
                <table class="clsStd" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <th colspan="3">
                                Requisition Inquiry</th>
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
                                &nbsp;<asp:Label ID="lblWareHousedesc" runat="server" CssClass="description"></asp:Label></td>
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
                                &nbsp;<asp:Label ID="lblLocationdesc" runat="server" CssClass="description"></asp:Label>&nbsp;</td>
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
                                Requested Date From :</td>
                            <td align="left">
                                <asp:TextBox ID="txtRequiredDateFrom" runat="server" Width="100"></asp:TextBox>&nbsp;
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequiredDateFrom','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink></td>
                            <td>
                                <asp:RequiredFieldValidator CssClass="Validation" ID="rfvReqDateFrom" ValidationGroup="vgReqRange"
                                    ControlToValidate="txtRequiredDateFrom" Text="* Required Date From is required!"
                                    runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                    ControlToValidate="txtRequiredDateFrom" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revRequiredDateFrom" /></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Requested Date To :</td>
                            <td align="left">
                                <asp:TextBox ID="txtRequiredDateTo" runat="server" Width="100"></asp:TextBox>&nbsp;
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink1" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequiredDateTo','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink></td>
                            <td>
                                <asp:RequiredFieldValidator CssClass="Validation" ID="rfvRequiredDateTo" ValidationGroup="vgReqRange"
                                    ControlToValidate="txtRequiredDateTo" Text="* Required Date To is required!"
                                    runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                    ControlToValidate="txtRequiredDateTo" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revRequiredDateTo" /></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button CssClass="button" ID="btnOK" CausesValidation="true" ValidationGroup="vgReqRange"
                                    OnClick="btnOK_Click" runat="server" Text="OK"></asp:Button></td>
                            <td align="left">
                                <asp:Button CssClass="button" ID="btnCancel" runat="server" Text="Cancel"></asp:Button></td>
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
                                        Request from Warehouse:<asp:Label ID="lblResultsRFromWh" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Request to Warehouse:<asp:Label ID="lblResultsRToWh" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsRFromLoc" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Location:<asp:Label ID="lblResultsRToLoc" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Requested Date From:<asp:Label ID="lblReqFrom" runat="server"></asp:Label></td>
                                    <td align="left">
                                        To:<asp:Label ID="lblReqTo" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvRequisitionInquiry" Width="99%" runat="server" CellPadding="4"
                                AutoGenerateColumns="False" ForeColor="#333333" GridLines="None" AllowPaging="True"
                                AllowSorting="True" EmptyDataText="No Requisitions found, please search again" DataKeyNames="RequestID" OnRowDataBound="gvRequisitionInquiry_RowDataBound"
                                OnPageIndexChanging="gvRequisitionInquiry_PageIndexChanging" Font-Size="X-Small"
                                OnRowCommand="gvRequisitionInquiry_RowCommand">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Font-Size="Small" BackColor="#5D7B9D">
                                </HeaderStyle>
                                <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                <FooterStyle ForeColor="White" BackColor="#5D7B9D" Font-Bold="True"></FooterStyle>
                                <Columns>
                                    <asp:BoundField DataField="LocationID" HeaderText="Location"></asp:BoundField>
                                    <asp:ButtonField DataTextField="RequestID" HeaderText="Req. No." DataTextFormatString="{0:0000000}"
                                        ButtonType="Link" CommandName="Select" />
                                    <asp:BoundField DataField="ReqStatus" HeaderText="Req. Status" />
                                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" ItemStyle-Wrap="False"></asp:BoundField>
                                    <asp:BoundField DataField="ITDSC" HeaderText="Description"></asp:BoundField>
                                    <asp:BoundField DataField="UNMSR" HeaderText="UOM"></asp:BoundField>
                                    <asp:BoundField DataField="RequiredDate" HtmlEncode="False" HeaderText="Required Date">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}"
                                        ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                    <asp:BoundField DataField="RequiredSequence" HeaderText="Seq."></asp:BoundField>
                                    <asp:BoundField DataField="RequiredTime" HtmlEncode="False" HeaderText="Req. Time"></asp:BoundField>
                                    <asp:BoundField DataField="Requestedby" HeaderText="Requested by"></asp:BoundField>
                                    <asp:BoundField DataField="StatusDescription" HeaderText="Status"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <a href="javascript:window.open('../ERS/RequisitionNote.aspx?RqNo=<%# Eval("RequestID") %>', null, 'height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes'); void('');">
                                                Show R/Note</a>
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
            <asp:View ID="vwModifyRequisition" runat="server">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <table width="100%" class="SelectionSummary">
                                <tr>
                                    <td align="left">
                                        Request from Warehouse:<asp:Label ID="lblvmrRFromWh" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Request to Warehouse:<asp:Label ID="lblvmrRToWh" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Location:<asp:Label ID="lblvmrRFromLoc" runat="server"></asp:Label></td>
                                    <td align="left">
                                        Location:<asp:Label ID="lblvmrRToLoc" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Requested Date From:<asp:Label ID="lblvmrReqDateFrom" runat="server"></asp:Label></td>
                                    <td align="left">
                                        To:<asp:Label ID="lblvmrReqDateTo" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvReqDetails" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RDetailID" DataSourceID="SqlDataSource1"
                                EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
                                OnDataBound="gvReqDetails_DataBound" OnRowDataBound="gvReqDetails_RowDataBound">
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                    <asp:BoundField DataField="RDetailID" InsertVisible="false" HeaderText="ID" />
                                    <asp:BoundField DataField="ItemName" HeaderText="Item" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}"
                                        ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="RequiredDate" HeaderText="Req. Date" HtmlEncode="False" />
                                    <asp:BoundField DataField="RequiredTime" HeaderText="Req. Time" HtmlEncode="false" />
                                    <asp:BoundField DataField="RequiredSequence" HeaderText="Req. Seq." />
                                </Columns>
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
                                ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>" DeleteCommand="DELETE FROM [tblRequestDetails] WHERE [RDetailID] = @original_RDetailID AND [ItemName] = @original_ItemName AND [Quantity] = @original_Quantity AND [RequiredDate] = @original_RequiredDate AND [RequiredTime] = @original_RequiredTime AND [RequiredSequence] = @original_RequiredSequence"
                                InsertCommand="INSERT INTO [tblRequestDetails] ([ItemName], [Quantity], [RequiredDate], [RequiredTime], [RequiredSequence]) VALUES (@ItemName, @Quantity, @RequiredDate, @RequiredTime, @RequiredSequence)"
                                OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>"
                                SelectCommand="SELECT [ItemName], [Quantity], [RequiredDate], [RequiredTime], [RequiredSequence], [RDetailID] FROM [tblRequestDetails] WHERE ([RequestID] = @RequestID)"
                                UpdateCommand="UPDATE [tblRequestDetails] SET [ItemName] = @ItemName, [Quantity] = @Quantity, [RequiredDate] = @RequiredDate, [RequiredTime] = @RequiredTime, [RequiredSequence] = @RequiredSequence WHERE [RDetailID] = @original_RDetailID AND [ItemName] = @original_ItemName AND [Quantity] = @original_Quantity AND [RequiredDate] = @original_RequiredDate AND [RequiredTime] = @original_RequiredTime AND [RequiredSequence] = @original_RequiredSequence">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_RDetailID" Type="Decimal" />
                                    <asp:Parameter Name="original_ItemName" Type="String" />
                                    <asp:Parameter Name="original_Quantity" Type="Decimal" />
                                    <asp:Parameter Name="original_RequiredDate" Type="DateTime" />
                                    <asp:Parameter Name="original_RequiredTime" Type="String" />
                                    <asp:Parameter Name="original_RequiredSequence" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ItemName" Type="String" />
                                    <asp:Parameter Name="Quantity" Type="Decimal" />
                                    <asp:Parameter Name="RequiredDate" Type="DateTime" />
                                    <asp:Parameter Name="RequiredTime" Type="String" />
                                    <asp:Parameter Name="RequiredSequence" Type="Int32" />
                                    <asp:Parameter Name="original_RDetailID" Type="Decimal" />
                                    <asp:Parameter Name="original_ItemName" Type="String" />
                                    <asp:Parameter Name="original_Quantity" Type="Decimal" />
                                    <asp:Parameter Name="original_RequiredDate" Type="DateTime" />
                                    <asp:Parameter Name="original_RequiredTime" Type="String" />
                                    <asp:Parameter Name="original_RequiredSequence" Type="Int32" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:ControlParameter PropertyName="SelectedValue" ControlID="gvRequisitionInquiry"
                                        Name="RequestID" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ItemName" Type="String" />
                                    <asp:Parameter Name="Quantity" Type="Decimal" />
                                    <asp:Parameter Name="RequiredDate" Type="DateTime" />
                                    <asp:Parameter Name="RequiredTime" Type="String" />
                                    <asp:Parameter Name="RequiredSequence" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnMRBack" runat="server" Text="Back" OnClick="btnMRBack_Click" /></td>
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
