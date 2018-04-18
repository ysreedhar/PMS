<%@ Page Language="C#" CodeFile="DeliveryNote.aspx.cs" Inherits="DeliveryNote" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delivery Note</title>
    <link href="~/Css/PMSDocStyles.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="~/Css/PMSDocPrintStyles.css" rel="stylesheet" media="print" type="text/css" />
</head>

<body>
    <form id="form1" runat="server">
        <div >
            <table cellpadding="0" class="pageborder" cellspacing="0">
                <tr>
                    <td>
                        <asp:Label ID="lblCompanyName" runat="server" CssClass="CompanyTitle"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        <div style="text-align: left">
                            <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="DocTitle" style="height: 21px">
                                        DELIVERY NOTE
                                    </td>
                                    <td class="DocTitle" align="right" style="height: 21px">
                                        <asp:Label runat="server" ID="lblNumber"></asp:Label><br />
                                        <asp:Label CssClass="BarcodeStyle" runat="server" ID="lblRNBarcode"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataList ID="dlDeliveryNoteHeaderInfo" runat="server" DataSourceID="dsRequisitionHeader">
                            <HeaderTemplate>
                                <table class="HeaderTable">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <tr>
                                        <td>
                                            Supplied Date:
                                            <asp:Label ID="lblRRequestedDate" Text='<%# Eval("SupplyDt")%>' runat="server"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Supplied From Warehouse:
                                            <asp:Label ID="lblRFromWarehouse" CssClass="Special" runat="server" Text='<%# Eval("FromWarehouse")%>'></asp:Label>
                                        </td>
                                        <td>
                                            Supplied To Warehouse:
                                            <asp:Label CssClass="Special" ID="lblRToWarehouse" runat="server" Text='<%# Eval("ToWareHouse")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Location:
                                            <asp:Label CssClass="Special" ID="lblRFromLocation" runat="server" Text='<%# Eval("FromLocation")%>'></asp:Label>
                                        </td>
                                        <td>
                                            Location:
                                            <asp:Label CssClass="Special" ID="lblRToLocation" runat="server" Text='<%# Eval("ToLocation")%>'></asp:Label>
                                        </td>
                                    </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="dsRequisitionHeader" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                            SelectCommand="SELECT top 1 * FROM vDeliveryNoteHeader WHERE (SupplyHID = @SupplyHID)">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="1" Name="SupplyHID" QueryStringField="DlNo"
                                    Type="Decimal" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="1">
                            <asp:DataList ID="dlDeliveryNote" runat="server" DataSourceID="SqlDataSource1" CellPadding="4"
                                DataKeyField="SupplyID">
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingItemStyle BackColor="White" />
                                <ItemStyle />
                                <HeaderStyle />
                                <HeaderTemplate>
                                    <table class="ItemList" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <th>
                                                S/N</th>
                                            <th>
                                                ITEM NO.</th>
                                            <th>
                                                ITEM NAME</th>
                                            <th>
                                                QUANTITY</th>
                                            <th>
                                                UNIT</th>
                                            <th>
                                                PO. #</th>
                                            <th>
                                                REQUISITION #</th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblsno" runat="server" Text='<%# Eval("srlno") %>' /></td>
                                        <td>
                                            <asp:Label ID="lblitemno" runat="server" Text='<%# Eval("itemno") %>' /></td>
                                        <td>
                                            <asp:Label ID="lblitemdesc" runat="server" Text='<%# Eval("itdsc") %>' /></td>
                                        <td align="right">
                                            <asp:Label ID="lblQuantity" runat="server" Text='<%# GetItemUnitQuantity(decimal.Parse(Eval("Supplyquantity").ToString())).ToString("N3") %>' /></td>
                                        <td>
                                            <asp:Label ID="lbluom" runat="server" Text='<%# Eval("unmsr") %>' /></td>
                                        <td>
                                            <asp:Label ID="lblPoNumber" runat="server" Text='<%# Eval("PoNUmber") %>' /></td>
                                        <td>&nbsp;
                                            <asp:Label ID="lblRequestID" runat="server" Text='<%# String.Format("{0:0000000}",Eval("RequestID")) %>' /></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td align="right" colspan="4">
                                            Total =
                                            <%# GetTotalItemQuantity().ToString("N3")%>
                                        </td>
                                        <td colspan="3">
                                            &nbsp;</td>
                                    </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:DataList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                                SelectCommand="SELECT ROW_NUMBER()OVER(order by supplyID) SRLNO,* from vSupplyDetails WHERE ([SupplyID] = @SupplyID)">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="1" Name="SupplyID" QueryStringField="DlNo"
                                        Type="Decimal" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <hr></hr>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    SUPPLIED &nbsp;BY:</td>
                                <td>
                                    APPADMIN</td>
                            </tr>
                            <tr>
                                <td>
                                    DEPT / LINE :</td>
                                <td>
                                    ADMINISTRATION</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>Print Date:</strong><asp:Label ID="lblDeliveryNoteDate" runat="server"></asp:Label>
                        <strong>Time:</strong><asp:Label ID="lblDeliveryNoteTime" runat="server"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td>
                        <i>
                            <asp:Label ID="lblBottomLeft" runat="server"></asp:Label></i><br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                    <input id="btnPrint" class="ButtonStyle" type="button" onclick="window.print();" value="Print" /></td>
                    </td>
                </tr>
                
            </table>
        </div>
    </form>
</body>
</html>
