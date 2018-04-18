<%@WebService Language="C#" Class="ItemService" %>


using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Data.Common;
using System.Collections;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ItemService : System.Web.Services.WebService {

   
    [WebMethod]
    public String[] FindItemDescription(String prefixText, int count)
    
    {
      String[] retStr =  sqlItemsProvider.GetItemdescriptions(prefixText);
      return retStr;
    }
    [WebMethod]
    public String[] FindItemNumber(String prefixText, int count)
    {
        String[] retStr = sqlItemsProvider.GetItemNumber(prefixText);
        return retStr;
    }

       
}

