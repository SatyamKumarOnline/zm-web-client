/*
 * ***** BEGIN LICENSE BLOCK *****
 * 
 * Zimbra Collaboration Suite Web Client
 * Copyright (C) 2014 Zimbra, Inc.
 * 
 * The contents of this file are subject to the Common Public Attribution License Version 1.0 (the “License”);
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at: http://www.zimbra.com/license
 * The License is based on the Mozilla Public License Version 1.1 but Sections 14 and 15 
 * have been added to cover use of software over a computer network and provide for limited attribution 
 * for the Original Developer. In addition, Exhibit A has been modified to be consistent with Exhibit B. 
 * 
 * Software distributed under the License is distributed on an “AS IS” basis, 
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. 
 * See the License for the specific language governing rights and limitations under the License. 
 * The Original Code is Zimbra Open Source Web Client. 
 * The Initial Developer of the Original Code is Zimbra, Inc. 
 * All portions of the code are Copyright (C) 2014 Zimbra, Inc. All Rights Reserved. 
 * 
 * ***** END LICENSE BLOCK *****
 */
/**
 * ResizeHandle.js
 *
 * Copyright, Moxiecode Systems AB
 * Released under LGPL License.
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

/**
 * Renders a resize handle that fires ResizeStart, Resize and ResizeEnd events.
 *
 * @-x-less ResizeHandle.less
 * @class tinymce.ui.ResizeHandle
 * @extends tinymce.ui.Widget
 */
define("tinymce/ui/ResizeHandle", [
	"tinymce/ui/Widget",
	"tinymce/ui/DragHelper"
], function(Widget, DragHelper) {
	"use strict";

	return Widget.extend({
		/**
		 * Renders the control as a HTML string.
		 *
		 * @method renderHtml
		 * @return {String} HTML representing the control.
		 */
		renderHtml: function() {
			var self = this, prefix = self.classPrefix;

			self.addClass('resizehandle');

			if (self.settings.direction == "both") {
				self.addClass('resizehandle-both');
			}

			self.canFocus = false;

			return (
				'<div id="' + self._id + '" class="' + self.classes() + '">' +
					'<i class="' + prefix + 'ico ' + prefix + 'i-resize"></i>' +
				'</div>'
			);
		},

		/**
		 * Called after the control has been rendered.
		 *
		 * @method postRender
		 */
		postRender: function() {
			var self = this;

			self._super();

			self.resizeDragHelper = new DragHelper(this._id, {
				start: function() {
					self.fire('ResizeStart');
				},

				drag: function(e) {
					if (self.settings.direction != "both") {
						e.deltaX = 0;
					}

					self.fire('Resize', e);
				},

				stop: function() {
					self.fire('ResizeEnd');
				}
			});
		},

		remove: function() {
			if (this.resizeDragHelper) {
				this.resizeDragHelper.destroy();
			}

			return this._super();
		}
	});
});