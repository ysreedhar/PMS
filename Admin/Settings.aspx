<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" CodeFile="Settings.aspx.cs" validateRequest="false"  Inherits="Settings_aspx" Title="Site Settings" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="body">
        <div id="col_main_left">
            <div id="user_assistance">
                <a id="content_start"></a>
                <h3>
                    Actions</h3>
                <p>
                    <asp:HyperLink ID="BackToAdminLink" runat="server" NavigateUrl="~/Admin/Admin_Default.aspx">back to Administration</asp:HyperLink>&nbsp;</p>
                <asp:Panel ID="UpdateErrorPanel" runat="server" Visible="False" EnableViewState="False">
                    <p>
                        <strong>There was an error writing to the Settings file<br />
                            App_Data\site-config.xml.</strong><br />
                        Please make sure that the ASP.NET process has write-access to the file.</p>
                    <p>
                        The textbox below contains the XML equivalent of the Site Settings you saved. You
                        can copy it and update the file manually.</p>
                    <asp:TextBox ID="SettingsXmlTextBox" runat="server" TextMode="multiLine" Rows="20"
                        Width="100%"></asp:TextBox>
                </asp:Panel>
            </div>
        </div>
        <div id="col_main_right">
            <h2 class="section">
                Site Settings</h2>
            <div class="content_right">
                <fieldset>
                    <asp:FormView ID="SettingsFormView" runat="server" DataSourceID="SettingsDataSource"
                        DefaultMode="Edit">
                        <EditItemTemplate>
                            <legend>Application is Online:</legend>
                            <asp:CheckBox Checked='<%# Bind("SiteIsOnline") %>' runat="server" ID="chkSiteIsOnline"
                                Text="Yes" />
                            <p class="new_section">
                            </p>
                            <legend>Implement Alternate Item Transfer Policy:</legend>
                            <asp:CheckBox Checked='<%# Bind("ImplementsTUAIP") %>' runat="server" ID="chkImplementsTUAIP"
                                Text="Yes" />
                            <p class="new_section">
                            </p>
                            <legend>Name of the Company:</legend>
                            <asp:TextBox Text='<%# Bind("CompanyName") %>' runat="server" ID="txtCompanyName" Width="400px"
                                CssClass="post_title"></asp:TextBox><br />
                            <p>
                            </p>
                            <legend>Date Format:</legend>
                            <asp:TextBox Text='<%# Bind("DateFormat") %>' runat="server" ID="txtDateFormat" CssClass="post_title"></asp:TextBox>(for e.g. {0:dd/MM/yyyy}, {0:MM/dd/yyyy})<br />
                            <p>
                            </p>
                            <legend>Application Name:</legend>
                            <asp:TextBox Text='<%# Bind("ApplicationName") %>' runat="server" ID="txtApplicationName"
                                CssClass="post_title"></asp:TextBox><br />
                            <p>
                            </p>
                            <legend>Application Email Address:</legend><span>
                                <asp:TextBox Text='<%# Bind("SiteEmailAddress") %>' runat="server" ID="txtSiteEmailAddress"
                                    CssClass="post_title"></asp:TextBox></span>
                            <p class="new_section">
                            </p>
                            <p>
                            </p>
                            <legend>Inventory Control Warehouse & Location:</legend>
                            <font color="black">Warehouse:</font>
                            <span><asp:TextBox Text='<%# Bind("InvControlWareHouse") %>' runat="server" ID="txtInvControlWarehouse" Width="20"
                                CssClass="post_title"></asp:TextBox></span> 
                                <font color="black">Location:</font>
                                <span><asp:TextBox Text='<%# Bind("InvControlLocation") %>'
                                    runat="server" ID="txtInvControlLocation" Width="60" CssClass="post_title"></asp:TextBox></span>
                            <p class="new_section">
                            </p>                            
                            <legend>Purchasing Warehouse & Location:</legend>
                            <font color="black">Warehouse:</font>
                            <span><asp:TextBox Text='<%# Bind("PurchasingWareHouse") %>' runat="server" ID="txtPurchasingWarehouse" Width="20"
                                CssClass="post_title"></asp:TextBox></span> 
                                <font color="black">Location:</font>
                                <span><asp:TextBox Text='<%# Bind("PurchasingLocation") %>'
                                    runat="server" ID="txtPurchasingLocation" Width="60" CssClass="post_title"></asp:TextBox></span>
                            <p class="new_section">
                            </p>
                            <p>
                                <asp:Button CssClass="button" ID="UpdateButton" runat="server" Text="Update" CommandName="Update" />
                                <asp:Button CssClass="button" ID="Cancel" runat="server" Text="Cancel" OnClick="Cancel_Click" />
                            </p>
                        </EditItemTemplate>
                    </asp:FormView>
                    <asp:ObjectDataSource ID="SettingsDataSource" runat="server" TypeName="PMSApp.BusinessLogicLayer.SiteSettings"
                        SelectMethod="GetSharedSettings" UpdateMethod="UpdateSettings" DataObjectTypeName="PMSApp.BusinessLogicLayer.SiteSettings"
                        OnUpdated="SettingsDataSource_Updated">
                        <UpdateParameters>
                            <asp:Parameter Type="Boolean" Name="SiteIsOnline"></asp:Parameter>
                            <asp:Parameter Type="Boolean" Name="ImplementsTUAIP"></asp:Parameter>
                            <asp:Parameter Type="String" Name="CompanyName"></asp:Parameter>
                            <asp:Parameter Type="String" Name="DateFormat"></asp:Parameter>
                            <asp:Parameter Type="String" Name="ApplicationName"></asp:Parameter>
                            <asp:Parameter Type="String" Name="SiteEmailAddress"></asp:Parameter>
                            <asp:Parameter Type="String" Name="InvControlWarehouse"></asp:Parameter>
                            <asp:Parameter Type="String" Name="InvControlLocation"></asp:Parameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
