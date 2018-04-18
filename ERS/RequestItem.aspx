<%@ Page Language="c#" MasterPageFile="~/DefaultMaster.master" Inherits="RequestItem"
    CodeFile="RequestItem.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center">
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwSearch" runat="server">
                <table cellpadding="2" cellspacing="0" class="clsStd">
                    <tbody>
                        <tr>
                            <th colspan="3">
                                Issue Requisition
                            </th>
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
                                    DataTextField="HOUSE" DataSourceID="SqlDataSource1" AutoPostBack="True" OnSelectedIndexChanged="ddlToWarehouse_SelectedIndexChanged"
                                    OnDataBound="ddlToWarehouse_DataBound">
                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SELECT DISTINCT itembl.HOUSE, tblWarehouseMaster.Description FROM itembl INNER JOIN tblWarehouseMaster ON itembl.HOUSE = tblWarehouseMaster.WarehouseName ORDER BY itembl.HOUSE"
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
                                Required Date From:</td>
                            <td align="left">
                                <asp:TextBox ID="txtRequiredDateFrom" runat="server" Width="100" OnTextChanged="txtRequiredDateFrom_TextChanged"></asp:TextBox>&nbsp;
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink2" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequiredDateFrom','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink></td>
                            <td align="left">
                                <asp:Label ID="lblRequiredFromWeekDay" runat="server" CssClass="description"></asp:Label></td>
                            &nbsp;<asp:RequiredFieldValidator CssClass="Validation" ID="rfvReqDateFrom" ValidationGroup="vgReqRange"
                                ControlToValidate="txtRequiredDateFrom" Text="* Required Date From is required!"
                                runat="server" />
                          <!--  <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                ControlToValidate="txtRequiredDateFrom" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revRequiredDateFrom" />-->
                        </tr>
                        <tr>
                            <td align="right">
                                Required Date To:</td>
                            <td align="left">
                                <asp:TextBox ID="txtRequiredDateTo" runat="server" Width="100" OnTextChanged="txtRequiredDateTo_TextChanged"></asp:TextBox>&nbsp;
                                <asp:HyperLink ImageUrl="~/Images/Calender.gif" ID="HyperLink1" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtRequiredDateTo','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                    runat="server"></asp:HyperLink></td>
                            <td align="left">
                                <asp:Label ID="lblRequiredToWeekDay" runat="server" CssClass="description"></asp:Label></td>
                            &nbsp;
                          <!--  <asp:RegularExpressionValidator Display="Dynamic" runat="server" CssClass="Validation"
                                ControlToValidate="txtRequiredDateTo" ValidationGroup="vgReqRange" ErrorMessage="Please enter a valid date"
                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{4}$" ID="revRequiredDateTo" />-->
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnOK" CssClass="button" CausesValidation="true" ValidationGroup="vgReqRange"
                                    OnClick="btnOK_Click" runat="server" Text="OK"></asp:Button></td>
                            <td align="left">
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="button"></asp:Button></td>
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
                                        Requirement Date From:<asp:Label ID="lblReqFrom" runat="server"></asp:Label></td>
                                    <td align="left">
                                        To:<asp:Label ID="lblReqTo" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:GridView ID="gvRequirement" OnDataBound="gvRequirement_DataBound" Width="99%"
                                runat="server" CellPadding="4" EmptyDataText="No Requirement found, please click on “Next” to manually insert record."
                                AutoGenerateColumns="False" ForeColor="#333333" GridLines="None" AllowPaging="True"
                                AllowSorting="True" OnRowDataBound="gvRequirement_RowDataBound" OnPageIndexChanging="gvRequirement_PageIndexChanging"
                                ShowFooter="True" Font-Size="X-Small" OnSorting="gvRequirement_Sorting">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Font-Size="Small" BackColor="#5D7B9D">
                                </HeaderStyle>
                                <EmptyDataRowStyle BackColor="LightBlue" Font-Size="Medium" ForeColor="Red" />
                                <FooterStyle ForeColor="White" BackColor="#5D7B9D" Font-Bold="True"></FooterStyle>
                                <Columns>
                                    <asp:BoundField SortExpression="ITEMNO" DataField="ITEMNO" ItemStyle-Wrap="False"
                                        HeaderText="Item Name"></asp:BoundField>
                                    <asp:BoundField SortExpression="ITDSC" DataField="ITDSC" HeaderText="Description"></asp:BoundField>
                                    <asp:BoundField DataField="UNMSR" HeaderText="UOM"></asp:BoundField>
                                    <asp:BoundField SortExpression="ReqDate" DataField="ReqDate" HtmlEncode="False" HeaderText="Required Date">
                                    </asp:BoundField>
                                    <asp:BoundField DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right" DataField="ReqQuantity"
                                        HtmlEncode="False" HeaderText="Req. Quantity">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right" DataField="Quantity"
                                        HtmlEncode="false" HeaderText="Inv. at Requestor">
                                        <ItemStyle HorizontalAlign="Right" Wrap="True" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ItmTmplQtyText" runat="server" Columns="3"></asp:TextBox>
                                            <asp:CompareValidator ID="cvItemQty" runat="server" ControlToValidate="ItmTmplQtyText"
                                                Type="Integer" Operator="GreaterThan" ValueToCompare="0" ErrorMessage="!"></asp:CompareValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Request Date">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ItmTmplRDtText" runat="server" Columns="6"></asp:TextBox>
                                            <asp:HyperLink ID="lbtnCalendar" runat="server" ImageUrl="~/images/Calender.gif"></asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Req. Time">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ItmTmplRTmText" runat="server" Columns="3"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Seq.">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ItmTmplRSeqText" runat="server" Columns="3"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="RequestID" DataFormatString="{0:0000000}" HeaderText="Requisition No."
                                        HtmlEncode="False" />
                                    <asp:BoundField DataField="UserIDName" HeaderText="Requested By"></asp:BoundField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#284775"></PagerStyle>
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <EditRowStyle BackColor="#999999" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="btnReqConfirm" runat="server" Text="Next" OnClick="btnReqConfirm_Click" />
                            <asp:Button CssClass="button" ID="btnReqCancel" runat="server" Text="Back" OnClick="btnReqCancel_Click" /></td>
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
                                <asp:GridView ID="gvTray" OnDataBound="gvTray_DataBound" runat="server" AutoGenerateColumns="False"
                                    CellPadding="4" Width="100%" ForeColor="#333333" GridLines="None" Font-Size="Small"
                                    OnRowDeleting="gvTray_RowDeleting">
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <Columns>
                                        <asp:BoundField DataField="ReqItemCount" HeaderText="Sno."></asp:BoundField>
                                        <asp:BoundField DataField="itemname" ItemStyle-Wrap="False" HeaderText="Item Name"></asp:BoundField>
                                        <asp:BoundField DataField="ItemDesc" HeaderText="Desc"></asp:BoundField>
                                        <asp:BoundField DataField="ItemUOM" HeaderText="UOM"></asp:BoundField>
                                        <asp:BoundField DataField="ReqDate" HeaderText="Required Dt."></asp:BoundField>
                                        <asp:BoundField DataField="ReqQuantity" HeaderText="Req. Qty" HtmlEncode="False"
                                            DataFormatString="{0:N3}" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                        <asp:BoundField DataField="InvAtRequestor" HeaderText="Inv. At Requestor"></asp:BoundField>
                                        <asp:BoundField DataField="quantity" HeaderText="Quantity" HtmlEncode="False" DataFormatString="{0:N3}"
                                            ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                                        <asp:BoundField DataField="RequiredDate" HtmlEncode="False" HeaderText="Req. Date"></asp:BoundField>
                                        <asp:BoundField DataField="RequiredTime" HeaderText="Req. Time"></asp:BoundField>
                                        <asp:BoundField DataField="RequiredSeq" HeaderText="Seq."></asp:BoundField>
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
                                <table class="clsStd" cellpadding="0" cellspacing="0" width="500px">
                                    <tr>
                                        <th colspan="2">
                                            Insert Additional Items</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            Item:</td>
                                        <td>
                                            <asp:TextBox ID="txtInsertNewItem" Columns="10" runat="server"></asp:TextBox>
                                            <asp:HyperLink ID="hlPickItems" NavigateUrl="javascript:calendar_window=window.open('../ItemsControl.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtInsertNewItem&formname2=aspnetForm.ctl00$ContentPlaceHolder1$hfItemDesc&formname3=aspnetForm.ctl00$ContentPlaceHolder1$hfItemUOM&ctrlDesc=ctl00_ContentPlaceHolder1_lblItemDesc&ctrlUOM=ctl00_ContentPlaceHolder1_lblItemUOM','ItemsPicker','width=500,height=400,left=360,top=180');calendar_window.focus();"
                                                runat="server" ImageUrl="~/Images/picker.png"></asp:HyperLink>
                                            <asp:RequiredFieldValidator CssClass="Validation" ID="rfvInsertNewItem" ValidationGroup="vgInsertNewItem"
                                                ControlToValidate="txtInsertNewItem" Text="The Item Name is required!" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="description">
                                            <asp:Label ID="lblItemDesc" runat="server"></asp:Label>
                                            &nbsp;<asp:HiddenField ID="hfItemDesc" runat="server" />
                                            <asp:HiddenField ID="hfItemUOM" runat="server" />
                                            <asp:Label ID="lblItemUOM" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Quantity</td>
                                        <td>
                                            <asp:TextBox ID="txtInsertNewItemQuantity" Columns="6" runat="server" Text=""></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="Validation" ID="rfvInsertNewItemQuantity" ControlToValidate="txtInsertNewItemQuantity"
                                                Text="Quantity is required!" runat="server" ValidationGroup="vgInsertNewItem" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Date:</td>
                                        <td>
                                            <asp:TextBox ID="txtInsertNewItemDt" Columns="6" runat="server" Text=""></asp:TextBox>
                                            <asp:HyperLink ID="lbtnItemDtCalender" NavigateUrl="javascript:calendar_window=window.open('../DGCal.aspx?formname=aspnetForm.ctl00$ContentPlaceHolder1$txtInsertNewItemDt','DatePicker','width=250,height=190,left=360,top=180');calendar_window.focus();"
                                                runat="server" ImageUrl="~/images/Calender.gif"></asp:HyperLink>
                                            <asp:RequiredFieldValidator CssClass="Validation" ID="rfvInsertNewItemDt" ValidationGroup="vgInsertNewItem"
                                                ControlToValidate="txtInsertNewItemDt" Text="Date is required!" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Time:</td>
                                        <td>
                                            <asp:TextBox ID="txtInsertNewItemTm" Columns="6" runat="server" Text=""></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Sequence:</td>
                                        <td>
                                            <asp:TextBox ID="txtInsertNewItemSeq" Columns="6" runat="server" Text=""></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="AddReqItem" CausesValidation="true" ValidationGroup="vgInsertNewItem"
                                                runat="server" Text="Add" CssClass="button" OnClick="AddReqItem_Click" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnConfirm" CssClass="button" Width="150px" runat="server" Text="Confirm and Send"
                                    OnClick="btnConfirm_Click" Visible="false" />&nbsp;<asp:Button ID="btnBack" CssClass="button"
                                        runat="server" Text="Back" OnClick="btnBack_Click" /></td>
                        </tr>
                    </table>
                </div>
            </asp:View>
            <asp:View ID="vwSuccess" runat="server">
                The Transaction is Successful.<asp:Label ID="lblSuccessfulTransactionNumber" runat="server"></asp:Label>
                <br />
                <asp:HyperLink ID="hlRequisitionNote" NavigateUrl="" runat="server">Show Requisition Note</asp:HyperLink><br />
                <asp:LinkButton ID="lbReturnToStart" runat="server" OnClick="lbReturnToStart_Click">Issue Request for Requirement</asp:LinkButton>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
