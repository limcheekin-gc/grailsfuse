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
        <title>Login</title>         
    </head>
    <body>
        <div class="span-6">&nbsp;</div>
	<div class="span-12">
            <g:form name="login" action="authenticate" method="post" >
		<fieldset>
		<legend>Login</legend>
	    <g:if test="${session.message}">
	        <div class="${session.messageClass}">${session.message}</div>
	        <% session.message = null; 
	           session.messageClass = null; %>
	    </g:if>
	    <g:hasErrors bean="${userInstance}">
	    <div class="error">
		<g:renderErrors bean="${userInstance}" as="list" />
	    </div>
	    </g:hasErrors>
		<p>
                   <label for="email">Email:</label>
                   <input type="text" id="email-field" name="email" value="${fieldValue(bean:userInstance,field:'email')}"/>
                </p>        
		<p>
                   <label for="password">Password:</label>
                   <input type="password" id="password-field" name="password" value="" autocomplete="off"/>
		</p>
		<p>
		   <label for="submit"></label>
		   <input id="submit" type="submit" value="Login" />
		</p>
		</fieldset>
            </g:form>
        </div>
	<div class="span-6 last">&nbsp;</div>
    </body>
</html>
