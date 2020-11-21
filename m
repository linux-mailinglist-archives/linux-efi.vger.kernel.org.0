Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A672BBC12
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKUCDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgKUCD3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6725DC061A47
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m186so14133732ybm.22
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/4b98HN7Dg/gsZp1FJDKtTqc5+TRGSRPQQAwQrD06k0=;
        b=ELFquWWmVQsPKcB73FJvKB8rjQRr79nN6pXIgdOw3TJNpJs/SGo0AHl0FEmMW05BRV
         Xes5u0tIB4/MDSdfr9mD+s0AnIIyA2+S7MuxmGWUvou6iB0bVgpu3JaR6HLp1AmrlTAS
         8Qks1RPu4kiemPkvShsX9exOQZLRvgPL66Ji50TUOVAf2U85Kedz9LW4KGm0ZYqtAKMj
         DT/hLkTBeTQZ3cne0CCV8Qm4pl7RNzWq59terw7rikrP3Lc37CA345pmIWsjczkJdSBZ
         6Oudkw/Dufr8rxRjyRzpznxlFRQ11LjraK0Ty2n7Vvxhjy5DzqyIZ+keKTzIjQ7gWkHu
         I5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/4b98HN7Dg/gsZp1FJDKtTqc5+TRGSRPQQAwQrD06k0=;
        b=YGgIRfqmYk9Gf5uIEwIfw64UPzvsXmcDuSg8ZbG/kyK1sGK16keNuH0W0PIS5aKDNY
         eRywdaW2S6ANAF6yJKqBRnq2COQyC6dX/AO8EhHoYNNySbenX6GBqY53pZ7kzL4hJ32U
         IGyo2snuXgrGeMSB2YL16EvLzJMG14r0xcla9eExX2s7tuxVmFlIKjkAqKEu4QDug/hH
         rcOLnlOK+Rq1+SY1eiUhwXd2q5nDsLFuwn6g0rOe80pmPumNGE3qY4MY/2GTWO/yJzkr
         VoKw+LV0Ea2IL+ZZr4oClMUFtyM6J0y7PWuiEVmXsaruVxoG+R/Vd1Lo7urQHwRzUBJj
         Sj1w==
X-Gm-Message-State: AOAM530b2EDzQs+mw+rUMjYPMtvD2J9UZ7nnGNDibG1mOOIPFD648HWr
        WNCVQVTuhWxIadAwNyX4FE8gUJ5AnfJ3Brg=
X-Google-Smtp-Source: ABdhPJxe1QO0yyWkfLZI2Ck3kq+oJXU7180eiST2dap9Bfk+tY8Z9kisuDNZoag/ofp3xkKJ+0iQVTquDNjuK7s=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:d18c:: with SMTP id
 i134mr25682880ybg.448.1605924208599; Fri, 20 Nov 2020 18:03:28 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:32 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-18-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 17/17] driver core: Delete pointless parameter in fwnode_operations.add_links
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

The struct device input to add_links() is not used for anything. So
delete it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c             | 2 +-
 drivers/firmware/efi/efi-init.c | 3 +--
 drivers/of/property.c           | 3 +--
 include/linux/fwnode.h          | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9edf9084fc98..63edb8bd9d7d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1472,7 +1472,7 @@ static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
 	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
 		return;
 
-	fwnode_call_int_op(fwnode, add_links, NULL);
+	fwnode_call_int_op(fwnode, add_links);
 	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
 }
 
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index c0c3d4c3837a..a552a08a1741 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -316,8 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
  * resource reservation conflict on the memory window that the efifb
  * framebuffer steals from the PCIe host bridge.
  */
-static int efifb_add_links(struct fwnode_handle *fwnode,
-			   struct device *dev)
+static int efifb_add_links(struct fwnode_handle *fwnode)
 {
 	struct device_node *sup_np;
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 620d29fdace8..5f9eed79a8aa 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1343,8 +1343,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 	return ret;
 }
 
-static int of_fwnode_add_links(struct fwnode_handle *fwnode,
-			       struct device *dev)
+static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
 	struct property *p;
 	struct device_node *con_np = to_of_node(fwnode);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index ffa9129182a6..fde4ad97564c 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -127,8 +127,7 @@ struct fwnode_operations {
 	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
-	int (*add_links)(struct fwnode_handle *fwnode,
-			 struct device *dev);
+	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
 #define fwnode_has_op(fwnode, op)				\
-- 
2.29.2.454.gaff20da3a2-goog

