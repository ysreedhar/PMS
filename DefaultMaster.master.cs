
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
using System.Text;
using PMSApp.BusinessLogicLayer;
namespace PMSApp
{
    public partial class DefaultMaster_Default : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteSettings settings = SiteSettings.GetSharedSettings();
            if (HttpContext.Current.User.IsInRole("Administration"))
            {
                //Allow Admin Users to login when the Application is Offline

            }
            else
            {
                if (!settings.SiteIsOnline)
                {
                    if (Request.QueryString["Resp"] != "Offline")
                        Server.Transfer("~/Offline.aspx?Resp=Offline");
                }
            }

            lblCompanyName.Text = settings.CompanyName.ToString();
            lblMasterDate.Text = String.Format(settings.DateFormat.ToString(), DateTime.Now);
            lblMasterTime.Text = Convert.ToString(DateTime.Now.ToShortTimeString());

            // Set page title
            string title = settings.ApplicationName.ToString();
            if (SiteMap.CurrentNode != null)
            {
                SiteMapNode current = SiteMap.CurrentNode;
                title = current.Title;
                current = current.ParentNode;
                while (current != null)
                {
                    title = string.Concat(current.Title, " :: ", title);
                    current = current.ParentNode;
                }
            }
            // finally, set the page's title to the title variable
            Page.Title = title;
        }
        protected void mnuMainMenu_MenuItemDataBound(object sender, MenuEventArgs e)
        {
            if (e.Item.Text.Equals("Help"))
            {
                e.Item.NavigateUrl = BuildHelpLink();
            }
        }

        private string BuildHelpLink()
        {
            StringBuilder sb = new StringBuilder();
            string pageName = GetCurrentPageName();
            string url = "Help.aspx?pageName=" + pageName;
            sb.Append("javascript:OpenHelpWindow('");
            sb.Append(url);
            sb.Append("','HelpWindow');");
            return sb.ToString();
        }

        private string GetCurrentPageName()
        {
            string pageNameWithExtension = Page.Request.AppRelativeCurrentExecutionFilePath;
            return System.IO.Path.GetFileNameWithoutExtension(pageNameWithExtension);
        }
    }
}