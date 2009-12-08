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

class BootStrap {
     def grailsApplication

     def init = { servletContext ->
         // Workaround to a nasty Grails 1.1.1 bug: groovy.lang.MissingPropertyException
	 // URL: http://blog.peterdelahunty.com/2009/07/workaround-to-nasty-grails-111-bug.html
         // grailsApplication.domainClasses.each{
         //   def clazz = it.clazz
         //        println "Clazz: $clazz count: " + clazz.count();
         // }

     }

     def destroy = {
     }

} 