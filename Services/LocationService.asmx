<%@WebService Language="C#" Class="LocationService" %>


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
public class LocationService : System.Web.Services.WebService {

   
    [WebMethod]
    public String[] FindLocationNames(String prefixText, int count)
    
    {
        String[] retStr = sqlLocationsProvider.GetLocationNames(prefixText);
      return retStr;
    }

       
}

