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
        <title>Show User</title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox.css')}" type="text/css" media="screen, projection"/>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('div.custom_checkbox ul').addClass('holder');
	    $('div.custom_checkbox ul li').addClass('bit-displaybox');	
	});
	</script>    
    </head>
    <body>
        <div class="nav">
	    <h1 class="heading1">Show User</h1>
	    <span class="menuButton"><g:link class="list" action="list">User List</g:link></span>
	    <span class="menuButton"><g:link class="create" action="create">New User</g:link></span>
        </div>
        <div class="clear span-20 append-4 last">
		  <fieldset>
		   <g:if test="${session.message}">
			<div class="notice">${session.message}</div>
			<% session.message = null; %>
		   </g:if>
		    <p class="clear">
		        <label>Email:</label>
			${fieldValue(bean:userInstance, field:'email')}
		    </p>
		    <p class="clear">
			<label>Name:</label>${fieldValue(bean:userInstance, field:'name')}
		    </p>
		    <p>
			<label>Roles:</label>
		        <div class="custom_checkbox">
			<ul>
			<g:each var="role" in="${userInstance.roles}">
			    <li><span><g:link controller="role" action="show" id="${role.id}" title="${fieldValue(bean:role, field:'description')}">
			    ${fieldValue(bean:role, field:'name')}</g:link></span></li>
			</g:each>
			</ul>
			</div>
		    </p>
		    <p>
		        <label>Created By:</label>
			${fieldValue(bean:userInstance, field:'createdBy')}
		    </p>
		    <p>
		        <label>Date Created:</label>
			${fieldValue(bean:userInstance, field:'dateCreated')}
		    </p>
		    <p>
		        <label>Last Updated By:</label>
			${fieldValue(bean:userInstance, field:'lastUpdatedBy')}&nbsp;
		    </p>
		    <p>
		        <label>Last Updated:</label>
			${fieldValue(bean:userInstance, field:'lastUpdated')}&nbsp;
		    </p>
		    <p>
			<label>&nbsp;</label>
			<g:form>
			    <input type="hidden" name="id" value="${userInstance?.id}" />
			    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
			    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
			</g:form>
		    </p>
		</fieldset>
        </div>
    </body>
</html>
