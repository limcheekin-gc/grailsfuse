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

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class GrailsFuseTagLib {

    def renderInstalledPlugins = { attrs, body ->
        String grailsPluginUrl = CH.config.vobject.grailsfuse.grailsPluginUrl?:"http://www.grails.org/plugin/"
   	if (attrs.as?.equals("paragraph")) {
	    grailsApplication.metadata.each { k, v ->
		if (k.startsWith("plugins.")) {
		   out << "<p>"
		   if (attrs.showLink) {
		      out << "<a href=\"${grailsPluginUrl}${k.substring(8)}\">"
		   }
		   out << k.substring(8)
		   if (attrs.showLink) {
		      out << "</a>"
		   }
		   out << ": ${v}</p>"
		}
	    }
	} else {
	    out << "<ul>"
	    grailsApplication.metadata.each { k, v ->
		if (k.startsWith("plugins.")) {
		   out << "<li>"
		   if (attrs.showLink) {
		      out << "<a href=\"${grailsPluginUrl}${k.substring(8)}\">"
		   }
		   out << k.substring(8)
		   if (attrs.showLink) {
		      out << "</a>"
		   }
		   out << ": ${v}</li>"
		}
	    }
	    out << "</ul>"
	}
    }
}
