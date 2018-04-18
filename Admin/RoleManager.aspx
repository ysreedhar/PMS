<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DefaultMaster.master"
    CodeFile="RoleManager.aspx.cs" Inherits="RoleManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table  cellpadding="2" width="100%" cellspacing="0" class="clsStd">
            <tr>
                <th colspan="3">
                    Manage Roles</th>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Users :"></asp:Label></td>
                <td style="width: 10px;">
                    &nbsp;</td>
                <td>
                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Roles :"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <asp:ListBox ID="lbUsers" CssClass="lb_text" runat="server" Width="200px" AutoPostBack="True"
                        OnSelectedIndexChanged="lbUsers_SelectedIndexChanged" Height="250px" Rows="10"></asp:ListBox></td>
                <td style="width: 10px;">
                    &nbsp;</td>
                <td align="left" valign="top">
                    <asp:CheckBoxList ID="cblRoles" CssClass="lb_text" runat="server">
                    </asp:CheckBoxList></td>
            </tr>
            <tr>
                <td>
                    <asp:Button CssClass="button" Width="100px" ID="Button1" runat="server" OnClick="Button1_Click"
                        Text="Assign Roles" /></td>
                <td>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
