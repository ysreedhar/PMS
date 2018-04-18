<%@ Page Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true"
    CodeFile="DocumentFormatMaster.aspx.cs" Inherits="Admin_DocumentFormatMaster"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Document Format Master<br />
    <asp:GridView ID="gvDocumentFormatMaster" Width="100%" runat="server" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="DocMasterID" DataSourceID="dsDocumentFormatMaster"
        EmptyDataText="There are no data records to display." ForeColor="#333333" GridLines="None"
        Font-Size="Small">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="DocMasterID" HeaderText="ID" ReadOnly="True" SortExpression="DocMasterID" />
            <asp:TemplateField HeaderText="Document Name">
                <ItemTemplate>
                    <asp:Label ID="lblDocumentName" Text='<%# Eval("DocumentName") %>' runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                      <asp:Label ID="lblEditDocumentName" Text='<%# Eval("DocumentName") %>' runat="server"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TopLeft" HeaderText="Top Left" SortExpression="TopLeft" />
            <asp:BoundField DataField="TopRight" HeaderText="Top Right" SortExpression="TopRight" />
            <asp:BoundField DataField="BottomLeft" HeaderText="Bottom Left" SortExpression="BottomLeft" />
            <asp:BoundField DataField="BottomRight" HeaderText="Bottom Right" SortExpression="BottomRight" />
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <asp:SqlDataSource ID="dsDocumentFormatMaster" runat="server" ConnectionString="<%$ ConnectionStrings:PMSDbConnection %>"
        ProviderName="<%$ ConnectionStrings:pmsdbConnection.ProviderName %>" SelectCommand="SELECT [DocMasterID], [DocumentName], [TopLeft], [TopRight], [BottomLeft], [BottomRight] FROM [tblDocumentFormatMaster]"
        UpdateCommand="UPDATE [tblDocumentFormatMaster] SET [TopLeft] = @TopLeft, [TopRight] = @TopRight, [BottomLeft] = @BottomLeft, [BottomRight] = @BottomRight WHERE [DocMasterID] = @DocMasterID">
        <UpdateParameters>
            <asp:Parameter Name="DocumentName" Type="String" />
            <asp:Parameter Name="TopLeft" Type="String" />
            <asp:Parameter Name="TopRight" Type="String" />
            <asp:Parameter Name="BottomLeft" Type="String" />
            <asp:Parameter Name="BottomRight" Type="String" />
            <asp:Parameter Name="DocMasterID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
