Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7635B2BBC06
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKUCDX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgKUCDX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:23 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0DEC061A04
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:21 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id d206so9476105qkc.23
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oB/Rc9nzOQepgyIaeoMVj7BGWUJEKwMdiGCB2gM+cig=;
        b=S04GPKGpV0U0EBPxJs8hjq/VGdQ/+pgDQspUxXlXS6imPpfQNn+a6sHlQje9hgNMUt
         yOhNwVZRv+AsOLGcZwQzXasqGaREZOKSt0ltfcgi/2VY03fzZC7CmWQ2f4EP0EKtQqNq
         u9XQrW3W+K25xZ+zuEaOxCBpukl3whOoYUE/BxI0For960kJqFLukEc+qr12MjIvlIUN
         lrIoqDLTpLabZECYK8ZhKPoHVmdBSSmsPitSg5VDE3uAEsHf2NWVW6WfSe0bNZdEjRfk
         YMUs99c9jKqdf+YN+FUhElfppmkv/KkdRB1HaCF+fwt4PpAoXIX/PVUtUgCkwEoqh++B
         fTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oB/Rc9nzOQepgyIaeoMVj7BGWUJEKwMdiGCB2gM+cig=;
        b=Hs1s9d1tRg1+4HfrHezr9e9ths+FFX8PHtXJWjNMxw3KP90GaJOn+J/cmTaOKj1l7s
         MiqlAiuR1pnrHV0fWrk6TvaJJDrAjL3zqCcnV4rPTslxR6M5qmTluchzy6tmiI5/MNid
         UvLOegOqzvG3KCxRmaQNzBaH1xWD58bPfcTlzoNAfwqptt/5th2a4y6noN2TJ6Xsuhd2
         LJS/FfOyEj81n71KTwne1/hkiTw+dpaEhxK/ySs1qH6pV7K3sIsjVQa3S3YoOPiJAS4Z
         PpDMBnLs6mv6VqEh7AogPL4ZJ4JBNWxQ/YF+z+8S9Juiym/j1fzbb1IXzKx/gPy+xTDh
         b0AA==
X-Gm-Message-State: AOAM530Q5wqexHWvBKuzuuDXdzfbmJPPAyDpvONtNXdgWroHdsLXEvRj
        1Qss3JJxwhN591620nhCzdJcsr//maPRntE=
X-Google-Smtp-Source: ABdhPJxDBw4GzqOVsM7gNt24Uv/2KWjR/2lAkEUZxC6ra+bMDzkimOKky3ENjfI+H8GyE/XDQp/bZw2qovvswhs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a05:6214:c2d:: with SMTP id
 a13mr18706718qvd.23.1605924200452; Fri, 20 Nov 2020 18:03:20 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:29 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-15-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 14/17] of: property: Update implementation of add_links()
 to create fwnode links
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

The semantics of add_links() has changed from creating device link
between devices to creating fwnode links between fwnodes. So, update the
implementation of add_links() to match the new semantics.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 150 ++++++++++++------------------------------
 1 file changed, 41 insertions(+), 109 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 408a7b5f06a9..620d29fdace8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1038,33 +1038,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 }
 
 /**
- * of_get_next_parent_dev - Add device link to supplier from supplier phandle
- * @np: device tree node
- *
- * Given a device tree node (@np), this function finds its closest ancestor
- * device tree node that has a corresponding struct device.
- *
- * The caller of this function is expected to call put_device() on the returned
- * device when they are done.
- */
-static struct device *of_get_next_parent_dev(struct device_node *np)
-{
-	struct device *dev = NULL;
-
-	of_node_get(np);
-	do {
-		np = of_get_next_parent(np);
-		if (np)
-			dev = get_dev_from_fwnode(&np->fwnode);
-	} while (np && !dev);
-	of_node_put(np);
-	return dev;
-}
-
-/**
- * of_link_to_phandle - Add device link to supplier from supplier phandle
- * @dev: consumer device
- * @sup_np: phandle to supplier device tree node
+ * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
+ * @con_np: consumer device tree node
+ * @sup_np: supplier device tree node
  *
  * Given a phandle to a supplier device tree node (@sup_np), this function
  * finds the device that owns the supplier device tree node and creates a
@@ -1074,16 +1050,14 @@ static struct device *of_get_next_parent_dev(struct device_node *np)
  * cases, it returns an error.
  *
  * Returns:
- * - 0 if link successfully created to supplier
- * - -EAGAIN if linking to the supplier should be reattempted
+ * - 0 if fwnode link successfully created to supplier
  * - -EINVAL if the supplier link is invalid and should not be created
- * - -ENODEV if there is no device that corresponds to the supplier phandle
+ * - -ENODEV if struct device will never be create for supplier
  */
-static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
-			      u32 dl_flags)
+static int of_link_to_phandle(struct device_node *con_np,
+			      struct device_node *sup_np)
 {
-	struct device *sup_dev, *sup_par_dev;
-	int ret = 0;
+	struct device *sup_dev;
 	struct device_node *tmp_np = sup_np;
 
 	of_node_get(sup_np);
@@ -1106,7 +1080,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	}
 
 	if (!sup_np) {
-		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
+		pr_debug("Not linking %pOFP to %pOFP - No device\n",
+			 con_np, tmp_np);
 		return -ENODEV;
 	}
 
