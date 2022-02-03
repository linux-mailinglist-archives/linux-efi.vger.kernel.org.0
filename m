Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57304A88D0
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352316AbiBCQnz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 11:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352339AbiBCQnz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 11:43:55 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE0C061714
        for <linux-efi@vger.kernel.org>; Thu,  3 Feb 2022 08:43:54 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id b15-20020a4a878f000000b002dccc412166so1941831ooi.11
        for <linux-efi@vger.kernel.org>; Thu, 03 Feb 2022 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqxGKfIaElLILaxF70bDCH7K86RuUZa6ey16asaAIL8=;
        b=datlh4dR78ilyTuX5QJMyasJ51wpsY/9yQWHYGQ5q+433ZIPXwWIrpKMsFE6Scjokx
         VVmwwBvqOxzijJNX6FoIk2lBAXVjwP18b7JWnw/DUTcY2nlfRG1h0DhNZkY/sRr2hBAk
         cFcAktlfD8CBOQtWCtesgfwtCD30Ag+pnjxeef09PTYlVmecbF7xr47SFmHX4pJr8eaC
         WbxOL1lARe1FGG//DOrbrVjBmmNl953y/6PcDdyUEevozYmWj3fUpEuOQqaT/kn2Lvke
         zdywgqZAjdL6sRg3kQs8EKm+q0Gm/wJYCEMcsXnxCnFgDwNUf2wXdDR99WKaXGadra07
         jKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqxGKfIaElLILaxF70bDCH7K86RuUZa6ey16asaAIL8=;
        b=Kmjk4akQs7zJUhFCuYWAHzKHkiwF1l9ylmsz9bM61a6fZyHOoIKM5fpen3H/845J17
         gsFEDXXPBlzffPwG0XPPkn6FkeR7eREKxPCC2Ud7HwJn2AVQc8xmWdgpEh+Xd8zezE/z
         khbofCXBe5aux7OIKpBMbB6qX4I3wJmITl81QS5bW1x82SN30Mv7yBx2ON/eb6+nKa3l
         7YC5tZG/6/ZQ5rahF7HUy+YWMcm4J4XFYb/HWy1iuze247oLpgl3UO4m5HGRQ1f0ETk8
         7Q+bZe7/eoxH29OSupLEszys7o3r1SZo2GFZJRq4FxqxAOC8hAQNa4ByQvy6TMA06LXg
         gJQA==
X-Gm-Message-State: AOAM533UgvZbmauwyzfvjIZS8mzJbteuc6qPzL7dGGuQ2OhLuec2Apmo
        Q9CRixJFzXc8rMwzL3j+xkMGPA==
X-Google-Smtp-Source: ABdhPJz3KHjC1PcTs960s+pnZHPdMPi5tX1gUa+Hy63Y3u0iqFld1EfTMFHHJ54cHT2MusHjn7bfpQ==
X-Received: by 2002:a05:6870:2144:: with SMTP id g4mr360672oae.30.1643906634240;
        Thu, 03 Feb 2022 08:43:54 -0800 (PST)
Received: from localhost (host8.190-224-49.telecom.net.ar. [190.224.49.8])
        by smtp.gmail.com with ESMTPSA id x16sm3107305ooa.6.2022.02.03.08.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:43:54 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v6 1/6] mm/memblock: Tag memblocks with crypto capabilities
Date:   Thu,  3 Feb 2022 13:43:23 -0300
Message-Id: <20220203164328.203629-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the capability to mark regions of the memory memory_type able of
hardware memory encryption.

Also add the capability to query if all regions of a memory node are
able to do hardware memory encryption to call it when initializing the
nodes. Warn the user if a node has both encryptable and
non-encryptable regions.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/memblock.h | 15 ++++++----
 mm/memblock.c            | 64 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9dc7cb239d21..73edcce165a5 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -41,13 +41,15 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
  */
 enum memblock_flags {
-	MEMBLOCK_NONE		= 0x0,	/* No special request */
-	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
-	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
-	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
-	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_NONE		= 0x0,		/* No special request */
+	MEMBLOCK_HOTPLUG	= 0x1,		/* hotpluggable region */
+	MEMBLOCK_MIRROR		= 0x2,		/* mirrored region */
+	MEMBLOCK_NOMAP		= 0x4,		/* don't add to kernel direct mapping */
+	MEMBLOCK_DRIVER_MANAGED = 0x8,		/* always detected via a driver */
+	MEMBLOCK_CRYPTO_CAPABLE = 0x10,		/* capable of hardware encryption */
 };
 
 /**
@@ -121,6 +123,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_node_is_crypto_capable(int nid);
+int memblock_mark_crypto_capable(phys_addr_t base, phys_addr_t size);
+int memblock_clear_crypto_capable(phys_addr_t base, phys_addr_t size);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 1018e50566f3..fcf79befeab3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -191,6 +191,42 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 	return i < type->cnt;
 }
 
+/**
+ * memblock_node_is_crypto_capable - get if whole node is capable
+ * of encryption
+ * @nid: number of node
+ *
+ * Iterate over all memory memblock_type and find if all regions under
+ * node @nid are capable of hardware encryption.
+ *
+ * Return:
+ * true if every region in memory memblock_type is capable of
+ * encryption, false otherwise.
+ */
+bool __init_memblock memblock_node_is_crypto_capable(int nid)
+{
+	struct memblock_region *region;
+	bool crypto_capable = false;
+	bool not_crypto_capable = false;
+
+	for_each_mem_region(region) {
+		if (memblock_get_region_node(region) == nid) {
+			crypto_capable =
+				crypto_capable ||
+				(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
+			not_crypto_capable =
+				not_crypto_capable ||
+				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
+		}
+	}
+
+	if (crypto_capable && not_crypto_capable)
+		pr_warn_once("Node %d has regions that are encryptable and regions that aren't",
+			     nid);
+
+	return !not_crypto_capable;
+}
+
 /**
  * __memblock_find_range_bottom_up - find free area utility in bottom-up
  * @start: start of candidate range
@@ -885,6 +921,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 	return 0;
 }
 
+/**
+ * memblock_mark_crypto_capable - Mark memory regions capable of hardware
+ * encryption with flag MEMBLOCK_CRYPTO_CAPABLE.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_crypto_capable(phys_addr_t base,
+						 phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_CRYPTO_CAPABLE);
+}
+
+/**
+ * memblock_clear_crypto_capable - Clear flag MEMBLOCK_CRYPTO for a
+ * specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_crypto_capable(phys_addr_t base,
+						  phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_CRYPTO_CAPABLE);
+}
+
 /**
  * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
  * @base: the base phys addr of the region
-- 
2.30.2

