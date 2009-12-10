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

    <g:form name="login" controller="authentication" action="authenticate" method="post" >
	  <div id="email">
	   <label for="email-field" class="overlabel">Email</label>
	   <input id="email-field" type="text" name="email" title="Email" value="" tabindex="1"/>
	  </div>
	  <div id="password">
	   <label for="password-field" class="overlabel">Password</label>
	   <input id="password-field" type="password" name="password" title="Password" value="" tabindex="2" autocomplete="off"/>
	  </div>
	  <div id="submit">
	    <input type="submit" name="submit" value="Login" tabindex="3" />
	  </div>
    </g:form>