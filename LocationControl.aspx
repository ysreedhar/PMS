<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocationControl.aspx.cs" Inherits="LocationControl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Location Picker</title>
        <link href="Css/PMSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body  >
    <form id="form1" runat="server">
            <atlas:ScriptManager ID="ScriptManager1" runat="server" />
    <div style="width:100%; height:270px; overflow:auto;">
        <atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server">
            <atlas:AutoCompleteProperties Enabled="true"
                 MinimumPrefixLength="1"
                  TargetControlID="txtLocationDescription"
                   ServicePath="~/Services/LocationService.asmx"
                    ServiceMethod="FindLocationNames" />
        </atlas:AutoCompleteExtender> 
       
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <table cellpadding="2" cellspacing="0" class="clsStd">
            <tr>
                <th colspan="3">
                    Location Picker</th>
            </tr>
            <tr>
                <td  >
        Enter Location Name:</td>
                <td  >
        <asp:TextBox ID="txtLocationDescription" runat="server"></asp:TextBox></td>
                <td  >
        <asp:Button ID="btnFetchLocations" runat="server" Text="Fetch Location" OnClick="btnFetchLocations_Click" /></td>
            </tr>
            <tr>
                <td colspan="3">
        <asp:GridView ID="gvLocations" runat="server"  AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvLocations_SelectedIndexChanged">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="WHSLC" HeaderText="Location" SortExpression="ITNBR" />
                <asp:BoundField DataField="BLR021" HeaderText="Description" SortExpression="ITDSC" />
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
                <td  >
                </td>
                <td  >
                </td>
                <td  >
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
