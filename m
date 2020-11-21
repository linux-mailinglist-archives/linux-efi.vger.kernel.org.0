Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83A2BBBFA
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgKUCDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgKUCDN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEEC0613CF
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so14117208ybs.8
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/LX9bJeHDDRylfNoVob87S2JlPxG5ImJS2h+ELTJVqI=;
        b=bB0A+R+G6PXveAVwcws7Z6i0PtnRk1Y3WmrGqeK19Oc30MPDpg5PLW8RW/9lvTNJ7X
         ZRTtvAXOk6zLLS0tWgmBiPMaXiHdzk5JqHUFBWNxyBSg0jQM1byyfIeB9eYkfVuzKhr1
         X8ympijJHD7vExfoFyae6VvOI8Vx9VEFLgHHb0qBUNp2851U9GaspjHNdIxtBPBZYWWw
         5ZgYR0vIK29DD9C+3cXe7HhXkzFBfkgliAr3qx4BD+Q87nz5OaTd9d2HZNawReGOZWFZ
         4mRpulnPz5jPrf7xmdDNz/I/sOI1/6e8gnFM8roDKA1AsSml5IDh2Ec3EyYQQ94+kKeP
         IerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/LX9bJeHDDRylfNoVob87S2JlPxG5ImJS2h+ELTJVqI=;
        b=RrThXswcUgfa7coGB9HxEsgBMYil0EEMhB7/+VwGD1icS71S1cKbF9XK3B5qbY3s2e
         +e7pG8N6ANx7c4k7Bhghy7w1dxqb385YleMPqrZro7i08A93NQoQdVi37iEZf8tXfFl+
         DLzb+OMX+H2c9tVT9lZzUNUZbXZlA+yuLxhAJAtqFT16XCXPNL8q4ifigmdeuT3e7I1+
         QsbODmXhxBIV54qn8OGdtbwil3EV4CipKFjXE3Vo6DocvZFjZv/glUbg8WLXed08weUq
         IYWKQrSPTCIeHTMxzgq3qIipJt/QNDCT9u/i0o9qqeo+XnSkLrV34eY47vKTVMjezh2c
         Zfgw==
X-Gm-Message-State: AOAM531USP0nk5iH5c+0UtPYDQwaco4qlfGxU9HEBjGBe5VB2k+VriEQ
        bG3Qo0iul17JnaipgDTQXwlpbP0Ame5IYLc=
X-Google-Smtp-Source: ABdhPJwpPqnlFJLkUZfisNfpE1+K8M+fKGEWW7MXjBtNcZY6hW80Mcdvb9sW2hFXXDlIpR63mRRi+3x532QOhRc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:4943:: with SMTP id
 w64mr21803030yba.178.1605924192912; Fri, 20 Nov 2020 18:03:12 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:26 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-12-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 11/17] driver core: Redefine the meaning of fwnode_operations.add_links()
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Change the meaning of fwnode_operations.add_links() to just create
fwnode links by parsing the properties of a given fwnode.

This patch doesn't actually make any code changes. To keeps things more
digestable, the actual functional changes come in later patches in this
series.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/firmware/efi/efi-init.c |  2 +-
 include/linux/fwnode.h          | 42 +++------------------------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b148f1459fb3..65bb97c391b0 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -316,7 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
  * resource reservation conflict on the memory window that the efifb
  * framebuffer steals from the PCIe host bridge.
  */
-static int efifb_add_links(const struct fwnode_handle *fwnode,
+static int efifb_add_links(struct fwnode_handle *fwnode,
 			   struct device *dev)
 {
 	struct device_node *sup_np;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index b88365187347..942a6bb18201 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -78,44 +78,8 @@ struct fwnode_reference_args {
  *			       endpoint node.
  * @graph_get_port_parent: Return the parent node of a port node.
  * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
- * @add_links:	Called after the device corresponding to the fwnode is added
- *		using device_add(). The function is expected to create device
- *		links to all the suppliers of the device that are available at
- *		the time this function is called.  The function must NOT stop
- *		at the first failed device link if other unlinked supplier
- *		devices are present in the system.  This is necessary for the
- *		driver/bus sync_state() callbacks to work correctly.
- *
- *		For example, say Device-C depends on suppliers Device-S1 and
- *		Device-S2 and the dependency is listed in that order in the
- *		firmware.  Say, S1 gets populated from the firmware after
- *		late_initcall_sync().  Say S2 is populated and probed way
- *		before that in device_initcall(). When C is populated, if this
- *		add_links() function doesn't continue past a "failed linking to
- *		S1" and continue linking C to S2, then S2 will get a
- *		sync_state() callback before C is probed. This is because from
- *		the perspective of S2, C was never a consumer when its
- *		sync_state() evaluation is done. To avoid this, the add_links()
- *		function has to go through all available suppliers of the
- *		device (that corresponds to this fwnode) and link to them
- *		before returning.
- *
- *		If some suppliers are not yet available (indicated by an error
- *		return value), this function will be called again when other
- *		devices are added to allow creating device links to any newly
- *		available suppliers.
- *
- *		Return 0 if device links have been successfully created to all
- *		the known suppliers of this device or if the supplier
- *		information is not known.
- *
- *		Return -ENODEV if the suppliers needed for probing this device
- *		have not been registered yet (because device links can only be
- *		created to devices registered with the driver core).
- *
- *		Return -EAGAIN if some of the suppliers of this device have not
- *		been registered yet, but none of those suppliers are necessary
- *		for probing the device.
+ * @add_links:	Create fwnode links to all the suppliers of the fwnode. Return
+ *		zero on success, a negative error code otherwise.
  */
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
@@ -155,7 +119,7 @@ struct fwnode_operations {
 	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
-	int (*add_links)(const struct fwnode_handle *fwnode,
+	int (*add_links)(struct fwnode_handle *fwnode,
 			 struct device *dev);
 };
 
-- 
2.29.2.454.gaff20da3a2-goog

