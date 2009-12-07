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

import org.datanucleus.jpa.annotations.Extension
import javax.persistence.*

@Entity
class User implements Serializable {
  @Id
  @GeneratedValue (strategy = GenerationType.IDENTITY)
  @Extension (vendorName = "datanucleus", key = "gae.encoded-pk", value = "true")
  String id

  @Version
  Long version

  String email
  String password
  String name
  String createdBy
  Date dateCreated
  String lastUpdatedBy
  Date lastUpdated
  
  @Basic 
  Set<Long> roleIds
  
  @Transient 
  List<Role> roles

  static constraints = {
      id (visible:false)
      email (blank:false, email:true, size:5..50, matches:/[\S]+/, unique:true)
      password (blank:false, size:5..30, matches:/[\S]+/)
      name (blank:false, size:5..50)
      createdBy (blank:false)
      dateCreated (blank:false)
      lastUpdatedBy (nullable:true)
      lastUpdated (nullable:true)
  }
  
  List getRoles() {
      if (roles == null && roleIds) {
          roles = new ArrayList(roleIds.size())
	  roleIds.each { roleId ->
	     roles << Role.get(roleId)
	  }
	  log.debug "roles.size() = ${roles.size()}"
      }
      
      return roles
  }

  String toString(){
    "(${id},${email},${password},${name},${version})"
  }
}

