<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppLogin.aspx.cs" Inherits="AppLogin" %>
<%@ Register TagPrefix="PMS" TagName="LogoCons" Src="~/Controls/LogoControl.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> PMS - Application Login</title>
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="Css/PMSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body runat="server">
    <form runat="server" id="LoginForm" >
        <table border="0" cellpadding="0" runat="server" cellspacing="0" style="width: 100%; height: 100%">
            <tr>
                <td align="center" valign="baseline">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr >
                            <td style="font-weight: bold;background-color: Navy;font-size: large;vertical-align: top;color: white;font-family: Tahoma;letter-spacing: normal;text-align: left;">                                &nbsp;
                                <asp:Label ID="lblCompanyName"  CssClass="CompanyTitle" runat="server"></asp:Label>
                                </td>
                                <td><!--<PMS:LogoCons runat="server"/>--></td>
                            </tr>
                        <tr>
                            <td  colspan='2' align="center" style="font-weight: bold; color: black; font-family: Tahoma; background-color: #ccccff;
                                font-variant: small-caps" valign="middle">
                                PMS II - Application Login</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table align="center">
                        <tr>
                            <td>
                                <asp:Login ID="Login1" runat="server" BackColor="#EFF3FB" DestinationPageUrl="default.aspx"
                                    BorderColor="#B5C7DE" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"
                                    Font-Size="0.8em" RememberMeText="" BorderPadding="4" ForeColor="#333333" OnLoggedIn="Login1_LoggedIn">
                                    <TitleTextStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" Font-Size="0.9em">
                                    </TitleTextStyle>
                                    <LayoutTemplate>
                                        <table style="border-collapse: collapse" cellspacing="0" cellpadding="1" border="0">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" border="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: white; background-color: #6b696b; height: 18px;"
                                                                        align="center" colspan="2">
                                                                        Log In</td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Width="100%">User Name:</asp:Label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ValidationGroup="Login1"
                                                                            ToolTip="User Name is required." ErrorMessage="User Name is required." ControlToValidate="UserName">*</asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ValidationGroup="Login1"
                                                                            ToolTip="Password is required." ErrorMessage="Password is required." ControlToValidate="Password">*</asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: red" align="center" colspan="2">
                                                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" colspan="2">
                                                                        <asp:Button CssClass="button" ID="LoginButton" runat="server" ValidationGroup="Login1"
                                                                            Text="Log In" CommandName="Login"></asp:Button>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </LayoutTemplate>
                                    <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                    <TextBoxStyle Font-Size="0.8em" />
                                    <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                                </asp:Login>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
