Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D442A717E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbgKDXYT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbgKDXYS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54938C0613D2
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12so374706ybc.20
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4yDErQekIljO/S7pLjDxW0jxFsnPKb/jwWQMU27tKII=;
        b=YUgM51NYeL9vU9yQIfagIiPGWKRHGpSO3fwqm105yfYzLMD3x4TJSYezaSn6yyix6W
         8NHyCgWgxubbjEQ8F+Ry1030ndTDKp3KsWTs8suP9wBagBDUBqmGgfvy23fruwrft3+1
         yX1RdcdhpPbLoVl7nDn8a3JT3xQfKYYEksgcpCR7cW9bulWdUGbhN/9xKVhrH56f1BIh
         um7582xtCxUQjsd+gwY46fXW0FdQ+N881rSPrv8pL0OeAGDYPV3RTWS1LwCZpGjhLgEj
         t08RkO48I4lEOeW7T1DglPUrkAOvbT9G0X+SDLGJyEJj8dghLIMk2zSqzqLR0/D3NYpL
         H58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4yDErQekIljO/S7pLjDxW0jxFsnPKb/jwWQMU27tKII=;
        b=ceTfNxvZiGb503NVeiN/ZvI/dXRXuh6xxniDbWS2IrkMWnkDDsjKSGdNhU1tEJn2Vy
         qvY5xqSTbpC19PtkMhWYdSEirA5wGD3Kv8s2ZZyDeCaTrWFbnnKJotleKefxWw891ALF
         lfzfYwF2rrLdUcU51Vd+p4hahOvgMZNZDLKTmvNWVcLMLEuy+n4MGBqXaG4eqUTO7Fpt
         Ock8QCZdJBlPuUXPLkkO8KKllW/NEfc/FdSJhubjfTaj8N1vOF0kOpTFh5/hdX5uaE5b
         4yI+sArQaoEyfdvpGA4yAseE7k8SX0QiBnkgzqcc3LZ3QOsYgjdgI/lGDD8lwVVhgC6W
         u0vQ==
X-Gm-Message-State: AOAM531tej8rlvKoEpjnNp/LuMeJttxPgkUeGCwv52iV8dGTXJ1IDUen
        5D655407UmWkyBRC0rxwsRyQeblIZAeB7pE=
X-Google-Smtp-Source: ABdhPJy7swoQRBdFlUuf1ks1efg5L1nrOI3mCkU9tvjlZYvjr3Xzk+8L0n+P3Kd/mbpr64jItVpDxoNMIZfuumM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:2c2:: with SMTP id
 185mr327966ybc.72.1604532257559; Wed, 04 Nov 2020 15:24:17 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:44 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-8-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 07/18] driver core: Add fwnode_init()
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

There are multiple locations in the kernel where a struct fwnode_handle
is initialized. Add fwnode_init() so that we have one way of
initializing a fwnode_handle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/acpi/property.c         | 2 +-
 drivers/acpi/scan.c             | 2 +-
 drivers/base/swnode.c           | 2 +-
 drivers/firmware/efi/efi-init.c | 8 ++++----
 include/linux/fwnode.h          | 5 +++++
 include/linux/of.h              | 2 +-
 kernel/irq/irqdomain.c          | 2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d04de10a63e4..24e87b630573 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -76,7 +76,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 		return false;
 
 	dn->name = link->package.elements[0].string.pointer;
-	dn->fwnode.ops = &acpi_data_fwnode_ops;
+	fwnode_init(&dn->fwnode, &acpi_data_fwnode_ops);
 	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a896e5e87c93..0ac19f9274b8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1589,7 +1589,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->device_type = type;
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
-	device->fwnode.ops = &acpi_device_fwnode_ops;
+	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
 	acpi_set_device_status(device, sta);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 010828fc785b..4a4b2008fbc2 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -653,7 +653,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	swnode->parent = parent;
 	swnode->allocated = allocated;
 	swnode->kobj.kset = swnode_kset;
-	swnode->fwnode.ops = &software_node_ops;
+	fwnode_init(&swnode->fwnode, &software_node_ops);
 
 	ida_init(&swnode->child_ids);
 	INIT_LIST_HEAD(&swnode->entry);
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index f55a92ff12c0..b148f1459fb3 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -359,9 +359,7 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-static struct fwnode_handle efifb_fwnode = {
-	.ops = &efifb_fwnode_ops,
-};
+static struct fwnode_handle efifb_fwnode;
 
 static int __init register_gop_device(void)
 {
@@ -375,8 +373,10 @@ static int __init register_gop_device(void)
 	if (!pd)
 		return -ENOMEM;
 
-	if (IS_ENABLED(CONFIG_PCI))
+	if (IS_ENABLED(CONFIG_PCI)) {
+		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
 		pd->dev.fwnode = &efifb_fwnode;
+	}
 
 	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
 	if (err)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index e0abafbb17f8..593fb8e58f21 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -169,6 +169,11 @@ struct fwnode_operations {
 			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
 	} while (false)
 #define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
+static inline void fwnode_init(struct fwnode_handle *fwnode,
+			       const struct fwnode_operations *ops)
+{
+	fwnode->ops = ops;
+}
 
 extern u32 fw_devlink_get_flags(void);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 5d51891cbf1a..27fba2472eee 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -108,7 +108,7 @@ static inline void of_node_init(struct device_node *node)
 #if defined(CONFIG_OF_KOBJ)
 	kobject_init(&node->kobj, &of_node_ktype);
 #endif
-	node->fwnode.ops = &of_fwnode_ops;
+	fwnode_init(&node->fwnode, &of_fwnode_ops);
 }
 
 #if defined(CONFIG_OF_KOBJ)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..06fce7e39033 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -91,7 +91,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 	fwid->type = type;
 	fwid->name = n;
 	fwid->pa = pa;
-	fwid->fwnode.ops = &irqchip_fwnode_ops;
+	fwnode_init(&fwid->fwnode, &irqchip_fwnode_ops);
 	return &fwid->fwnode;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
-- 
2.29.1.341.ge80a0c044ae-goog

