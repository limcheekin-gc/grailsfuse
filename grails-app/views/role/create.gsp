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

<%@ page import="grails.util.GrailsNameUtils" %>
<%@ page import="com.vobject.security.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Role</title>      
	<link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox.css')}" type="text/css" media="screen, projection"/>
	<!--[if IE]><link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox-ie.css')}" type="text/css" media="screen, projection"/><![endif]-->
	<script src="${resource(dir:'js',file:'custom-checkbox.js')}" type="text/javascript"></script>	
    </head>
    <body>
        <div class="nav">
            <h1 class="heading1">Create Role</h1>
            <span class="menuButton"><g:link class="list" action="list">Role List</g:link></span>
        </div>
        <div class="clear span-20 append-4 last">

            <g:form action="save" method="post" >
		  <fieldset>
		    <div class="clear span-19 last">
			<g:if test="${session.message}">
			    <div class="notice">${session.message}</div><% session.message = null %>
			</g:if>
			<g:hasErrors bean="${roleInstance}">
			    <div class="error">
				<g:renderErrors bean="${roleInstance}" as="list" />
			    </div>
			</g:hasErrors>
		    </div>

		    <p>
		        <label for="name">Name:</label>
			<input type="text" id="name" name="name" 
			value="${fieldValue(bean:roleInstance,field:'name')}" 
			size="50" maxlength="50" />
		    </p>
		    <p>
		        <label for="description">Description:</label>
			<input type="text" id="description" name="description" 
			value="${fieldValue(bean:roleInstance,field:'description')}" 
			size="50" maxlength="50" />                         
		    </p>
		    <p>
		        <label>Permissions:</label>
			<div class="clear span-19 last list">
			<table>
			<tr><th>Module</th><th>Action Allowed</th></tr>
			<g:set var="exceptedControllers" value="${grailsApplication.config.vobject.security.permission.exceptedControllers}" />
			<g:set var="exceptedActions" value="${grailsApplication.config.vobject.security.permission.exceptedActions}" />
			<g:set var="exceptedControllerActions" value="${grailsApplication.config.vobject.security.permission.exceptedControllerActions}" />
			<g:each var="c" in="${grailsApplication.controllerClasses.sort{it.name}}"> 
			    <g:if test="${!exceptedControllers.contains(c.name)}">
				    <tr>
					<td>${GrailsNameUtils.getNaturalName(c.name)}</td>
					<td>
					<% def actions = [] %>	
					<g:each var="uri" in="${c.URIs}">
					 <%  
					     def action = c.getClosurePropertyName(uri)
					     if (!uri.endsWith("/**") && 
						!exceptedActions.contains(action) && 
						!exceptedControllerActions.contains("${c.name}.${action}".toString())) 
						actions << action 
					 %>	
					</g:each>
					<g:set var="sortedUniqueActions" value="${actions.unique().sort()}" />
					<g:set var="controllerName" value="${c.name.toLowerCase()}" />
					<div class="custom_checkbox"><ul>
					<g:each var="action" in="${sortedUniqueActions}">
				            <li><g:checkBox name="${controllerName}" value="${action}" checked="false"/>${GrailsNameUtils.getNaturalName(action)}</li>						    
					</g:each>
					</ul></div>
					</td>
				    </tr>
			    </g:if>		
			</g:each>
			</table>
			</div>
		    </p>
		    <p>
			<label>&nbsp;</label>
		        <input class="save" type="submit" value="Create" />
		    </p>
		</fieldset>
            </g:form>
        </div>
    </body>
</html>
