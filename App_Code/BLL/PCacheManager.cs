using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;



public class PCacheManager
{
    private const string MESSAGES_FILE_PATH = "~/App_Data/HelpMessages.xml";
    private const string XML_DOCUMENT = "XmlDocument";
    public static string GetHelpByPageName(string pageName)
    {
        return GetMessageByElementName(pageName);
    }

    private static string GetMessageByElementName(string elementName)
    {
        string message = String.Empty;
        XmlDocument xmlDoc = null;
        if (HttpContext.Current.Cache[XML_DOCUMENT] == null)
        {
            xmlDoc = new XmlDocument();
            xmlDoc.Load(HttpContext.Current.Server.MapPath(MESSAGES_FILE_PATH));
            // insert into cache object
            HttpContext.Current.Cache.Insert(XML_DOCUMENT, xmlDoc, new System.Web.Caching.CacheDependency(HttpContext.Current.Server.MapPath(MESSAGES_FILE_PATH)));
        }
        // retrieves the value from the cache object
        xmlDoc = (XmlDocument)HttpContext.Current.Cache[XML_DOCUMENT];
        message = ((XmlNode)((XmlNodeList)xmlDoc.GetElementsByTagName(elementName)).Item(0)).InnerText;
        return message;
    }
}