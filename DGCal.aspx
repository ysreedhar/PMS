<%@ Page Language="vb" AutoEventWireup="false" CodeFile="DGCal.aspx.vb" Inherits="DGCal" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	</HEAD>
	<body MS_POSITIONING="FlowLayout" bottomMargin="2" leftMargin="2" topMargin="2" rightMargin="2">
		<form id="Form1" method="post" runat="server">
			<asp:Calendar id="Calendar1" 
			              runat="server" 
			              OnSelectionChanged="Calendar1_SelectionChanged" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="100%" Width="100%">
				<TodayDayStyle BorderWidth="1px" BorderStyle="Solid" BackColor="#99CCCC" ForeColor="White"></TodayDayStyle>
				<NextPrevStyle ForeColor="#CCCCFF" Font-Size="8pt"></NextPrevStyle>
				<TitleStyle ForeColor="#CCCCFF" BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" Height="25px"></TitleStyle>
				<OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                <WeekendDayStyle BackColor="#CCCCFF" />
                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
			</asp:Calendar><BR>
			<asp:Literal id="Literal1" runat="server"></asp:Literal>
		</form>
	</body>
</HTML>
