Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D178B515558
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380339AbiD2UVF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380415AbiD2UVD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 16:21:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0710A0BE7
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:17:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e4so9682991oif.2
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erdqpZYLja6xDuoUNWXMJOEwQp9qkWbhvYqoJ4co3Os=;
        b=Q8UaonxznDmVc5gYov0m3G8lVeCJ9Wb++XO9fsv/gUqnPbStpjqIwYe0Rw241Jt1og
         1wa4l4d7Jn89Q6/jKFGGjyxze+q8g5RO76SUkMpqYIydbKVQsVVVkKPc4RTvRQrGXHMg
         6JTEB1ypvif9eRNj71NjI2Evpbuj5TuoHjCM2lZRZVLUM639ACMhnI9YvSOUfv0Q7u2R
         NOE7GpoeOT13Bxh590c+Vl6CGhR853U0Cgerj84916BoD9SDlzZ/JWwExnQbAUqEej6c
         z6Hs34KYKYNJDv/dkHUIU5fef1Ko3XrI07IFdNKGHp6BSyhh3MIfVHVkDqFE5bZN8rGH
         nuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erdqpZYLja6xDuoUNWXMJOEwQp9qkWbhvYqoJ4co3Os=;
        b=ctr9Let+cS7VbBbtKIHn1llZxpN0ABJJTeIxIakj4qilDknz/G0VgjaBmZXK18ORq7
         XxusG99ZWkrTfaxinqetIGjOcjzK6aqsAK2RvahkyZo6zVo7I4sXMICEAqMFB4Rosw3w
         Mh/S0YlVUFJoGQvs2gpNfZCa6LyuAN9of8nlIawZlEiTlU/1mWsLbYoEltywFsAy172r
         FxBR1Dz8NWt9HQm7+mV8E5IAnnrDJ1OH6xvW8yWze5WpYQ4V5oGbQkODiW2tbcJ6I0a0
         j8a900y6HTITYhLr8gB06qbEzE9P73+QhgzRfMUE0VlH9jJ28CwbADCNnFuCV1+tP4Cz
         by9w==
X-Gm-Message-State: AOAM531QCtaXx+l3weySSF0TMAEY+i4f3ve3sYgMT0A/UPt1oeYw9Cfc
        YvA8qSXwOumrpX9LnoODc2ag+Q==
X-Google-Smtp-Source: ABdhPJy1S2Ga4gCTYWLTSbLa/82ZQQmEvsYqOntWhuKnf1oxCmz0Cqnw2boboebtXSxhyQGp+cBYEw==
X-Received: by 2002:a05:6808:1115:b0:2ec:e103:99c8 with SMTP id e21-20020a056808111500b002ece10399c8mr533592oih.194.1651263463240;
        Fri, 29 Apr 2022 13:17:43 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id r2-20020a05687002c200b000e99b1909d4sm2650005oaf.25.2022.04.29.13.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:17:41 -0700 (PDT)
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
Subject: [PATCH v8 1/8] mm/memblock: Tag memblocks with crypto capabilities
Date:   Fri, 29 Apr 2022 17:17:10 -0300
Message-Id: <20220429201717.1946178-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
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
index e4f03a6e8e56..d6399835b155 100644
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
+ * true if every region in @nid is capable of encryption, false
+ * otherwise.
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
+	return crypto_capables > 0 && not_crypto_capables == 0;
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

