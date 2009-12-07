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

class UserController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ userInstanceList: User.list( params ), userInstanceTotal: User.count() ]
    }

    def show = {
        def userInstance = User.get( params.id )
                 
        if(!userInstance) {
            session.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
        else {
	    return [ userInstance : userInstance ] 
	}
    }

    def delete = {
        def userInstance = User.get( params.id )
        if(userInstance) {
            try {
	        User.withTransaction {
                    userInstance.delete(flush:true)
                }
                session.message = "User ${params.name} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                session.message = "User ${params.name} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            session.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def userInstance = User.get( params.id )

        if(!userInstance) {
            session.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ userInstance : userInstance ]
        }
    }

    def update = {
        def userInstance = User.get( params.id )
        if(userInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(userInstance.version > version) {
                    userInstance.errors.rejectValue("version", "user.optimistic.locking.failure", "Another user has updated this User while you were editing.")
                    render(view:'edit',model:[userInstance:userInstance])
                    return
                }
            }
            userInstance.properties = params
            putRoleIds(userInstance, params)
	        userInstance.lastUpdated = new Date()
            if(!userInstance.hasErrors() && userInstance.save()) {
                session.message = "User ${params.name} updated"
                redirect(action:show,id:userInstance.id)
            }
            else {
                render(view:'edit',model:[userInstance:userInstance])
            }
        }
        else {
            session.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def putRoleIds(def userInstance, def params) {
	    if (params.roleIds) {
	    	log.debug "params.roleIds = ${params.roleIds}"
	        userInstance.roleIds = new HashSet()
		if (params.roleIds instanceof String) {
		    userInstance.roleIds << params.roleIds.toLong()
		} else {
	            params.roleIds.each { roleId ->
	        	userInstance.roleIds << roleId.toLong()
	            }
		}
	    }
    }
    
    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return ['userInstance':userInstance]
    }

    def save = {
        def userInstance = new User(params)
	putRoleIds(userInstance, params)
	userInstance.dateCreated = new Date()
	User.withTransaction {
            if(!userInstance.hasErrors() && userInstance.validate()) {
	        userInstance.password = userInstance.password.encodeAsPassword()
                if (userInstance.save(flush:true)) {
		    session.message = "User ${userInstance.name} created"
                    redirect(action:show,id:userInstance.id)
		}
            }
            else {
                render(view:'create',model:[userInstance:userInstance])
            }
	}
    }
}
