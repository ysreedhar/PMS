<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DefaultMaster.master"
    CodeFile="MshipMgmt.aspx.cs" Inherits="MshipMgmt" Title="Membership Manager" %>

<asp:Content ID="Content1" runat="Server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table cellpadding="2" width="100%" cellspacing="0" class="clsStd">
        <tr>
            <th colspan="3">
                User Management</th>
        </tr>
        <tr><table width="100%"><tr>
            <td>
                <asp:GridView ID="GridViewMemberUser" runat="server" OnSelectedIndexChanged="GridViewMembershipUser_SelectedIndexChanged"
                    OnRowDeleted="GridViewMembership_RowDeleted" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="UserName" DataSourceID="ObjectDataSourceMembershipUser" AllowSorting="True"
                    CellPadding="4" Font-Size="X-Small" Width="100%" ForeColor="#333333" GridLines="None">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" ReadOnly="True"
                            SortExpression="CreationDate">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LastLockoutDate" Visible="False" HeaderText="LastLockoutDate"
                            ReadOnly="True" SortExpression="LastLockoutDate" />
                        <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" SortExpression="LastLoginDate" ReadOnly="True" />
                        <asp:CheckBoxField DataField="IsOnline" Visible="False" HeaderText="IsOnline" ReadOnly="True"
                            SortExpression="IsOnline" />
                        <asp:CheckBoxField DataField="isApproved" HeaderText="isApproved" 
                            SortExpression="isApproved" Visible="true" />
                        <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate"
                            Visible="True" ReadOnly="true" />
                        <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="LastPasswordChangedDate"
                            Visible="False" ReadOnly="True" SortExpression="LastPasswordChangedDate" />
                        <asp:BoundField DataField="ProviderName" HeaderText="ProviderName" ReadOnly="True"
                            Visible="False" SortExpression="ProviderName" />
                    </Columns>
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSourceMembershipUser" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" SelectMethod="GetMembers" TypeName="MembershipUserODS"
                    UpdateMethod="Update" SortParameterName="SortData" OnInserted="ObjectDataSourceMembershipUser_Inserted">
                    <DeleteParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="email" Type="String" />
                        <asp:Parameter Name="isApproved" Type="Boolean" />
                        <asp:Parameter Name="comment" Type="String" />
                        <asp:Parameter Name="lastActivityDate" Type="DateTime" />
                        <asp:Parameter Name="lastLoginDate" Type="DateTime" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:Parameter Name="sortData" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="userName" Type="String" />
                        <asp:Parameter Name="isApproved" Type="Boolean" />
                        <asp:Parameter Name="comment" Type="String" />
                        <asp:Parameter Name="lastLockoutDate" Type="DateTime" />
                        <asp:Parameter Name="creationDate" Type="DateTime" />
                        <asp:Parameter Name="email" Type="String" />
                        <asp:Parameter Name="lastActivityDate" Type="DateTime" />
                        <asp:Parameter Name="providerName" Type="String" />
                        <asp:Parameter Name="isLockedOut" Type="Boolean" />
                        <asp:Parameter Name="lastLoginDate" Type="DateTime" />
                        <asp:Parameter Name="isOnline" Type="Boolean" />
                        <asp:Parameter Name="passwordQuestion" Type="String" />
                        <asp:Parameter Name="lastPasswordChangedDate" Type="DateTime" />
                        <asp:Parameter Name="password" Type="String" />
                        <asp:Parameter Name="passwordAnswer" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <br />
                <br />
            </td>
        </tr>
    </table>
    <table style="font-weight: normal; font-size: 12px; font-family: Tahoma" bgcolor="white"
        width="100%" border="0" cellpadding="1" cellspacing="2">
        <tr valign="top">
            <td align="center" width="60%">
                <b>Management of roles</b><br />
                <br />
                <asp:GridView ID="GridViewRole" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSourceRoleObject"
                    DataKeyNames="RoleName" CellPadding="3" CellSpacing="3" AllowPaging="True" HorizontalAlign="Center"
                    Width="100%">
                    <Columns>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button CssClass="button" ID="Button1" runat="server" CausesValidation="false"
                                    Width="350px" OnClick="ToggleInRole_Click"  Text='<%# ShowInRoleStatus( (string) Eval("UserName"),(string) Eval("RoleName")) %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderTemplate>
                                Status of roles for selected user
                            </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NumberOfUsersInRole" HeaderText="Number Of Users In Role"
                            SortExpression="NumberOfUsersInRole" />
                        <asp:BoundField DataField="RoleName" ReadOnly="True" Visible="False" HeaderText="RoleName"
                            SortExpression="RoleName" />
                        <asp:CheckBoxField DataField="UserInRole" HeaderText="UserInRole" Visible="False"
                            SortExpression="UserInRole" />
                    </Columns>
                </asp:GridView>
                <asp:CheckBox ID="CheckBoxShowRolesAssigned" runat="server" AutoPostBack="True" Text="Show Roles Assigned Only" />
            </td>
            <td align="center" colspan="2" width="40%"  >
                <b>Creation of new user</b><br />
                <br />
                <table cellpadding="2" cellspacing="2">
                    <tr>
                        <td style="height: 28px" align="left">
                            <asp:Label ID="Label3" Text="UserName" runat="server"></asp:Label>
                        </td>
                        <td style="height: 28px" align="left">
                            <asp:TextBox ID="TextBoxUserName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 28px" align="left">
                            <asp:Label ID="Label4" Text="Password" runat="server"></asp:Label>
                        </td>
                        <td style="height: 28px" align="left">
                            <asp:TextBox ID="TextBoxPassword" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label5" Text="PasswordQuestion" runat="server" Visible="False"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="TextBoxPasswordQuestion" runat="server" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label6" Text="PasswordAnswer" runat="server" Visible="False"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="TextBoxPasswordAnswer" runat="server" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label2" Text="Email" runat="server"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="TextBoxEmail" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label9" Text="Enable" runat="server"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:CheckBox ID="CheckboxApproval" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button CssClass="button" ID="ButtonNewUser" runat="server" Text="Create New User"
                                OnClick="ButtonNewUser_Click" Width="120px" />
                        </td>
                    </tr>
                </table>
                <asp:Label ID="LabelInsertMessage" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table style="font-weight: normal; font-size: 12px; font-family: Tahoma" border="0"
        cellpadding="1" cellspacing="2" bgcolor="white" width="100%">
        <tr>
            <td align="center">
            </td>
        </tr>
    </table>
    <br />
    <asp:ObjectDataSource ID="ObjectDataSourceRoleObject" runat="server" SelectMethod="GetRoles"
        TypeName="RoleDataObject" InsertMethod="Insert" DeleteMethod="Delete">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridViewMemberUser" Name="UserName" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="CheckBoxShowRolesAssigned" Name="ShowOnlyAssignedRolls"
                PropertyName="Checked" Type="Boolean" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RoleName" Type="String" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="RoleName" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</tr></table>
</asp:Content>
