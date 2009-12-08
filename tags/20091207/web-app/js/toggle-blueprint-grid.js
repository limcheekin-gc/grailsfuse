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
 * Reference: Toggle Blueprint CSS Grid: http://tomster.org/blog/archive/2008/04/26/blueprint-css-jquery/
 * Usage: put tag "<a href='' id='togglegrid' />" to the html page 
 *
 */

	$(document).ready(function() {
		$("#togglegrid").append(gridImage());
		$("#togglegrid").click(toggle_grid);
	});

	function toggle_grid () {
		$(".container").toggleClass("showgrid");
		$("#togglegrid img").replaceWith(gridImage());

		return false;
	}

	function gridImage() {
		var image = document.createElement('img');
		$(image).attr('border', 0);
		if ($(".container").hasClass("showgrid")) {
			$(image).attr('src', '/images/grid-off.png');
		} else {
			$(image).attr('src', '/images/grid-on.png');
		}

		return image;
	}