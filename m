Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A82A71AB
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgKDXZd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbgKDXYZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2AEC0613D4
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so395166ybj.14
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5sRZ6jhZ+T/gutzXbCBa2cQYYZrY2SCzTIYgh1jQP+0=;
        b=KPEQ4VrOxtoTLDuFgJFdWk6KRPwrcI/ihNJCiTdUkBKEYu92xvhA4SXzdybwWdc4ge
         8mbUKDP9DwLAgVQ9LoAveXPNRdT77u4tYK7hgrUwH1DDg69Exao6g4YGTrFlNI7Q/w4S
         F8eYHA6zVlAyFDxBjALghjyzMRvz5/b3Lh8CbxzbmV/WJZuXmDbovzL4rwSNauCh0lBn
         UR471uUcXqLneNOPe1RoDFHZxIQpmAzGHUT2zgAzJHIf6ztVlw6QTzchqb6yWo3fum7e
         8VY4oETIv6BIGaO+kuZw29D2uy/y5j6ySRsmxLo8TPojkay576ZnBosMBOA31raHLxDC
         oTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5sRZ6jhZ+T/gutzXbCBa2cQYYZrY2SCzTIYgh1jQP+0=;
        b=g/j0UTjFhW0A2TV15DS+7eHCZ1s9uIkL71mNlMkrflBbbGWNylhvMOwdZ5qSImpnJq
         5c0hboxWTTFGz30qujudRLzCeajoBMYxLm22TZ/3vfzWk/N7aFryt3XMzlPM8Xm9PmXL
         gD8ppLSiaG2fWAG1XIX+sCFaifpwELAeBDTF+cGL9C3y5pt7Y1/WeHtCkN/bPEAR649V
         GmMcHbWKAKZEOYG5mhKmlle7P75QBvjmAn5x9vL6Qzu+CRC6T5etZbUuTBYmtaGIkgzG
         2maN8qT1PKYe2uz4SG7BMZPk/OqdQDYGoFKoxsfaj/Z/Pm5FcMzgQ5mafnq1vFTWYztu
         M0oA==
X-Gm-Message-State: AOAM531kchRV3ycNLsidufKKc0g2W8ud1bkBPbfPj0iyxUKLKCynqOtV
        DyjiPwQVgdrLKthmh+ezX3B8ZpICUkkAM3A=
X-Google-Smtp-Source: ABdhPJz+alC8yp9zBJND6Vgcoky5QjmGBoY1he5RZG8ZuTerdEihYnn+YQqUYKoT1Mk3I8zQzC9AhaaEWWckVQ4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a5b:389:: with SMTP id
 k9mr265028ybp.75.1604532264967; Wed, 04 Nov 2020 15:24:24 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:47 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-11-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 10/18] device property: Add fwnode_is_ancestor_of()
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

Add a helper function to check if a fwnode is an ancestor of another
fwnode. This will be useful for fw_devlink feature.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/property.c  | 27 +++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c43d30145c6..2569ebd52e6b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -660,6 +660,33 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
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
index 2d4542629d80..2e5eed3ddf1c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -88,6 +88,8 @@ struct fwnode_handle *fwnode_get_next_parent(
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.29.1.341.ge80a0c044ae-goog

