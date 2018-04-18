<%@ Page language="c#" CodeFile="DatePicker.aspx.cs" AutoEventWireup="false" Inherits="_DatePicker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>DatePicker</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css">
		BODY { PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 4px; PADDING-TOP: 0px }
		BODY { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TABLE { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TR { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TD { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		</style>
	</head>
	<body onblur="this.window.focus();" ms_positioning="FlowLayout">
		<form id="Form1" method="post" runat="server">
			<div align="center">
				<asp:calendar id="Calendar1" runat="server" showgridlines="True" bordercolor="Black">
					<todaydaystyle forecolor="White" backcolor="#FFCC66"></todaydaystyle>
					<selectorstyle backcolor="#FFCC66"></selectorstyle>
					<nextprevstyle font-size="9pt" forecolor="#FFFFCC"></nextprevstyle>
					<dayheaderstyle height="1px" backcolor="#FFCC66"></dayheaderstyle>
					<selecteddaystyle font-bold="True" backcolor="#CCCCFF"></selecteddaystyle>
					<titlestyle font-size="9pt" font-bold="True" forecolor="#FFFFCC" backcolor="#990000"></titlestyle>
					<othermonthdaystyle forecolor="#CC9966"></othermonthdaystyle>
				</asp:calendar>
			</div>
		</form>
	</body>
</html>
