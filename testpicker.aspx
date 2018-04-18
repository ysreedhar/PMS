<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testpicker.aspx.cs" Inherits="testpicker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>

<script type="text/javascript">
//document.write("<p>The first form's name is: " + window.opener.window.document.forms[0].controls[0].name + "</p>")
 //document.write(window.opener.window.document.forms[0].getElementById("ctl00_ContentPlaceHolder1_lblUpdate")) ;
// document.write(window.opener.window.document.getElementById("ctl00_ContentPlaceHolder1_lblUpdate").innerHTML) ;
//document.write("<p>The first form's name is: " + document.getElementById("Form1").name + "</p>")
window.opener.window.document.getElementById("ctl00_ContentPlaceHolder1_lblUpdate").innerHTML = "Hi Its me" ;
</script>


</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    </div>
    </form>
</body>
</html>
