<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemsControl.aspx.cs" Inherits="ItemsControl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Items Picker</title>
        <link href="Css/PMSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body  >
    <form id="form1" runat="server">
            <atlas:ScriptManager ID="ScriptManager1" runat="server" />
    
        <atlas:AutoCompleteExtender ID="AutoCompleteExtenderItemDescription" runat="server">
            <atlas:AutoCompleteProperties Enabled="true"
                 MinimumPrefixLength="1"
                  TargetControlID="txtItemDescription"
                   ServicePath="~/Services/ItemService.asmx"
                    ServiceMethod="FindItemDescription" />
        </atlas:AutoCompleteExtender> 
        <atlas:AutoCompleteExtender ID="AutoCompleteExtenderItemName" runat="server">
            <atlas:AutoCompleteProperties Enabled="true"
                 MinimumPrefixLength="1"
                  TargetControlID="txtItemNumber"
                   ServicePath="~/Services/ItemService.asmx"
                    ServiceMethod="FindItemNumber" />
        </atlas:AutoCompleteExtender> 
       
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <table cellpadding="2" cellspacing="0" width="100%" class="clsStd">
            <tr>
                <th colspan="2">
                    Items Picker</th>
            </tr>
            <tr>
                <td  >
        Enter Item Number:</td>
                <td align="left" >
                    <asp:TextBox ID="txtItemNumber" Width="85%" runat="server"></asp:TextBox>
                    OR</td>
            </tr>
            <tr>
                <td  Width="45%" >
                    Enter Item Description:</td>
                <td  align="left" >
        <asp:TextBox ID="txtItemDescription" Width="85%" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
        <asp:Button ID="btnFetchItems" CssClass="button" runat="server" Width="100px" Text="Search Item" OnClick="btnFetchItems_Click" /></td>
            </tr>
            <tr>
                <td colspan="2">
        <div style="width:100%; height:370px; overflow:auto;">
        <asp:GridView ID="gvItems" Width="100%" runat="server"  AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvItems_SelectedIndexChanged">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ITNBR" HeaderText="Item Number" SortExpression="ITNBR" />
                <asp:BoundField DataField="ITDSC" HeaderText="Description" SortExpression="ITDSC" />
                <asp:BoundField DataField="UNMSR" HeaderText="UOM" SortExpression="ITDSC" />
            </Columns>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView> </div>
                </td>
            </tr>
            <tr>
                <td  >
                </td>
                <td  >
                </td>
            </tr>
        </table>
   
    </form>
</body>
</html>
