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
 
<%@ page import="com.vobject.security.Role" %>
<%@ page import="grails.util.GrailsNameUtils" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Role</title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'custom-checkbox.css')}" type="text/css" media="screen, projection"/>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('ul').addClass('holder');
	    $('ul li').addClass('bit-displaybox');	
	});
	</script>
    </head>
    <body>
        <div class="nav">
	    <h1 class="heading1">Show Role</h1>
            <span class="menuButton"><g:link class="list" action="list">Role List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Role</g:link></span>
        </div>
        <div class="clear span-20 append-4 last">
	  <fieldset>
	    <div class="clear span-19 last">
		<g:if test="${session.message}">
		    <div class="notice">${session.message}</div><% session.message = null %>
		</g:if>
	    </div>
	    <p>
		<label for="name">Name:</label>
		${fieldValue(bean:roleInstance, field:'name')}&nbsp;
	    </p>
	    <p>
		<label for="description">Description:</label>
		${fieldValue(bean:roleInstance, field:'description')}&nbsp;                     
	    </p>
	    <p>
		<label>Permissions:</label>
		<div class="clear span-19 last list">
		<table>
		<tr><th>Module</th><th>Action Allowed</th></tr>
		<g:set var="exceptedControllers" value="${grailsApplication.config.vobject.security.permission.exceptedControllers}" />
		<g:each var="c" in="${grailsApplication.controllerClasses.sort{it.name}}"> 
		    <g:if test="${!exceptedControllers.contains(c.name)}">
			    <tr>
				<td>${GrailsNameUtils.getNaturalName(c.name)}</td>
				<td>
				<div class="custom_checkbox"><ul>
				<%
				def filterClosure = { permission, param -> permission.controller.equalsIgnoreCase(param.controller) }
				%>
				<g:each var="action" in="${roleInstance.permissions.findAll(filterClosure.curry([controller:c.name]))*.action.sort()}">
				   <li><span>${GrailsNameUtils.getNaturalName(action)}</span></li>
				</g:each>
				</td>
				</ul></div>
			    </tr>
		    </g:if>
		</g:each>
		</table>
		</div>
	    </p>
	    <p>
		<label for="createdBy">Created By:</label>
		${fieldValue(bean:roleInstance, field:'createdBy')}&nbsp;
	    </p>
	    <p>
		<label for="dateCreated">Date Created:</label>
		${fieldValue(bean:roleInstance, field:'dateCreated')}&nbsp;
	    </p>
	    <p>
		<label for="name">Last Updated By:</label>
		${fieldValue(bean:roleInstance, field:'lastUpdatedBy')}&nbsp;
	    </p>
	    <p>
		<label for="name">Last Updated:</label>
		${fieldValue(bean:roleInstance, field:'lastUpdated')}&nbsp;
	    </p>
	    <p>
		<label>&nbsp;</label>
		<g:form>
		    <input type="hidden" name="id" value="${roleInstance?.id}" />
		    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
		    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
		</g:form>
	    </p>
	</fieldset>
        </div>
    </body>
</html>
