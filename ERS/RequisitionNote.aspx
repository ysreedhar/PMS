<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RequisitionNote.aspx.cs"
    Inherits="ERS_RequisitionNote" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Requisition Note</title>
    <link href="~/Css/PMSDocStyles.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="~/Css/PMSDocPrintStyles.css" rel="stylesheet" media="print" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
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
                                    <td class="DocTitle"  >
                                        REQUISITION NOTE
                                    </td>
                                    <td class="DocTitle" align="right"  >
                                        <asp:Label runat="server" ID="lblNumber"></asp:Label><br/>
                                        <asp:Label CssClass="BarcodeStyle" runat="server" ID="lblRNBarcode"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataList ID="dlReqNoteHeaderInfo" runat="server" DataSourceID="dsRequisitionHeader">
                            <HeaderTemplate>
                                <table class="HeaderTable">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <tr>
                                        <td>
                                            Requested Date:
                                            <asp:Label ID="lblRRequestedDate" Text='<%# Eval("RequestedDt")%>' runat="server"></asp:Label>
                                        </td>
                                         <td>
                                            Pick List No.:
                                            <asp:Label ID="lblPickListNo" Text='<%# Eval("PickListNo")%>' runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Requested From Warehouse:
                                            <asp:Label ID="lblRFromWarehouse" CssClass="Special" runat="server" Text='<%# Eval("FromWarehouse")%>'></asp:Label>
                                        </td>
                                        <td>
                                            Requested To Warehouse:
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
                            SelectCommand="SELECT top 1 * FROM vRequisitionNoteHeader WHERE (RequestID = @RequestID)">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="1" Name="RequestID" QueryStringField="RqNo"
                                    Type="Decimal" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataList ID="dlRequisitionNote" runat="server" DataSourceID="SqlDataSource1"
                            DataKeyField="RequestID">
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
                                            UNIT</th>
                                        <th>
                                            REQUESTED DATE</th>
                                        <th>
                                            REQUESTED TIME</th>
                                        <th>
                                            SEQ.</th>
                                        <th>
                                            REQUESTED QUANTITY</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblsno" runat="server" Text='<%# Eval("srlno") %>' /></td>
                                    <td NOWRAP>
                                        <asp:Label ID="lblitemno" runat="server" Text='<%# Eval("itemname") %>' /></td>
                                    <td NOWRAP>
                                        <asp:Label ID="lblitemdesc" runat="server" Text='<%# Eval("itdsc") %>' /></td>
                                    <td>
                                        <asp:Label ID="lbluom" runat="server" Text='<%# Eval("unmsr") %>' /></td>
                                    <td>
                                        <asp:Label ID="lblRequestedDate" runat="server" Text='<%# CommonFunctions.ConvertToAppDateFormat((DateTime)Eval("RequiredDate")) %>' /></td>
                                    <td>
                                        <asp:Label ID="lblRequestedTime" runat="server" Text='<%# Eval("RequiredTime") %>' /></td>
                                    <td>
                                        <asp:Label ID="lblRequestedSeq" runat="server" Text='<%# Eval("requiredsequence") %>' /></td>
                                    <td align="right">
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%# GetItemUnitQuantity(decimal.Parse(Eval("quantity").ToString())).ToString("N3") %>' /></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr>
                                    <td align="right" colspan="8">
                                        Total =
                                        <%# GetTotalItemQuantity().ToString("N3")%>
                                    </td>
                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:DataList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PMSdbConnection %>"
                            SelectCommand="SELECT ROW_NUMBER()OVER(order by requestid) SRLNO,* from vrequisitiondetails WHERE ([RequestID] = @RequestID) order by srlno asc, requireddate asc, requiredsequence asc, requiredtime asc, itemname asc">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="1" Name="RequestID" QueryStringField="RqNo"
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
                                    REQUESTED BY:</td>
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
                        <strong>Print Date:</strong><asp:Label ID="lblReqNoteDate" runat="server"></asp:Label>
                        <strong>Time:</strong><asp:Label ID="lblReqNoteTime" runat="server"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td>
                        <i>
                            <asp:Label ID="lblBottomLeft" runat="server" ></asp:Label></i><br />
                    </td>
                </tr>
                <tr>
                    <td align="right" >
                        <input id="btnPrint" class="ButtonStyle" type="button" onclick="window.print();" value="Print" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
