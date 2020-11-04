Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDB2A71A7
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgKDXZ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733054AbgKDXY2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C0C0613D3
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so376590ybq.21
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eEB1sRKmOhyKT2s+qdOFoinbYDGAwcO7NeYhfFMxg+Q=;
        b=tUt9OmDwJhcPPhrZNj/nqogKhaEd+90/qdGhb2nTA+Yz2dfpD3noSnHhMam2QzHPjo
         9qQ5kwHjM9vLUYpIr7v/CJdtGPmYJF1F9ydUaH4foaY72lus5HdCCq1ZIuU/mN1WiLQY
         Rrmabtm+iFFUQLIHiC/CR8s53IYF8R3pqCP65NUS7O7coMjWE4Gi0OUhK1LawZAYrjAr
         LNWhrQdANyVNdGRQ4+lXoU03/4t+zBhZkSb9LJtFWyQ2RjmF6L74Et5xHuwPRcJOMP1Z
         rv3lHcS4gvr/Tmn8+aT/QZWr3/8fKJeA+W5S/l+iPmK7Q6tS1+T/ImK9dzpcjai2Eamh
         ZJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eEB1sRKmOhyKT2s+qdOFoinbYDGAwcO7NeYhfFMxg+Q=;
        b=AXQu746nFqTCm7MTJWCmWVKVkJPTXlFx/U8kHSpGN1WlKtumqsqW/vHF1uPimmYEuR
         i1bif30IPgVInoSjaLVPpqCLtYlr73oN32+cZR2mlVWha2rVkZacNyvKhAdeW3/aby42
         yVmK0Ag9evu7d3yP+C7U3LCwbp0FdIDpKStrlFeqljlUXwgFOXJnRZbf7ZDny7KR5y4A
         tkPy7hzz49uNf2PLLfJec1PeQOeKbTKhnn/V5pn2vghC01UETd9gYxI9e0DG3rewJsqa
         zksr3UYfAnsQPR8cSObxNNOwJeDcMT3Ti2qxUzYOH193V8mu+Bkkob1oeXonD+TiPG8V
         ku6g==
X-Gm-Message-State: AOAM532tQgdHciwzg8mjzBtWNorW3PSryWZpaFokT+NR40kcJw1RQHr5
        fPqw2/94wFq0tbjFgZWrm9HElPhDafRFvTw=
X-Google-Smtp-Source: ABdhPJyWG5sGSzNmiRsHspbl4ooUVxIy7YNp80HOw5IVvMiRQ3hDfPGnRagU2OxiQKt1apMgzfktCFp+7Ba3Uuo=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:b792:: with SMTP id
 n18mr294244ybh.93.1604532267406; Wed, 04 Nov 2020 15:24:27 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:48 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-12-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 11/18] driver core: Redefine the meaning of fwnode_operations.add_links()
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
 include/linux/fwnode.h | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index afde643f37a2..ec02e1e939cc 100644
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
2.29.1.341.ge80a0c044ae-goog