@@ -1115,53 +1090,30 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	 * descendant nodes. By definition, a child node can't be a functional
 	 * dependency for the parent node.
 	 */
-	if (of_is_ancestor_of(dev->of_node, sup_np)) {
-		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
+	if (of_is_ancestor_of(con_np, sup_np)) {
+		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
+			 con_np, sup_np);
 		of_node_put(sup_np);
 		return -EINVAL;
 	}
+
+	/*
+	 * Don't create links to "early devices" that won't have struct devices
+	 * created for them.
+	 */
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
 	if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
-		/* Early device without struct device. */
-		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
-			sup_np);
+		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
+			 con_np, sup_np);
 		of_node_put(sup_np);
 		return -ENODEV;
-	} else if (!sup_dev) {
-		/*
-		 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
-		 * cycles. So cycle detection isn't necessary and shouldn't be
-		 * done.
-		 */
-		if (dl_flags & DL_FLAG_SYNC_STATE_ONLY) {
-			of_node_put(sup_np);
-			return -EAGAIN;
-		}
-
-		sup_par_dev = of_get_next_parent_dev(sup_np);
-
-		if (sup_par_dev && device_is_dependent(dev, sup_par_dev)) {
-			/* Cyclic dependency detected, don't try to link */
-			dev_dbg(dev, "Not linking to %pOFP - cycle detected\n",
-				sup_np);
-			ret = -EINVAL;
-		} else {
-			/*
-			 * Can't check for cycles or no cycles. So let's try
-			 * again later.
-			 */
-			ret = -EAGAIN;
-		}
-
-		of_node_put(sup_np);
-		put_device(sup_par_dev);
-		return ret;
 	}
-	of_node_put(sup_np);
-	if (!device_link_add(dev, sup_dev, dl_flags))
-		ret = -EINVAL;
 	put_device(sup_dev);
-	return ret;
+
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
+	of_node_put(sup_np);
+
+	return 0;
 }
 
 /**
@@ -1361,37 +1313,29 @@ static const struct supplier_bindings of_supplier_bindings[] = {
  * that list phandles to suppliers. If @prop_name isn't one, this function
  * doesn't do anything.
  *
- * If @prop_name is one, this function attempts to create device links from the
- * consumer device @dev to all the devices of the suppliers listed in
- * @prop_name.
+ * If @prop_name is one, this function attempts to create fwnode links from the
+ * consumer device tree node @con_np to all the suppliers device tree nodes
+ * listed in @prop_name.
  *
- * Any failed attempt to create a device link will NOT result in an immediate
+ * Any failed attempt to create a fwnode link will NOT result in an immediate
  * return.  of_link_property() must create links to all the available supplier
- * devices even when attempts to create a link to one or more suppliers fail.
+ * device tree nodes even when attempts to create a link to one or more
+ * suppliers fail.
  */
-static int of_link_property(struct device *dev, struct device_node *con_np,
-			     const char *prop_name)
+static int of_link_property(struct device_node *con_np, const char *prop_name)
 {
 	struct device_node *phandle;
 	const struct supplier_bindings *s = of_supplier_bindings;
 	unsigned int i = 0;
 	bool matched = false;
 	int ret = 0;
-	u32 dl_flags;
-
-	if (dev->of_node == con_np)
-		dl_flags = fw_devlink_get_flags();
-	else
-		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
 
 	/* Do not stop at first failed link, link all available suppliers. */
 	while (!matched && s->parse_prop) {
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			matched = true;
 			i++;
-			if (of_link_to_phandle(dev, phandle, dl_flags)
-								== -EAGAIN)
-				ret = -EAGAIN;
+			of_link_to_phandle(con_np, phandle);
 			of_node_put(phandle);
 		}
 		s++;
@@ -1399,31 +1343,19 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
 	return ret;
 }
 
-static int of_link_to_suppliers(struct device *dev,
-				  struct device_node *con_np)
+static int of_fwnode_add_links(struct fwnode_handle *fwnode,
+			       struct device *dev)
 {
-	struct device_node *child;
 	struct property *p;
-	int ret = 0;
+	struct device_node *con_np = to_of_node(fwnode);
 
-	for_each_property_of_node(con_np, p)
-		if (of_link_property(dev, con_np, p->name))
-			ret = -ENODEV;
-
-	for_each_available_child_of_node(con_np, child)
-		if (of_link_to_suppliers(dev, child) && !ret)
-			ret = -EAGAIN;
-
-	return ret;
-}
+	if (!con_np)
+		return -EINVAL;
 
-static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
-			       struct device *dev)
-{
-	if (unlikely(!is_of_node(fwnode)))
-		return 0;
+	for_each_property_of_node(con_np, p)
+		of_link_property(con_np, p->name);
 
-	return of_link_to_suppliers(dev, to_of_node(fwnode));
+	return 0;
 }
 
 const struct fwnode_operations of_fwnode_ops = {
-- 
2.29.2.454.gaff20da3a2-goog

