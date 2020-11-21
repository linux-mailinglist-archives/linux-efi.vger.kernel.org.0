Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA12BBBF7
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgKUCDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgKUCDL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97FC061A49
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a13so14124314ybj.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fcRX8EQ81IWbj6+XDTRlZFv8SxEOqV4OLStJQB/GoqQ=;
        b=Vj45QhO9ZSi0OFJycyK5AzWKxaZwGDVhvQ4z/YZwUXcrdiuvMasH3fQQMKIg41YWQa
         pxWXr0qGp7dzU4C6qYb+d7Uv1Gm56yYRHErC8Alp46BYKTHGkXivfK4K1eszSPOtCF1T
         tpeUyllcJhacOxSqD5nPFxhGX0OEg0wjMp7gvYrSFG7ogRg71wamSFLD/VlVbg2TuZX/
         eBM7mLf3GEN1C5gWZTuOeL3ttJgas/vXbDCChXeOi/LtNg6+1tLMtqTAKP24z+iKFtH1
         ri6FX3ocRYsaWv9UyFVDpTewGEgXUatlTpvthQ4OOMVXk8S57eg7RCCYzuaeEhWiHTXq
         Uivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fcRX8EQ81IWbj6+XDTRlZFv8SxEOqV4OLStJQB/GoqQ=;
        b=L36cZ0C7hsnFHDnxmFWiB1YFhowLKDCGVgy+fbud9XmPDajzRa5iYGSq6lNZE96p66
         JpplGqhtW5Ig6WFYC12mLLAHUGONs2TGtfRvB8dXXxVrp372VmJHOhTzcpcSyLT+qzDk
         TbhOMkdeHNHcYXfMFxJnc8PGeP8QpYGGtAmmFAP0PiZDecpooKnkSUw6kMJFhgYvMs5T
         i+8+F9op9FPVFVYkNUHKkEAb1rY5qkC1jhzlbOfIhsmZKkgQ+l1CWTXPGipdRxkyHQ/+
         lw5vL70LOZiyZn4Ar++XodjG/S38uLhCjMsTOcpYviT6ArhaMtSVH1VLCbr/PvaonNHo
         PmTQ==
X-Gm-Message-State: AOAM530u3C7yHP361gWT+DC+o/Poeu6uS7p48pHWgammMhk4xpFWc7UZ
        MdBsz0qUkR/9+wkycoOBXqo6zdzckbfPMbc=
X-Google-Smtp-Source: ABdhPJyEhyYRg3K0ym/U8YyY3pTaho98WkVJn/HloZlFw1kCa8i1tKS3G+uhnmUgvyIN+LExLDVXMDROSAqKLBc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:aa63:: with SMTP id
 s90mr25460026ybi.340.1605924190358; Fri, 20 Nov 2020 18:03:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:25 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-11-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 10/17] device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()
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

Add fwnode_is_ancestor_of() helper function to check if a fwnode is an
ancestor of another fwnode.

Add fwnode_get_next_parent_dev() helper function that take as input a
fwnode and finds the closest ancestor fwnode that has a corresponding
struct device and returns that struct device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/property.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c43d30145c6..35b95c6ac0c6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -614,6 +614,31 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
+/**
+ * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
+ * @fwnode: firmware node
+ *
+ * Given a firmware node (@fwnode), this function finds its closest ancestor
+ * firmware node that has a corresponding struct device and returns that struct
+ * device.
+ *
+ * The caller of this function is expected to call put_device() on the returned
+ * device when they are done.
+ */
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev = NULL;
+
+	fwnode_handle_get(fwnode);
+	do {
+		fwnode = fwnode_get_next_parent(fwnode);
+		if (fwnode)
+			dev = get_dev_from_fwnode(fwnode);
+	} while (fwnode && !dev);
+	fwnode_handle_put(fwnode);
+	return dev;
+}
+
 /**
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
@@ -660,6 +685,33 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
+/**
+ * fwnode_is_ancestor_of - Test if @test_ancestor is ancestor of @test_child
+ * @test_ancestor: Firmware which is tested for being an ancestor
+ * @test_child: Firmware which is tested for being the child
+ *
+ * A node is considered an ancestor of itself too.
+ *
+ * Returns true if @test_ancestor is an ancestor of @test_child.
+ * Otherwise, returns false.
+ */
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child)
+{
+	if (!test_ancestor)
+		return false;
+
+	fwnode_handle_get(test_child);
+	while (test_child) {
+		if (test_child == test_ancestor) {
+			fwnode_handle_put(test_child);
+			return true;
+		}
+		test_child = fwnode_get_next_parent(test_child);
+	}
+	return false;
+}
+
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
diff --git a/include/linux/property.h b/include/linux/property.h
index 2d4542629d80..0a9001fe7aea 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,9 +85,12 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.29.2.454.gaff20da3a2-goog

