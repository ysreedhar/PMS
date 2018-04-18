<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubConMD.aspx.cs" Title="Add Sub-Con Items"
    Inherits="ERS_SubConMD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../Css/PMSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table cellpadding="2" cellspacing="0" width="100%" class="clsStd">
                <tr>
                    <th colspan="3">
                        Add Sub-Con Items</th>
                </tr>
                <tr>
                    <td>
                        <asp:Button CssClass="button" Width="160px" Text="Add Mapics Items" ID="btnViewMapicsItems"
                            runat="server" OnClick="btnViewMapicsItems_Click" />
                        <asp:Button CssClass="button" Width="160px" Text="Add Non-Mapics Items" ID="btnViewNonMapicsItems"
                            runat="server" OnClick="btnViewNonMapicsItems_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="mvSMD" ActiveViewIndex="0" runat="server">
                            <asp:View ID="vwItems" runat="server">
                                <table class="asdsa" border="0">
                                    <tr>
                                        <td align="right">
                                            Item Number:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlItems" runat="server" AutoPostBack="true" DataSourceID="dsItems"
                                                DataTextField="ITNBR" DataValueField="ITDSC" OnDataBound="ddlItems_DataBound"
                                                OnSelectedIndexChanged="ddlItems_SelectedIndexChanged">
                                            </asp:DropDownList><asp:SqlDataSource ID="dsItems" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                                                SelectCommand="SELECT [ITNBR], [ITDSC] FROM [vItemWhLoc] WHERE (([WHSLC] = @WHSLC) AND ([HOUSE] = @HOUSE))">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter DefaultValue="42831" Name="WHSLC" QueryStringField="Loc"
                                                        Type="String" />
                                                    <asp:QueryStringParameter DefaultValue="1" Name="HOUSE" QueryStringField="WH" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblItemDescription" runat="server" CssClass="description"></asp:Label>
                                            <asp:Label ID="lblUOM" runat="server" CssClass="description">PC</asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="3">
                                            <asp:CheckBox ID="chkTUAI" runat="server" Text="Transfer Using Alternate Item" AutoPostBack="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="3">
                                            <asp:Label ID="lblAlternateItem" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Quantity:</td>
                                        <td align="left" colspan="2">
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="70px"></asp:TextBox>
                                            <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvQuantity"
                                                ValidationGroup="vgItemQuantity" ControlToValidate="txtQuantity" Text="* Quantity is required!"
                                                runat="server" />
                                            <asp:CompareValidator ID="cvQuantity" runat="server" Type="Double" Operator="DataTypeCheck"
                                                ControlToValidate="txtQuantity" ErrorMessage="Supply Quantity - Numeric value expected"
                                                ValidationGroup="vgItemQuantity">! </asp:CompareValidator>
                                            <asp:Button ID="BtnAddItem" Width="100px" CssClass="button" runat="server" Text="Add Item"
                                                ValidationGroup="vgItemQuantity" CausesValidation="true" OnClick="BtnAddItem_Click" /></td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="vwNMItems" runat="server">
                                <table class="asdasd" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="right">
                                            Item Number:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlNMItems" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                                DataTextField="ItemName" DataValueField="ItemDescription" OnDataBound="ddlItems_DataBound"
                                                OnSelectedIndexChanged="ddlItems_SelectedIndexChanged">
                                            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                                                SelectCommand="SELECT [ItemName], [ItemDescription] FROM [tblNonMapicsItems]"></asp:SqlDataSource>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label2" runat="server" CssClass="description"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Quantity:</td>
                                        <td align="left" colspan="2">
                                            <asp:TextBox ID="txtNMItemQuantity" runat="server" Width="70px"></asp:TextBox>
                                            <asp:RequiredFieldValidator Display="dynamic" CssClass="Validation" ID="rfvNMItemQuantity"
                                                ValidationGroup="vgNMItemQuantity" ControlToValidate="txtNMItemQuantity" Text="* Quantity is required!"
                                                runat="server" />
                                            <asp:CompareValidator ID="cvSupplyAty" runat="server" Type="Double" Operator="DataTypeCheck"
                                                ControlToValidate="txtNMItemQuantity" ErrorMessage="Supply Quantity - Numeric value expected"
                                                ValidationGroup="vgNMItemQuantity">! </asp:CompareValidator>
                                            <asp:Button ID="btnNMItemAdd" CausesValidation="true" ValidationGroup="vgNMItemQuantity"
                                                Width="100px" CssClass="button" runat="server" Text="Add Item" OnClick="btnNMItemAdd_Click" /></td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView></td>
                </tr>
            </table>
        </div>
        <asp:Button ID="Btn_CloseWindow" Width="100px" CssClass="button" OnClientClick="window.close();"
            runat="server" Text="Close Window" />
    </form>
</body>
</html>
