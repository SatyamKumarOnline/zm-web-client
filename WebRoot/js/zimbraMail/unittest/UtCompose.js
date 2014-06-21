/*
 * ***** BEGIN LICENSE BLOCK *****
 * Zimbra Collaboration Suite Web Client
 * Copyright (C) 2011, 2012, 2013 Zimbra, Inc.
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
 * All portions of the code are Copyright (C) 2011, 2012, 2013 Zimbra, Inc. All Rights Reserved. 
 * ***** END LICENSE BLOCK *****
 */

UT.module("Compose", ["Mail", "Smoke"]);

// Make sure the compose page comes up when the New button is pressed.
UT.test("Show compose page", {
	
	teardown: function() {
		var cv = UtZWCUtils.getLastView(ZmId.VIEW_COMPOSE)
		var ctlr = cv && cv._controller;
		if (ctlr) {
			ctlr._cancelListener();
		}
	}},
		
	function() {
		UT.expect(1);
		ZmUnitTestUtil.goToCompose();
	
		UT.equal(appCtxt.getCurrentViewType(), ZmId.VIEW_COMPOSE);
	}
);

// Launch New window compose
UT.test("New window compose", {

	teardown: function() {
		ZmZimbraMail.closeChildWindows();
	}},

    // New window compose.
    function() {
        var args = {
            action: ZmOperation.NEW_MESSAGE,
            inNewWindow: true,
            callback: function() {
                UT.ok(true, "New Window Loaded");
                UT.start();
            }
        };
        appCtxt.getApp(ZmApp.MAIL).compose(args);
        UT.stop(10000);
        UT.expect(1);
    }
);
