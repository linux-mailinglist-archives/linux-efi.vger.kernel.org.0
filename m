Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59348DF9F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 22:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiAMVat (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 16:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiAMVas (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 16:30:48 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76493C06173E
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:30:48 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so7892756otu.2
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RqfR1RKHyt56B3HaINQqKrkUmepffSj3WABI23dqNA=;
        b=DXOplbCa3rlaTR1lzXo0syR+d0dk0Ki3jfBTsW21qNTvRNb67a7rQFafgRjnsDG0xl
         IMRYzB1c3zKfRhmQ4H/ZAWy6s7cnRvC7aZSZn2Pv4CNgOjM/N2zri/+3hOHGnv5FBdDE
         T6EdwD/rbF7IK9lKa0gCFgot6HuowyV2kGQ49C28bv7WWSLmDkXMbIf89xOzCJQfqfsx
         ukB78kPc4izKs5xECbE7mKdDOAj9JbkAO0IUOhMkikVSrhoW61a4HvH4TTTN0HXr8kwt
         sqAldQmHRJIB6ys53jbqjMR534CpJY9uOp+L5ed+jr1HukdwMAvLFVNzka/GtcGQpD+b
         686Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RqfR1RKHyt56B3HaINQqKrkUmepffSj3WABI23dqNA=;
        b=eACwt+w79WFEZcfDItD6gCybAe/duHDDMzpYhTWNJTXGyVZI3xI9Qg+KSImmN9Cg1q
         L2qfs6nyGmEFAiudLSmaZGEdGB7CfWD8s1LcLTG8gK6kgvo2KkPHt31WJ68y1qcFUEYi
         MPpv7kuVpjviR3i/L29MYVqz+UFeMxzXMyUwnD2BLWfnqrTLxfbNR5Y3+ljgsP2AzVI7
         DCj5yRkGbZbyN5OpnTxq8QchY8/GqVpnH4xyMGvzCh8gE0U9abHrEkbYdFFMPNMiU4qq
         M9SIgQVDH1Jb1f270hm86+xL/Et8eDGtJ8PZg0AP7rvx6TH0wnbWsC96qfPyrpQ9V3zt
         +f1g==
X-Gm-Message-State: AOAM531EYgtTRHNwcuKdKb5a/8V2TeLzdjiOPiSm9XcZ9wvXFD4dhlQW
        jJl+dvy3okg1yRkW5cygp1VruQ==
X-Google-Smtp-Source: ABdhPJxohhMZ86BwQjPzKMMIL7CIogMV+YYOB+Qz4+6WClsKEC8ODPW1XtId8mIcWO0OAl/kvVANfg==
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr1134058otp.269.1642109447444;
        Thu, 13 Jan 2022 13:30:47 -0800 (PST)
Received: from localhost (115-127-16-190.fibertel.com.ar. [190.16.127.115])
        by smtp.gmail.com with ESMTPSA id s124sm971747ooa.1.2022.01.13.13.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:30:47 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v5 1/5] mm/memblock: Tag memblocks with crypto capabilities
Date:   Thu, 13 Jan 2022 18:30:23 -0300
Message-Id: <20220113213027.457282-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the capability to mark regions of the memory memory_type able of
hardware memory encryption.

Also add the capability to query if all regions of a memory node are
able to do hardware memory encryption to call it when initializing the
nodes.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/memblock.h |  5 ++++
 mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9dc7cb239d21..374c03e10b2e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -41,6 +41,7 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -48,6 +49,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_CRYPTO_CAPABLE = 0x10,  /* capable of hardware encryption */
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
index 1018e50566f3..61ec50647469 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -191,6 +191,27 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 	return i < type->cnt;
 }
 
+/**
+ * memblock_node_is_crypto_capable - get if whole node is capable
+ * of encryption
+ * @nid: number of node
+ *
+ * Iterate over all memory memblock_type and find if all regions under
+ * node @nid are capable of hardware encryption.
+ */
+bool __init_memblock memblock_node_is_crypto_capable(int nid)
+{
+	struct memblock_region *region;
+
+	for_each_mem_region(region) {
+		if ((memblock_get_region_node(region) == nid) &&
+		    !(region->flags & MEMBLOCK_CRYPTO_CAPABLE))
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * __memblock_find_range_bottom_up - find free area utility in bottom-up
  * @start: start of candidate range
@@ -885,6 +906,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
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

