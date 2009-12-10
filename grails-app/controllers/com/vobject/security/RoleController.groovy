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

class RoleController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ roleInstanceList: Role.list( params ), roleInstanceTotal: Role.count() ]
    }

    def show = {
        def roleInstance = Role.get( params.id )

        if(!roleInstance) {
            session.message = "Role not found with id ${params.id}"
            redirect(action:list)
        }
        else {
	    return [ roleInstance : roleInstance ] 
	}
    }

    def delete = {
        def roleInstance = Role.get( params.id )
        if(roleInstance) {
            try {
	        String roleName = roleInstance.name;
	        Role.withTransaction {
                    roleInstance.delete(flush:true)
                }
		// after roleInstance deleted, it's id = null, 
		// re-assignment of the id required by deleteAllPermissions
		roleInstance.id = Long.valueOf(params.id)  
		roleInstance.deleteAllPermissions()
                session.message = "Role ${roleName} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                session.message = "Role ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            session.message = "Role not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def roleInstance = Role.get( params.id )

        if(!roleInstance) {
            session.message = "Role not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ roleInstance : roleInstance ]
        }
    }

    def update = {
        def roleInstance = Role.get( params.id )
        if(roleInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(roleInstance.version > version) {
                    roleInstance.errors.rejectValue("version", "role.optimistic.locking.failure", "Another user has updated this Role while you were editing.")
                    render(view:'edit',model:[roleInstance:roleInstance])
                    return
                }
            }
            roleInstance.properties = params	
	    roleInstance.lastUpdated = new Date()
            if(!roleInstance.hasErrors() && roleInstance.save()) {
	        roleInstance.deleteAllPermissions()
	        savePermissions(roleInstance)
                session.message = "Role ${roleInstance.name} updated"
                redirect(action:show,id:roleInstance.id)
            }
            else {
                render(view:'edit',model:[roleInstance:roleInstance])
            }
        }
        else {
            session.message = "Role not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def roleInstance = new Role()
        roleInstance.properties = params
        return ['roleInstance':roleInstance]
    }

    def save = {
        def roleInstance = new Role(params)
	roleInstance.dateCreated = new Date()
	boolean isSaved 
	Role.withTransaction {
	    isSaved = roleInstance.save(flush: true)
	}	
        if(!roleInstance.hasErrors() && isSaved) {
	    savePermissions(roleInstance)
            session.message = "Role ${roleInstance.name} created"
            redirect(action:show,id:roleInstance.id)
        }
        else {
            render(view:'create',model:[roleInstance:roleInstance])
        }
    }

    def savePermissions (def roleInstance){
        def permissions
	grailsApplication.controllerClasses.each {
	   def lowerCaseControllerName = it.name.toLowerCase()
           log.debug "params.${lowerCaseControllerName} = ${params[lowerCaseControllerName]}"
	   if (params[lowerCaseControllerName]) {
	       permissions = []
	       if (params[lowerCaseControllerName] instanceof String) {
		   permissions << new Permission(roleId: roleInstance.id, 
		                  controller:lowerCaseControllerName, 
		 	          action:params[lowerCaseControllerName]);
               } else {
		   params[lowerCaseControllerName].each { actionName ->
		      permissions << new Permission(roleId: roleInstance.id, 
				   controller:lowerCaseControllerName, action:actionName)
		   }
	       }
	       permissions?.batchSave()
	   }
	}
	
    }
}
