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
 *
 */

	function createCross(_this, text) {
		var crossPanel = document.createElement('li');
		$(crossPanel).addClass('bit-box');
		var span = document.createElement('span');
		$(span).prepend(text);
		var closeButton = document.createElement('a');
		$(closeButton).addClass('closebutton');
		$(closeButton).click(function(){
			$(this).parent().parent('li').remove();
			$(_this).attr('checked', false);
			$(_this).parent().fadeIn(200);
			return false;
		});
		span.appendChild(closeButton);
		crossPanel.appendChild(span);
	    $(_this).parent().hide();
		$(crossPanel).insertAfter($(_this).parent());
		return crossPanel;
	}

	$(document).ready(function() {
		$('div.custom_checkbox ul').addClass('holder');
		$('div.custom_checkbox ul li').addClass('bit-checkbox');		    
		$('div.custom_checkbox ul li input[type="checkbox"]:checked').each(
			function () {
				var crossPanel = createCross(this, $(this).parent().text());
				$(crossPanel).show();
			}
		);
		$('div.custom_checkbox ul li input[type="checkbox"]').click(
			function (event) {
				var crossPanel = createCross(this, $(this).parent().text());
				$(crossPanel).fadeIn(200);
			}
		);

	});