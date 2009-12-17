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
<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder" %>


<html>
    <head>
        <title><g:layoutTitle default="Grails" /> | VObject GrailsFuse</title>
	<!-- Framework CSS -->
	<link rel="stylesheet" href="${resource(dir:'css',file:'screen.css')}" type="text/css" media="screen, projection"/>
	<link rel="stylesheet" href="${resource(dir:'css',file:'fancy-type.css')}" type="text/css" media="screen, projection"/>
	<link rel="stylesheet" href="${resource(dir:'css',file:'print.css')}" type="text/css" media="print"/>
	<!--[if IE]><link rel="stylesheet" href="${resource(dir:'css',file:'ie.css')}" type="text/css" media="screen, projection"/><![endif]-->
	<!-- Application CSS: should put after Framework CSS -->
	<link rel="stylesheet" href="${resource(dir:'css',file:'application.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'login.css')}" />
        <!--[if IE]><link rel="stylesheet" href="${resource(dir:'css',file:'login-ie.css')}" type="text/css" media="screen, projection"/><![endif]-->	
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <script src="${resource(dir:'js',file:'jquery-1.3.2.min.js')}" type="text/javascript"></script>
	<script src="${resource(dir:'js',file:'login.js')}" type="text/javascript"></script>	
	<script src="${resource(dir:'js',file:'toggle-blueprint-grid.js')}" type="text/javascript"></script>
        <g:javascript library="application" />	
	<!-- Used for Sharing. eg: Facebook Begin -->
	<meta name="title" content="<g:layoutTitle default="Grails" /> | VObject GrailsFuse" /> 
	<meta name="description" content="Jump Start Grails Application on Google App Engine!" /> 
	<link rel="image_src" href="${resource(dir:'images',file:'vobject_logo.png')}" />
	<!-- Used for Sharing. End -->
	<g:layoutHead />

	<!-- Google Analytics Start -->
	<script type="text/javascript">
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<!-- Google Analytics End -->

	<!-- AddThis Button Start: Integration with Google Analytics -->
	<script type="text/javascript">
	   var addthis_config = {
	      data_ga_tracker: "pageTracker"
	   };
	</script>
        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pub=grailsfuse"></script>
	<!-- AddThis Button End -->

	<script type="text/javascript">
	$(document).ready(function() {
	    // Google Analytics tracking code
	    try {
		var pageTracker = _gat._getTracker("${ConfigurationHolder.config.vobject.grailsfuse.googleAnalyticsTrackingCode}");
		pageTracker._trackPageview();
	    } catch(err) {}

	});
	</script>
	<!--CSS testbox-->
	<style type="text/css">	
	</style>

    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>	
	<g:isLoggedIn>
	<div id="top_nav">
	      <a class="home" href="/index.gsp"><img src="${resource(dir:'images',file:'skin/house.png')}"/>Home</a>
	      <g:each var="c" in="${grailsApplication.controllerClasses}">
		 <g:isAllowed controller="${c.logicalPropertyName}" action="index">
		    <g:link controller="${c.logicalPropertyName}">${GrailsNameUtils.getNaturalName(c.name)}</g:link>
		 </g:isAllowed>
	       </g:each>
	</div>
	<g:loginInfoPanel />
	<div id="top_nav_border">&nbsp;</div>
        </g:isLoggedIn>
	
	<div class="container">
          <div class="clear span-24 last">
		<!-- AddThis Button BEGIN -->
		<!-- Subscribe Button: NOT READY YET 
		<a class="addthis_button_style" href="http://www.addthis.com/feed.php?pub=grailsfuse&amp;h1=http%3A%2F%2Fgrailsfuse.vobject.com&amp;t1=" 
		onclick="return addthis_open(this, 'feed', 'http://grailsfuse.vobject.com')" alt="Subscribe using any feed reader!" target="_blank">
		<img src="http://s7.addthis.com/static/btn/sm-feed-en.gif" width="83" height="16" alt="Subscribe"/></a>
		-->
		<!-- Share Button -->
		<a class="addthis_button addthis_button_style" href="http://www.addthis.com/bookmark.php?v=250&amp;pub=grailsfuse">
		<img src="http://s7.addthis.com/static/btn/sm-share-en.gif" width="83" height="16" 
		alt="Bookmark and Share"/></a>
		<!-- AddThis Button END -->
	  </div>
	  <div id="logoPanel" class="span-13">	
	      <div id="logo">
	      <a class="home" href="/index.gsp">
	        <img src="${resource(dir:'images',file:'vobject_logo.png')}" alt="VObject" border="0"/></a>
              </div> 
	      <div id="app_name">GrailsFuse</div>
	      <div id="app_version"> v<g:meta name="app.version"/></div> 
	  </div>
	  <div class="span-11 last"><g:compactLoginForm /></div>
	  <div class="clear span-24 last"><h2 class="alt">Jump Start Grails Application on Google App Engine!</h2></div>
	  <div class="clear span-24 last"><g:layoutBody /></div>
	  <div class="clear span-24 last">&nbsp;</div>
	  <div class="clear span-24 last footer">
	       <a href="http://twitter.com/grailsfuse"><img height="30" src="${resource(dir:'images',file:'twitter.png')}" border="0"/></a>
	       <a href="http://code.google.com/p/grailsfuse"><img width="120" height="30" src="http://code.google.com/images/code_logo.png" border="0"/></a>
	       <a href="http://appengine.google.com"><img width="120" height="30" src="${resource(dir:'images',file:'appengine.gif')}" border="0"/></a>
	       <a href='' id='togglegrid'></a>
	       <p>&copy;2009 VObject | <a href="http://mailhide.recaptcha.net/d?k=01J5BajOZfpt_1LnKl3Y1LZQ==&amp;c=NVJrSjPZ7WLETT-c78s_Md-0Q2nUJ3rUZop1u-YhX1w=" onclick="window.open('http://mailhide.recaptcha.net/d?k=01J5BajOZfpt_1LnKl3Y1LZQ==&amp;c=NVJrSjPZ7WLETT-c78s_Md-0Q2nUJ3rUZop1u-YhX1w=', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=300'); return false;" title="Reveal this e-mail address">Contact Us</a></p>
	  </div>
	</div>		
    </body>	
</html>