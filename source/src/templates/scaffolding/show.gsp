%{--
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
 */
--}%

<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show ${className}</title>
    </head>
    <body>
        <div class="nav">
            <h1 class="heading1">Show ${className}</h1>
            <span class="menuButton"><g:link class="list" action="list">${className} List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New ${className}</g:link></span>
        </div>
        <div class="body">
            
        <div class="clear span-20 append-4 last">
		  <fieldset>
		   <g:if test="\${session.message}">
			<div class="notice">\${session.message}</div>
			<g:set var="message" value="null" scope="session" />
		   </g:if>

                    <%
                    excludedProps = ['version',
                                      'onLoad',
				      'beforeInsert',
				      'beforeDelete',
				      'beforeUpdate',
				      'afterInsert',
				      'afterUpdate',
				      'afterDelete']
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> %>
                        <p>
                            <label>${p.naturalName}:</label>
                            <% if(p.isEnum()) { %>
                                \${${propertyName}?.${p.name}?.encodeAsHTML()}&nbsp;
                            <% } else if(p.oneToMany || p.manyToMany) { %>
                                <ul>
                                <g:each var="${p.name[0]}" in="\${${propertyName}.${p.name}}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            <%  } else if(p.manyToOne || p.oneToOne) { %>
                                <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>
                            <%  } else  { %>
                                \${fieldValue(bean:${propertyName}, field:'${p.name}')}&nbsp;
                            <%  } %>
                        </p>
                    <%  } %>
	    <p>
		<label>&nbsp;</label>
                <g:form>
                    <input type="hidden" name="id" value="\${${propertyName}?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </p>
	    </fieldset>
        </div>
    </body>
</html>
