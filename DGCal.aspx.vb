Imports PMSApp.BusinessLogicLayer
Public Class DGCal
    Inherits System.Web.UI.Page
    ' Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    'Protected WithEvents Literal1 As System.Web.UI.WebControls.Literal

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Public Sub Calendar1_DayRender(ByVal sender As Object, ByVal e As DayRenderEventArgs)
        If e.Day.Date = DateTime.Now.ToString("d") Then
            e.Cell.BackColor = System.Drawing.Color.LightGray
        End If
    End Sub

    Public Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim strDateSelected = CommonFunctions.ConvertToAppDateFormat(Calendar1.SelectedDate)
        Dim strjscript As String = "<script language=""javascript"">"
        strjscript &= "window.opener." & _
              HttpContext.Current.Request.QueryString("formname") & ".value = '" & _
              strDateSelected & "';window.close();"
        strjscript = strjscript & "</scr" & "ipt>"
        Literal1.Text = strjscript
    End Sub

End Class
