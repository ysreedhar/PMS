using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.ComponentModel;
using System.Collections.ObjectModel;


	/// <summary>
	/// A class used to encapsulate the Roles in ASP.NET Membermanagement 2.0
	/// </summary>
	[DataObject(true)]  // This attribute allows the 
	public class RoleDataObject
	{

        /// <summary>
        /// Used to get all roles available
        /// </summary>
        /// <returns></returns>
        /// 
        [DataObjectMethod(DataObjectMethodType.Select, true)]
        static public List<RoleData> GetRoles()
        {
            return GetRoles(null, false);
        }

		/// <summary>
		/// Returns a collection of RoleData type values.  This specialized constructor lets you request by
        /// an individual user
		/// </summary>
		/// <param name="userName">if null and showOnlyAssignedRolls==false, display all roles</param>
		/// <param name="showOnlyAssignedRolls">if true, just show assigned roles</param>
		/// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select,false)]
		static public List<RoleData> GetRoles(string userName, bool showOnlyAssignedRolls)
		{
			List<RoleData> roleList = new List<RoleData>();

			string[] roleListStr = Roles.GetAllRoles();
			foreach (string roleName in roleListStr)
			{
                bool userInRole = false;
                // First, figure out if user is in role (if there is a user)
                if (userName != null)
                {
                    userInRole = Roles.IsUserInRole(userName, roleName);
                }

                if (showOnlyAssignedRolls == false || userInRole == true)
                {
                    // Getting usersInRole is only used for the count below
                    string[] usersInRole = Roles.GetUsersInRole(roleName);
                    RoleData rd = new RoleData();
                    rd.RoleName = roleName;
                    rd.UserName = userName;
                    rd.UserInRole = userInRole;
                    rd.NumberOfUsersInRole = usersInRole.Length;
                    roleList.Add(rd);
                }
			}

            // FxCopy will give us a warning about returning a List rather than a Collection.
            // We could copy the data, but not worth the trouble.
            return roleList;
		}

		/// <summary>
		/// Used for Inserting a new role.  Doesn't associate a user with a role.
		/// This is not quite consistent with this object, but really what we want.
		/// </summary>
		/// <param name="RoleName">The Name of the role to insert</param>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        static public void Insert(string roleName)
		{
			if (Roles.RoleExists(roleName) == false)
			{
				Roles.CreateRole(roleName);
			}
		}
        
        /// <summary>
        /// Delete any given role while first removing any roles associated with existing users
        /// </summary>
        /// <param name="roleName">name of role to delete</param>
        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        static public void Delete(string roleName)
		{
			// remove this role from all users.  not sure if deleterole does this automagically
			MembershipUserCollection muc = Membership.GetAllUsers();
			string[] allUserNames = new string[1];

			foreach (MembershipUser mu in muc)
			{
				if (Roles.IsUserInRole(mu.UserName, roleName) == true)
				{
					allUserNames[0] = mu.UserName;
					Roles.RemoveUsersFromRole(allUserNames, roleName);
				}
			}
			Roles.DeleteRole(roleName);
		}
	}

	/// <summary>
	/// Dataobject class used as a base for the collection
	/// </summary>
	public class RoleData
	{

		// Non normalized column which counts current number of users in a role
		private int numberOfUsersInRole;
		public int NumberOfUsersInRole
		{
			get { return numberOfUsersInRole; }
			set { numberOfUsersInRole = value; }
		}

		private string roleName;
        [DataObjectField(true)]
		public string RoleName
		{
			get { return roleName; }
			set { roleName = value; }
		}

		private string userName;
		public string UserName
		{
			get { return userName; }
			set { userName = value; }
		}

		private bool userInRole;
		public bool UserInRole
		{
			get { return userInRole; }
			set { userInRole = value; }
		}

	}

