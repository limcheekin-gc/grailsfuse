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
 
<%@ page import="com.vobject.security.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit User</title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox.css')}" type="text/css" media="screen, projection"/>
	<!--[if IE]><link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox-ie.css')}" type="text/css" media="screen, projection"/><![endif]-->
	<script src="${resource(dir:'js',file:'custom-checkbox.js')}" type="text/javascript"></script>
    </head>
    <body>
        <div class="nav">
            <h1 class="heading1">Edit User</h1>
            <span class="menuButton"><g:link class="list" action="list">User List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New User</g:link></span>
        </div>
        <div class="clear span-20 append-4 last">
            <g:form method="post" >
		<fieldset>
		<div class="clear span-19 last">
		    <g:if test="${session.message}">
		    <div class="notice">${session.message}</div><% session.message = null %>
		    </g:if>
		    <g:hasErrors bean="${userInstance}">
		    <div class="error">
			<g:renderErrors bean="${userInstance}" as="list" />
		    </div>
		    </g:hasErrors>
		</div>
                <input type="hidden" name="id" value="${userInstance?.id}" />
                <input type="hidden" name="version" value="${userInstance?.version}" />
		    <p>
		        <label for="email">Email:</label>
		        <input type="text" id="email" name="email" value="${fieldValue(bean:userInstance,field:'email')}" size="50" maxlength="50"/>
		    </p>
		    <p>
		        <label for="name">Name:</label>
		        <input type="text" id="name" name="name" value="${fieldValue(bean:userInstance,field:'name')}" size="50" maxlength="50"/>
		    </p>
		    <p>
		        <label for="roleIds">Roles:</label>
			<div class="custom_checkbox">
		        <ul>   
			    <g:each status="i" in="${com.vobject.security.Role.list()}" var="role">
				<li><g:checkBox name="roleIds" value="${role.id}" checked="${userInstance.roleIds?.contains(role.id)}"/>${role.name}</li>
			    </g:each>
                        </ul>
			</div>
		    </p>
		    <p>
			<label>&nbsp;</label>
			<g:actionSubmit class="save" value="Update" />
			<g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" />
		    </p>
		</fieldset>
            </g:form>
        </div>
    </body>
</html>
