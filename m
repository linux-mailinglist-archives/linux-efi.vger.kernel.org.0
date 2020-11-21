Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4372BBC18
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKUCDq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgKUCDJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C04C061A04
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e142so14211389ybf.16
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x2gFsEGnt1hKBTrd9Sh3BTzH1tCcPBvDnEqJhrf0jZk=;
        b=Oy8wm9rwe1xVP8CflmSHV6kS8mZ8CgBwaFnQT3haVq3hQfhTNPB3Dt+DC1srIEOHnJ
         00ReduJqDRDAQo4YVHy1qpCiEQz2PNiibjyIT3lltB9/N4XBvYtaxgJiErfIRrfc04LQ
         HK3VL6wPuPvyARgqpnwh7mKN6u6Cqa0Qqguc/PqLj0TgOesrnHZZ9yRhqVOBaT7kxpd3
         dYu6ejbMVZYfjOzk9mfZ+HZZdv455G6CXO+PAnMkBmajLUc/z8awlvJ1DwSX5FWgZtuK
         wF8ckZS3fTtZQZbuZE/wXm3mJ8ohZofNG7tgMMkx/gVSlH7velqealMro7ClhtycjfVJ
         32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x2gFsEGnt1hKBTrd9Sh3BTzH1tCcPBvDnEqJhrf0jZk=;
        b=cvrhXbbg+3ThFmlVuK/9VJaAj/31/VUgA7JIQGjQ7SdMnDIR6GnmVKsSCBpgPsf8xB
         STDpF6h8w8QKzWNICFjdY9TLdcc4G6X4jqGVcjUyv0ZqxmgKp0J9oquZGvJE07h3ua1F
         oDiWBVkkWtfwazbJPPq0KZfBMZ0c2MVow913OP70vo26TkD7ygidiDTyaZ6q2kF0jwPC
         2VzwBhtKwd9IBtqKW6c0LQJNm/PZcCoUwRkqd1qoiRJubGayghSVN+7aFsuE/iFVu7BK
         Wm7JwEGAO7ba+capje6/VaTEkKjQxg/L4Hw6gpUl85ypGYB9rcUH2JNakL8gG71Srj5W
         qucg==
X-Gm-Message-State: AOAM5320YTT/EMophAXb0tKboSKu4KglIgliuKuUdGIkiw7iPkmAVgaF
        wIeBx67Wt/2AE4Lo7J3pCYvDqgRVlKmzNzY=
X-Google-Smtp-Source: ABdhPJw9Lk+TmjAMNEAUq1RSxqYyPt+9pEP3OOOGTSy7HY7WuXSKaV6EWWbJFhcTCdlhMAZY1adm2F1s03IEpYQ=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:8446:: with SMTP id
 r6mr21337325ybm.442.1605924185419; Fri, 20 Nov 2020 18:03:05 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:23 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-9-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 08/17] driver core: Add fwnode link support
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

Add support for creating supplier-consumer links between fwnodes.  It is
intended for internal use the driver core and generic firmware support
code (eg. Device Tree, ACPI), so it is simple by design and the API
provided is limited.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 98 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/dynamic.c   |  1 +
 include/linux/fwnode.h | 14 ++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 401fa7e3505c..e2b246a44d1a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -50,6 +50,104 @@ static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
+static DEFINE_MUTEX(fwnode_link_lock);
+
+/**
+ * fwnode_link_add - Create a link between two fwnode_handles.
+ * @con: Consumer end of the link.
+ * @sup: Supplier end of the link.
+ *
+ * Create a fwnode link between fwnode handles @con and @sup. The fwnode link
+ * represents the detail that the firmware lists @sup fwnode as supplying a
+ * resource to @con.
+ *
+ * The driver core will use the fwnode link to create a device link between the
+ * two device objects corresponding to @con and @sup when they are created. The
+ * driver core will automatically delete the fwnode link between @con and @sup
+ * after doing that.
+ *
+ * Attempts to create duplicate links between the same pair of fwnode handles
+ * are ignored and there is no reference counting.
+ */
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+{
+	struct fwnode_link *link;
+	int ret = 0;
+
+	mutex_lock(&fwnode_link_lock);
+
+	list_for_each_entry(link, &sup->consumers, s_hook)
+		if (link->consumer == con)
+			goto out;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	link->supplier = sup;
+	INIT_LIST_HEAD(&link->s_hook);
+	link->consumer = con;
+	INIT_LIST_HEAD(&link->c_hook);
+
+	list_add(&link->s_hook, &sup->consumers);
+	list_add(&link->c_hook, &con->suppliers);
+out:
+	mutex_unlock(&fwnode_link_lock);
+
+	return ret;
+}
+
+/**
+ * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
+ * @fwnode: fwnode whose supplier links need to be deleted
+ *
+ * Deletes all supplier links connecting directly to @fwnode.
+ */
+static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link, *tmp;
+
+	mutex_lock(&fwnode_link_lock);
+	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
+		list_del(&link->s_hook);
+		list_del(&link->c_hook);
+		kfree(link);
+	}
+	mutex_unlock(&fwnode_link_lock);
+}
+
+/**
+ * fwnode_links_purge_consumers - Delete all consumer links of fwnode_handle.
+ * @fwnode: fwnode whose consumer links need to be deleted
+ *
+ * Deletes all consumer links connecting directly to @fwnode.
+ */
+static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link, *tmp;
+
+	mutex_lock(&fwnode_link_lock);
+	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
+		list_del(&link->s_hook);
+		list_del(&link->c_hook);
+		kfree(link);
+	}
+	mutex_unlock(&fwnode_link_lock);
+}
+
+/**
+ * fwnode_links_purge - Delete all links connected to a fwnode_handle.
+ * @fwnode: fwnode whose links needs to be deleted
+ *
+ * Deletes all links connecting directly to a fwnode.
+ */
+void fwnode_links_purge(struct fwnode_handle *fwnode)
+{
+	fwnode_links_purge_suppliers(fwnode);
+	fwnode_links_purge_consumers(fwnode);
+}
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index fe64430b438a..9a824decf61f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -356,6 +356,7 @@ void of_node_release(struct kobject *kobj)
 
 	property_list_free(node->properties);
 	property_list_free(node->deadprops);
+	fwnode_links_purge(of_fwnode_handle(node));
 
 	kfree(node->full_name);
 	kfree(node->data);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 5589799708b5..b88365187347 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -10,6 +10,7 @@
 #define _LINUX_FWNODE_H_
 
 #include <linux/types.h>
+#include <linux/list.h>
 
 struct fwnode_operations;
 struct device;
@@ -18,6 +19,15 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
 	struct device *dev;
+	struct list_head suppliers;
+	struct list_head consumers;
+};
+
+struct fwnode_link {
+	struct fwnode_handle *supplier;
+	struct list_head s_hook;
+	struct fwnode_handle *consumer;
+	struct list_head c_hook;
 };
 
 /**
@@ -174,8 +184,12 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
 	fwnode->ops = ops;
+	INIT_LIST_HEAD(&fwnode->consumers);
+	INIT_LIST_HEAD(&fwnode->suppliers);
 }
 
 extern u32 fw_devlink_get_flags(void);
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
+void fwnode_links_purge(struct fwnode_handle *fwnode);
 
 #endif
-- 
2.29.2.454.gaff20da3a2-goog

