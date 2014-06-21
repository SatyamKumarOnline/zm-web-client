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
 * This class is the event object send when the BeforeExecCommand and ExecCommand event occurs.
 *
 * @class tinymce.CommandEvent
 * @extends tinymce.Event
 * @example
 * tinymce.activeEditor.on('ExecCommand', function(e) {
 *     console.log(e.command, e.ui, e.value);
 * });
 */

/**
 * Name of the command to execute.
 *
 * @property {String} command
 */

/**
 * User interface state. Normally false.
 *
 * @property {Boolean} ui User interface state.
 */

/**
 * Value object for the execCommand call.
 *
 * @property {Object} value
 */
