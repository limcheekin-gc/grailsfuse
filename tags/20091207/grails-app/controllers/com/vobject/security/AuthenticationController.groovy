/*
 * The VObject GrailsFuse is an open source project and project skeleton that leverage 
 * Grails Framework and it's plugins to jump-start development of web application 
 * that running on Google App Engine (GAE/G). 
 * Copyright (C) VObject.com
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Author: Lim Chee Kin (limcheekin@vobject.com)
 *
 */
 
package com.vobject.security

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import com.google.appengine.api.datastore.KeyFactory

class AuthenticationController {
  def authenticationService
  
  def login = {}

  def authenticate = {
    def user = authenticationService.findUser(params.email)
    if (user && user.password.equals(params.password.encodeAsPassword())){
      session.user = user
      session.message = "Welcome ${user.name}!"
      if (session.lastAccessURI) {
          String lastAccessURI = session.lastAccessURI 
	  session.lastAccessURI = null
	  redirect(url: lastAccessURI)
      } else 
	  redirect(uri: CH.config.vobject.security.defaultUrlAfterLogin?:"/index.gsp")  
    }else{
      session.message = "Invalid Email or Password. Please try again."
      session.messageClass = "error";
      redirect(action:"login")
    }
  }

  def logout = {
    session.message = "Good bye ${session.user.name}, see you again!"
    session.messageClass = "notice";
    session.user = null 
    session.user = servletContext.anonymous	
    redirect(uri: CH.config.vobject.security.defaultUrlAfterLogout?:"/authenticate/login")      
  }

//************* CODE BELOW TO BE REMOVED *************************
  def resetData = {
      clearData()
      loadData()
  }

  def loadData = {
        if (User.count == 0) {
	    List keys = [new Role(name:"Anonymous"),
	    new Role(name:"System Administrator"),
	    new Role(name:"Normal User")].batchSave()

	    List users = [new User(email:"anonymous@anonymous.com", name:"Anonymous"),
	                  new User(email:"grailsfuse@vobject.com", password:"grailsfuse".encodeAsPassword(), name:"Administrator"),
			  new User(email:"user1@vobject.com", password:"user1".encodeAsPassword(), name:"User 1")]
            for (int i = 0; i < users.size(); i++) {
	        users[i].roleIds = new HashSet<Long>(1)
	        users[i].roleIds << keys[i].id
	    }
	    // users.batchSave()	

	    List permissions = [new Permission(roleId:keys[0].id, controller:"appEngineReload", action:"index"),
		       new Permission(roleId:keys[1].id, controller:"user", action:"create"),
		       new Permission(roleId:keys[1].id, controller:"user", action:"update"),
		       new Permission(roleId:keys[1].id, controller:"user", action:"edit"),
		       new Permission(roleId:keys[1].id, controller:"user", action:"save"),
	               new Permission(roleId:keys[1].id, controller:"user", action:"show"),
	               new Permission(roleId:keys[1].id, controller:"user", action:"delete"),
	               new Permission(roleId:keys[1].id, controller:"user", action:"list"),
	               new Permission(roleId:keys[1].id, controller:"user", action:"index"),
		       new Permission(roleId:keys[1].id, controller:"role", action:"create"),
		       new Permission(roleId:keys[1].id, controller:"role", action:"update"),
		       new Permission(roleId:keys[1].id, controller:"role", action:"edit"),
		       new Permission(roleId:keys[1].id, controller:"role", action:"save"),
	               new Permission(roleId:keys[1].id, controller:"role", action:"show"),
	               new Permission(roleId:keys[1].id, controller:"role", action:"delete"),
	               new Permission(roleId:keys[1].id, controller:"role", action:"list"),
	               new Permission(roleId:keys[1].id, controller:"role", action:"index"),
		       new Permission(roleId:keys[2].id, controller:"user", action:"show"),
	               new Permission(roleId:keys[2].id, controller:"user", action:"list"),
	               new Permission(roleId:keys[2].id, controller:"user", action:"index"),
	               new Permission(roleId:keys[2].id, controller:"role", action:"show"),
	               new Permission(roleId:keys[2].id, controller:"role", action:"list"),
	               new Permission(roleId:keys[2].id, controller:"role", action:"index")]
            permissions.addAll(users) 
            permissions.batchSave()

	 }

         render "Data created:<br />" 
	 render "User.count() = ${User.count()}<br />"
	 render "Role.count() = ${Role.count()}<br />"
	 render "Permission.count() = ${Permission.count()}<br />"

   }

    def clearData = {    
         def list = new ArrayList(User.list()) 
	 list.addAll(Role.list())
	 list.addAll(Permission.list())
	 list.batchDelete()
         render "Data cleared:<br />" 
	 render "User.count() = ${User.count()}<br />"
	 render "Role.count() = ${Role.count()}<br />"
	 render "Permission.count() = ${Permission.count()}<br />" 

  }

  def userCSV = {
	response.setHeader("Content-disposition", "attachment; filename=user.csv");
	render(contentType: "text/csv", text: getCSV(User.list()));
  }

  def roleCSV = {
	response.setHeader("Content-disposition", "attachment; filename=role.csv");
	render(contentType: "text/csv", text: getCSV(Role.list()));
  }

  def permissionCSV = {
	response.setHeader("Content-disposition", "attachment; filename=permission.csv");
	render(contentType: "text/csv", text: getCSV(Permission.list()));
  }
  
  String getCSV(List list) {
      StringBuffer buf = new StringBuffer()
      list.each {
	buf.append(it)
        buf.append("\n")
      }
      buf.toString()
  }
}