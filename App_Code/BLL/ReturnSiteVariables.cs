using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using PMSApp.Web;
using PMSApp.BusinessLogicLayer;

/// <summary>
/// Summary description for ReturnSiteVariables
/// </summary>
public class ReturnSiteVariables
{
    public static string ReturnAppInvControl()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppInvControlLocation = settings.InvControlLocation;
        return strAppInvControlLocation;
    }
    public static string ReturnAppInvControlWarehouse()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppInvControlWarehouse = settings.InvControlWarehouse;
        return strAppInvControlWarehouse;
    }

    public static string ReturnAppEmailAddress()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppEmailAddress = settings.SiteEmailAddress;
        return strAppEmailAddress;
    }
    public static string ReturnAppCompanyName()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppCompanyName = settings.CompanyName;
        return strAppCompanyName;
    }
    public static string ReturnAppApplicationName()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppApplicationName = settings.ApplicationName;
        return strAppApplicationName;
    }

    public static bool ReturnAppImplementsTUAIP()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        bool boolImplementsTUAIP = settings.ImplementsTUAIP;
        return boolImplementsTUAIP;
    }
    public ReturnSiteVariables()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
