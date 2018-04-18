<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DefaultMaster.master"
    CodeFile="CreateNewUser.aspx.cs" Inherits="CreateNewUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <center>
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                BorderStyle="Solid" BorderWidth="1px" CompleteSuccessText="The account has been successfully created."
                ContinueDestinationPageUrl="~/default.aspx" Font-Names="Verdana" Font-Size="0.8em"
                OnCreatedUser="CreateUserWizard1_CreatedUser" UnknownErrorMessage="The account was not created. Please try again."
                LoginCreatedUser="False">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" Title="Step 1: Basic User Information">
                        <ContentTemplate>
                            <table border="0" style="font-size: 10pt; font-family: Verdana" width="500">
                                <tr>
                                    <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #6b696b">
                                        Create&nbsp; User
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">UserID:</asp:Label></td>
                                    <td align="left">
                                        <asp:TextBox ID="UserName" runat="server" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                            ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">
                                        *</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></td>
                                    <td align="left">
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">
                                        *</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Re-Type Password:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                            ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                            ValidationGroup="CreateUserWizard1">
                                        *</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">Email:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="Email" runat="server" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                            ErrorMessage="Email is required." ToolTip="Email is required." ValidationGroup="CreateUserWizard1">
                                        *</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <table border="0" style="font-size: 10pt; font-family: Verdana" width="500">
                                <tr>
                                    <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #6b696b">
                                        Personnel Information</td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="Label1" runat="server">Full Name:</asp:Label></td>
                                    <td align="left">
                                        <asp:TextBox ID="txtFullName" runat="server" Width="200px" Wrap="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDesignation"
                                            ErrorMessage="Assign Designation" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="Label2" runat="server">Designation:</asp:Label></td>
                                    <td align="left">
                                        <asp:TextBox ID="txtDesignation" runat="server" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDesignation"
                                            ErrorMessage="Assign Designation" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 150px">
                                        <asp:Label ID="Label3" runat="server">Department:</asp:Label></td>
                                    <td align="left">
                                        <asp:TextBox ID="txtDepartment" runat="server" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDepartment"
                                            ErrorMessage="Assign Department" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                            ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                            ValidationGroup="CreateUserWizard1">
                                        </asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: red">
                                        <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:WizardStep ID="wsAssignUserToRoles" runat="server" AllowReturn="False" OnActivate="AssignUserToRoles_Activate"
                        OnDeactivate="AssignUserToRoles_Deactivate" Title="Step 2: Assign User To Roles">
                        <table border="0" style="font-size: 10pt; font-family: Verdana" width="500">
                            <tr>
                                <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #6b696b">
                                    Assign Roles
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Select one or more roles for the user:</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:ListBox ID="AvailableRoles" Width="100%" runat="server" SelectionMode="Multiple">
                                    </asp:ListBox>
                                </td>
                            </tr>
                        </table>
                    </asp:WizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                        <ContentTemplate>
                            <table border="0" style="font-size: 10pt; font-family: Verdana" width="500">
                                <tr>
                                    <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #6b696b">
                                        Complete</td>
                                </tr>
                                <tr>
                                    <td>
                                        The account has been successfully created.</td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="ContinueButton" runat="server" BackColor="White" BorderColor="#507CD1"
                                            BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Continue"
                                            Font-Names="Verdana" ForeColor="#284E98" Text="Continue" ValidationGroup="CreateUserWizard1" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                    Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                <CreateUserButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <ContinueButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <StepStyle Font-Size="0.8em" />
            </asp:CreateUserWizard>
            &nbsp;</center>
    </div>
</asp:Content>
