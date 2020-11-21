Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D22BBBFE
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgKUCDT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKUCDS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57358C061A47
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so14386485ybq.4
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kkvUYmRSkidNjkTq5GwniBTGKUzDD8tYACZuHPPCtMw=;
        b=C0huOxQfOFIYkmZ5+j5wBG0r+aPmC4/UZ/pyjY13Gqsre385QtU5zpSWQqtLiSK4EC
         DJG49WcUPSMz92mQT8T6Zxckt93Reu6GEAXQO+yNjstfjcXyxQjhricoR5vmJydKCcqT
         W4clRYgmd/+H2PBfwwmEL54kIktmgWsA2vP0leAI328J0tvhKucVE1oyV3otEuzsze0Q
         VxogMphFyQZJGHwXst43+T9wmNbXvyaJUnMaHAlVZFg7Dlf369VoYCx4YlanCeqOPXku
         rlUsaqd6kIfaZWYKUJgQQ6H994f73Sx5bSOOmMPSW62bBO/93wbtorcE7/iH0aY3VEOj
         CZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kkvUYmRSkidNjkTq5GwniBTGKUzDD8tYACZuHPPCtMw=;
        b=Sv91sTw4SLTQwex09kjY3GKFVkPLNM5vNesSW+CzbyX3AEBbzB5vODMUgUdIe/FyI1
         PqLZcD4L+BP1LHgzSnazDr7Y6dhf1dAHMv4F617mI0rkqkk12RfIDc6qzGZm8ZwIsty2
         YxGNcjHZc4iSNtIPAsjOqddT2bfhq59edASL3f/gxa+8XzcmmM+O/J4t+SW71E/XGFMZ
         0UfXmzrvtHgWB8DY2mRb6cc/yvz3Cl0Z/xdGQte3wH9sFsrBRW/bFouSzRFxyiEAV0Rc
         oxrxbG4l6Ama2BW5KwaDq81DMeZXacop8JoFk2RT6/RlDl5SqSS59M8sTjUG0dChOzvZ
         zKOA==
X-Gm-Message-State: AOAM532XJGv9hfMkivjpVJiCP1r7i88vy4uv5fs1ChVLkUE04hgZIP8p
        HrVkH07r1HpJVFQUBxxs7P/2H9N8XGD+xhk=
X-Google-Smtp-Source: ABdhPJyV9Uoir3KqyP3MamhCm8qYOnpgbNbEd6xLZ5JjffYqgi0HKnViyZWiFepF+7Lo7+787hyZ2uVL7R2L6mw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:2a4b:: with SMTP id
 q72mr34851917ybq.385.1605924195519; Fri, 20 Nov 2020 18:03:15 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:27 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-13-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 12/17] driver core: Add fw_devlink_parse_fwtree()
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

This function is a wrapper around fwnode_operations.add_links().

This function parses each node in a fwnode tree and create fwnode links
for each of those nodes. The information for creating the fwnode links
(the supplier and consumer fwnode) is obtained by parsing the properties
in each of the fwnodes.

This function also ensures that no fwnode is parsed more than once by
marking the fwnodes as parsed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 19 +++++++++++++++++++
 include/linux/fwnode.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 215ce9e72790..395dece1c83a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1544,6 +1544,25 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
 }
 
+static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
+{
+	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
+		return;
+
+	fwnode_call_int_op(fwnode, add_links, NULL);
+	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
+}
+
+static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child = NULL;
+
+	fw_devlink_parse_fwnode(fwnode);
+
+	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+		fw_devlink_parse_fwtree(child);
+}
+
 static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 942a6bb18201..ffa9129182a6 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,12 +15,20 @@
 struct fwnode_operations;
 struct device;
 
+/*
+ * fwnode link flags
+ *
+ * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
+ */
+#define FWNODE_FLAG_LINKS_ADDED		BIT(0)
+
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
+	u8 flags;
 };
 
 struct fwnode_link {
-- 
2.29.2.454.gaff20da3a2-goog

