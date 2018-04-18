<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tryst.aspx.cs" MasterPageFile="~/DefaultMaster.master"
    Inherits="tryst" %>



<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server" ID="Content1">
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br />
    <asp:HyperLink ID="HyperLink1" NavigateUrl="javascript:calendar_window=window.open('TestPicker.aspx?formname=aspnetForm.ctl00_ContentPlaceHolder1_lblUpdate','ItemsPicker','width=500,height=400,left=360,top=180');calendar_window.focus();"
        runat="server">PICK ITEM</asp:HyperLink>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" /><br />
    <table cellpadding="2"  cellspacing="0" class="clsStd">
        <tr>
            <th colspan="3">
                asdasdsa
            </th>
        </tr>
        <tr>
            <td>
                dsfdsfsdf
            </td>
            <td>
                sadasdasd
            </td>
            <td>
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
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <br />
    <asp:Label ID="lblUpdate" runat="server" Text="Label"></asp:Label>
</asp:Content>
