Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878650E6CA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiDYRS7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiDYRSx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:18:53 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5FA245A6
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:48 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e9027efe6aso9450645fac.10
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31fpVwLUvVD/6XAm2dtZJP4qrzc0azCUndly9IICdXE=;
        b=KnyaefTks6jo+4TILCrF756WGX8lxZt9aHpg0PI9qew7ve2EigS6/YECweUifICg8H
         LiAgoqO+vwKrnqUqJe60Yhzfl4IRxDCH7Vch0OnSf0MasLEDbaR1qcsK3+9Jpog58ake
         F4bAxiod+Uu/zhOVRpQ8YJNXcyJMRaQi9/uMpgLuX8oqdN+PudGRnCL9IsfrDWJryraa
         KQsJD09z4zFNgyowj6+Ncy1TY21huL63RCM/uc8NHQDqRM9DjfJP3RHfBP6TW+I4kd56
         5xHxqyMJDOL7qxbQ1IfYpbKFhZUmuZlARjfbywcn3ycXGvjGJWyJkr3Gb2fSI2NqRAGF
         8coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31fpVwLUvVD/6XAm2dtZJP4qrzc0azCUndly9IICdXE=;
        b=TfSUnttgAYPMhpXVjc5LUO++XTsrIxiSXb0EklBzPvaUSAIDIlA9gs0BE5vRGl+6Lr
         /Og/IMDZwoX7O3BgOnTusvU6SwlSXKD+tNlPd/hl8/oN6PXTLsDGpzU4F8UaODS7A1s9
         mg5RUBVXhk9z8dYiZpXDxIhaNcRuPGR9x+M2MIoaFRrBoKNxIJYDCbPoxOZjQXnB98e9
         xfRPGXcOkHd7EnPhde9jo9Q9cLFDkGwhMnDM05oHXDhmnfibE2hmKMZ8fhh9WhWTy3IL
         ie+t4BhHGBXRl0pw2E9NuiHk7Ra94STU92/EAjEjEnJFu0QLNiAEB9yQ1M717DFC4kA2
         Cvjw==
X-Gm-Message-State: AOAM530GZIm1WG0dUt5F5jjsDFLDnoaqbJPBv4VnJSt4/0eOKvStoa64
        h262CKKnETATyv7ARrvxW2Z4qQ==
X-Google-Smtp-Source: ABdhPJxvV/YHrMeAQmhkW4afxhbyXcn6p7T6NUeeJ6tU6iHC/HNuYfsN2vuiql0DYLtiS3hO/Qmmlw==
X-Received: by 2002:a05:6870:3052:b0:da:a150:befe with SMTP id u18-20020a056870305200b000daa150befemr7457503oau.129.1650906947228;
        Mon, 25 Apr 2022 10:15:47 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm4538568oos.22.2022.04.25.10.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:15:46 -0700 (PDT)
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
Subject: [PATCH v7 1/8] mm/memblock: Tag memblocks with crypto capabilities
Date:   Mon, 25 Apr 2022 14:15:19 -0300
Message-Id: <20220425171526.44925-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/memblock.h |  5 ++++
 mm/memblock.c            | 62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..00c4f1a20335 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,6 +40,7 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -47,6 +48,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_CRYPTO_CAPABLE = 0x10,	/* capable of hardware encryption */
 };
 
 /**
@@ -120,6 +122,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
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
index e4f03a6e8e56..fe62f81572e6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -191,6 +191,40 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
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
+	int crypto_capables = 0;
+	int not_crypto_capables = 0;
+
+	for_each_mem_region(region) {
+		if (memblock_get_region_node(region) == nid) {
+			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
+				crypto_capables++;
+			else
+				not_crypto_capables++;
+		}
+	}
+
+	if (crypto_capables > 0 && not_crypto_capables > 0)
+		pr_warn("Node %d has %d regions that are encryptable and %d regions that aren't",
+			nid, not_crypto_capables, crypto_capables);
+
+	return not_crypto_capables == 0;
+}
+
 /**
  * __memblock_find_range_bottom_up - find free area utility in bottom-up
  * @start: start of candidate range
@@ -891,6 +925,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
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

