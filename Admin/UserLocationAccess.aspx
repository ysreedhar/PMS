<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    CodeFile="UserLocationAccess.aspx.cs" Inherits="Admin_UserLocationAccess" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
             <table   cellpadding="2" width="100%" cellspacing="0" class="clsStd">
        <tr>
            <th colspan="3">
                Manage &amp; Assign User - Location Access</th>
        </tr>
        <tr>
            <td align="left" valign="top">
                Users:</td>
            <td  valign="top"  align="left" >
                <asp:ListBox ID="lbUsers" runat="server" CssClass="lb_text" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="lbUsers_SelectedIndexChanged">
                </asp:ListBox></td>
            <td align="left" valign="top" >
                Warehouse:
                <asp:DropDownList ID="ddlWarehouse" runat="server" AutoPostBack="True" DataSourceID="dsWareHouse"
                    DataTextField="HOUSE" DataValueField="Description" OnDataBound="ddlWarehouse_OnDataBound" OnSelectedIndexChanged="ddlWarehouse_SelectedIndexChanged">
                </asp:DropDownList>
                 <asp:Label ID="lblWareHouseDesc" runat="server" CssClass="description"></asp:Label>
                <asp:SqlDataSource ID="dsWareHouse" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" SelectCommand="SELECT DISTINCT itembl.HOUSE, tblWarehouseMaster.Description FROM itembl INNER JOIN tblWarehouseMaster ON itembl.HOUSE = tblWarehouseMaster.WarehouseName ORDER BY itembl.HOUSE">
                </asp:SqlDataSource>
           </td>
        </tr>
        <tr>
            <td align="left" colspan="3" valign="top">
                Select :
                <asp:LinkButton ID="lbSelectAll" runat="server" OnClick="selAll" Text="All"></asp:LinkButton>
                <asp:LinkButton ID="lbSelectNone" runat="server" OnClick="selNone" Text="None"></asp:LinkButton></td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <asp:CheckBoxList ID="chkLocation" CssClass="cbl_text" DataValueField="WHSLC" runat="server" DataTextField="LocName" DataSourceID="dsLocation" RepeatColumns="4" RepeatDirection="Horizontal" OnDataBound="chkLocation_DataBound">
                </asp:CheckBoxList>
                <asp:SqlDataSource ID="dsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" SelectCommand="SELECT DISTINCT itembl.WHSLC, PIBUDLOC.BLR021, (itembl.WHSLC + ' | ' + PIBUDLOC.BLR021) as LocName FROM itembl INNER JOIN PIBUDLOC ON itembl.WHSLC = PIBUDLOC.BLR004 WHERE (itembl.HOUSE = @HOUSE) and  (PIBUDLOC.BLR001 = @HOUSE)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlWarehouse" Name="HOUSE" PropertyName="SelectedItem.Text"
                            Type="String" DefaultValue="1" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <asp:Button CssClass="button"  ID="btnAssign" runat="server" Text="Assign" OnClick="btnAssign_Click" />
                <asp:Button CssClass="button"  ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" /></td>
        </tr>
    </table>
</asp:Content>
