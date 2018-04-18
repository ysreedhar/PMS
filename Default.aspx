<%@ Page Language="C#" Title="Production Management System" MasterPageFile="~/DefaultMaster.master"
    AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0" cellpadding="0" cellspacing="0"  style="width: 100%; height: 100%">
            <tr>
                <td align="left" valign="top" style="width: 70%">&nbsp;
                </td>
                <td align="left" valign="top" style="width: 30%">
                    <asp:Repeater ID="rptrMsgs" runat="server">
                        <HeaderTemplate>
                            <table class="clsStd" cellpadding="0" cellspacing="0" style="font: 10pt verdana">
                                <tr >
                                    <th colspan="2">System Messages
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr  >
                                <td>
                                    <%# CommonFunctions.ConvertStrToAppDateFormat(DataBinder.Eval(Container.DataItem, "PostedDtTime").ToString()) %>
                                </td>
                                <td >
                                    <%# DataBinder.Eval(Container.DataItem, "PostedBy")%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="color:Red;">
                                    <%# DataBinder.Eval(Container.DataItem, "Message_Text")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
        </table>

</asp:Content>
