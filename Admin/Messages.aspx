﻿<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    CodeFile="Messages.aspx.cs" Inherits="Admin_Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <table  cellpadding="2" width="100%" cellspacing="0" class="clsStd">
            <tr>
                <th colspan="3">
                  System Messages - Maintainance </th>
            </tr>         
        <tr>
            <td align="left" valign="top">
                <asp:GridView ID="gvMessages" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CellPadding="4" DataSourceID="MessagesSqlDataSource" DataKeyNames="MsgId" ForeColor="#333333"
                    GridLines="None" ShowFooter="True" OnDataBound="gvMessages_DataBound" Width="100%">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="MsgId" HeaderText="ID" />
                        <asp:BoundField DataField="Message_Text" HeaderText="Message" />
                        <asp:BoundField DataField="Postedby" HeaderText="Posted By" />
                        <asp:BoundField DataField="PostedDtTime"  HtmlEncode="False" HeaderText="Date" />
                    </Columns>
                    <RowStyle Font-Size="Small" BackColor="#EFF3FB" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td align="left" valign="top">
                <asp:DetailsView ID="dvMessages" runat="server" AllowPaging="True" AutoGenerateDeleteButton="True"
                    AutoGenerateEditButton="True" AutoGenerateInsertButton="True" AutoGenerateRows="False"
                    CellPadding="4" DataKeyNames="MsgId" DataSourceID="dsDvMessges" Font-Names="Verdana"
                    Font-Size="Small" 
                    ForeColor="#333333" GridLines="None" OnItemUpdated="dvMessages_ItemUpdated" OnItemInserted="dvMessages_ItemInserted" OnItemDeleted="dvMessages_ItemDeleted" Width="100%">
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                    <EditRowStyle BackColor="#2461BF" />
                    <RowStyle BackColor="#EFF3FB" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <Fields>
                        <asp:TemplateField HeaderText="Id" InsertVisible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblMsgId" Text='<%# Eval("MsgId") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Message">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtMessage_Text" TextMode="MultiLine" Text='<%# Bind("Message_Text") %>'
                                    runat="server" Rows="7" Width="200px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvMessage_Text" runat="server" ControlToValidate="txtMessage_Text"
                                    ErrorMessage="Invalid"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMessage_Text" Text='<%# Eval("Message_Text") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditMessage_Text" TextMode="MultiLine" runat="server" Text='<%# Bind("Message_Text") %>' Rows="7" Width="200px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Posted By">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtPostedby" Text='<%# Bind("Postedby") %>' runat="server"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvPostedby" runat="server" ErrorMessage="Invalid"
                                    ControlToValidate="txtPostedby"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPostedby" Text='<%# Eval("Postedby") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPostedby" ReadOnly="true" runat="server" Text='<%# Bind("Postedby") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="20" Mode="NumericFirstLast" />
                    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" valign="top">
                <asp:SqlDataSource ID="MessagesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                    InsertCommand="INSERT INTO tblMessages(Message_Text, Postedby, PostedDtTime) VALUES(@Message_Text, @Postedby, getDate())"
                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" SelectCommand="SELECT * FROM tblMessages"
                    DeleteCommand="DELETE FROM tblMessages WHERE MsgId = @MsgId " UpdateCommand="UPDATE tblMessages SET Message_Text = @Message_Text, Postedby = @Postedby WHERE MsgId = @MsgId">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsDvMessges" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                    InsertCommand="INSERT INTO tblMessages(Message_Text, Postedby, PostedDtTime) VALUES(@Message_Text, @Postedby, getDate())"
                    ProviderName="<%$ ConnectionStrings:PMSdbConnection.ProviderName %>" SelectCommand="SELECT * FROM tblMessages where (MsgID = @MsgID)"
                    DeleteCommand="DELETE FROM tblMessages WHERE MsgId = @MsgId " UpdateCommand="UPDATE tblMessages SET Message_Text = @Message_Text, Postedby = @Postedby WHERE MsgId = @MsgId">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvMessages" Name="MsgID" PropertyName="SelectedValue"
                            Type="Int32" DefaultValue="0" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Button ID="btnAddNew" runat="server" CssClass="button" OnClick="btnAddNew_Click"
                    Text="ADD New System Message" Width="160px" /></td>
        </tr>
    </table>
</asp:Content>
