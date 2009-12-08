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

class SecurityFilters {
    def authenticationService
    def authorizationService

    def filters = {
        authentication(controller:'*', action:'*') {
            before = {
		if (!servletContext.anonymous) {
		    servletContext.anonymous = authenticationService.findUser("anonymous@anonymous.com")
		    if (!servletContext.anonymous) {
			log.error "Anonymous user not found!\nPlease defines an anonymous user with email anonymous@anonymous.com in BootStrap.groovy"
		    }
		}

		if(!session.user) {
		    session.user = servletContext.anonymous
		}
                if (servletContext.anonymous?.email.equals(session.user?.email) && controllerName && actionName 
		    && !controllerName.equals("authentication") && 
		    !authorizationService.isAllowed(session.user, controllerName, actionName)) {
		    log.debug "controllerName = ${controllerName}, actionName = ${actionName}"
		    log.debug "request.forwardURI = ${request.forwardURI}"
		    session.lastAccessURI = request.forwardURI
		    redirect(controller:"authentication", action:"login")
                    return false
                }               
            }
            after = {
                
            }
            afterView = {
                
            }
        }

        authorization(controller:'*', action:'*') {
            before = {
		boolean isAllowed = true
	        if (!servletContext.anonymous?.email.equals(session.user?.email) && 
		     controllerName && actionName && !controllerName.equals("authentication")) {
		    log.debug "controllerName = ${controllerName}, actionName = ${actionName}"
                    isAllowed = authorizationService.isAllowed(session.user, controllerName, actionName)
		} 
		log.debug "isAllowed = ${isAllowed}"
		if (!isAllowed) {
		   response.sendError 401 // Unauthorized
		   return isAllowed
		}
            }

            after = {
                
            }
            afterView = {	
            }
        }

        audit(controller:'*', action:'(save|update)') {
            before = {
		if (!servletContext.anonymous.email.equals(session.user.email)) {
		    if (actionName?.equals("save")) {
			params["createdBy"] = session.user.email
		    } else {
			params["lastUpdatedBy"] = session.user.email
		    }
		}
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
}
