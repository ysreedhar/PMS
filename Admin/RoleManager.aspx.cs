using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class RoleManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MembershipUserCollection users = Membership.GetAllUsers();
            foreach (MembershipUser user in users)
            {
                lbUsers.Items.Add(user.UserName);
            }

            string[] allRoles = Roles.GetAllRoles();
            foreach (string role in allRoles)
            {
                cblRoles.Items.Add(role);
            }
        }

    }
    protected void lbUsers_SelectedIndexChanged(object sender, EventArgs e)
    {
        string[] userRoles = Roles.GetRolesForUser(lbUsers.SelectedValue);
        cblRoles.ClearSelection();
        foreach (string role in userRoles)
        {
            ListItem li = cblRoles.Items.FindByValue(role);
            if (li != null)
            {
                li.Selected = true;
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        foreach (ListItem li in cblRoles.Items)
        {
            if (li.Selected == true)
            {
                if (Roles.IsUserInRole(lbUsers.SelectedValue, li.Value) == false)
                {
                    Roles.AddUserToRole(lbUsers.SelectedValue, li.Value);
                }
            }
            else
            {
                if (Roles.IsUserInRole(lbUsers.SelectedValue, li.Value))
                {
                    Roles.RemoveUserFromRole(lbUsers.SelectedValue, li.Value);
                }
            }
        }
    }
}
