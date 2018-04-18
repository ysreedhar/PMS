<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorControl.aspx.cs" Inherits="VendorControl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendors Picker</title>
    <link href="Css/PMSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <atlas:ScriptManager ID="ScriptManager1" runat="server" />
        <div style="width: 100%; height: 270px; overflow: auto;">
            <atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server">
                <atlas:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" TargetControlID="txtVendorName"
                    ServicePath="~/Services/VendorService.asmx" ServiceMethod="FindVendorName" />
            </atlas:AutoCompleteExtender>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <table cellpadding="2" cellspacing="0" class="clsStd">
                <tr>
                    <th colspan="3">
                        Vendors Picker</th>
                </tr>
                <tr>
                    <td>
                        Enter Vendor Name:</td>
                    <td>
                        <asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:Button ID="btnFetchVendors" CssClass="button" runat="server" Text="Fetch Vendors" OnClick="btnFetchVendors_Click" /></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView ID="gvVendors" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvVendors_SelectedIndexChanged">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="VNDNR" HeaderText="Number" SortExpression="VNDNR" />
                                <asp:BoundField DataField="VNAME" HeaderText="Vendor" SortExpression="VNAME" />
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
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
