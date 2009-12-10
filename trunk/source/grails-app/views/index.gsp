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

<html>
    <head>
        <title>Jump Start Grails Application on Google App Engine!</title>
	<meta name="layout" content="main" />
    </head>
    <body>
       <div class="span-14">	    
           <iframe src="http://docs.google.com/present/embed?id=ddfh8dm9_653t2szcm&interval=30&size=m" 
	           frameborder="0" width="550" height="451"></iframe>
       </div>
       <div class="span-10 last">
           <div class="info">
	      <strong>Login as Admin User:</strong><br />
	      <ul>
		<li>Email: grailsfuse@vobject.com</li>
		<li>Password: grailsfuse</li>
	      </ul>

	      <strong>Login as Normal User:</strong><br />
	      <ul>
		<li>Email: user1@vobject.com</li>
		<li>Password: user1</li>
	      </ul>
	   </div>
           <div class="info">
	      <p<a href="http://www.grails.org"><strong>Grails Framework</strong></a><strong>: <g:meta name="app.grails.version"/></strong></p>
	      <strong>Plugins Used:</strong>
	      <g:renderInstalledPlugins as="list" showLink="true"/>
	   </div>
           <div class="info">
	      <strong>Other Tools:</strong>
	      <ul>
	         <li>CSS Framework: <a href="http://www.blueprintcss.org/">Blueprint</a> 0.9.1</li>
		 <li>Javascript Library: <a href="http://jquery.com/">JQuery</a> 1.3.2</li>
	      <ul>
	   </div>
       </div>
    </body>
</html>