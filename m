Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB1A43D1F0
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhJ0T6m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbhJ0T6m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Oct 2021 15:58:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FAC061745
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v29so2301412qtc.10
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVW+x4SHR5ZY/WmCzQSUzU6bYAdRF23pMQL9FAYmb6M=;
        b=Ar4ze/6EPoWPhA3JDM57YID+3evoOxlPMz4f+OSUQaW55SHFnsQDtQL0R05HUl0T6+
         ovtcBvcAtPIpBD2PcULZDo8+44r90YfZbyjjG9V2qdymRKTATx7aODPBZHlj8gMyBxUX
         xlhcMCRS8U0GWEYyuOhn8tF7JKH9FTmRLpnm9R0AI11O0HyRbqUk1iAPG90dKq8ffuTJ
         kVQGchpTtSMouHeWakj9SqlNjKUl5R4kYOgM5xoMUUB7+3l07VGJsUsj6RKay8815Zpp
         3qWv+qQgDEa3hYfCbqsomF/Gq0g/jVSVxBP/AzQdLbUiYTxDLMyP7Me7F3zWA5xsTmNk
         VJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVW+x4SHR5ZY/WmCzQSUzU6bYAdRF23pMQL9FAYmb6M=;
        b=KRSyehmD3OsW+gEaGmvMmDA/VCNuSmF9RSmypLw990/xKVNXH7NMw/t3LTTpw78py+
         GTjQPMIrWF5XQKWFqcFH2hQgh3kdvA1ZnQDjUfoYjLgSalyLmYvrZzMpMTwfY+w5NmoA
         E7+jveSC6FLHhBPzbYcbQJK6Z+d3Cf3U2wLzJ6OdSL2X0TU22/uNRFWiSWouPNw7G648
         1Bz4WzFzkjrPnZfE9SS9rH3QjvntQ63E6/QXWeYJFKkjfcj1CuO7O0Hj7LrPTRF2UXeK
         4w5lpxvnzOuHRHQEyomEUeSxz6w61UzpajXBuxqFQm8cBRA4tV2C8CVz7Ep+DEL5BCTM
         gLjA==
X-Gm-Message-State: AOAM530Ia+ong1ibP/x62MrpffCwYcwa1exV1vIllyAsTaupu14YzGB4
        JQcfFkS4r8DidoLuVpiZUspl0h8khc/NbyB1ULfu27hvcuDVhH0Aa68wYQ4YMZWrMe7xdTfy5uG
        D1YNIskUOfLMkXqAX2RADWULP75wHRCIwcdTvX6RXfgHQ5ZlsGe5rOEkFFPHx7i6R+4guzdCKrv
        8IsMuEfwF1D06LTTQ=
X-Google-Smtp-Source: ABdhPJy0nVl3DitkfpC/3qkpKuPGaW5S/UmEIKRfYexMngd/yBrdsnzkqGfpDz25K/qqv0YSmfFdyA==
X-Received: by 2002:ac8:5c16:: with SMTP id i22mr34420120qti.26.1635364575376;
        Wed, 27 Oct 2021 12:56:15 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id bq30sm671322qkb.6.2021.10.27.12.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:56:14 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com
Subject: [PATCH v2 1/5] Extend memblock to support memory encryption
Date:   Wed, 27 Oct 2021 16:55:07 -0300
Message-Id: <20211027195511.207552-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the capability to mark regions of the memory memory_type able of
hardware memory encryption.

Also add the capability to query if all regions of a memory node are
able to do hardware memory encryption.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/memblock.h |  6 ++++
 mm/memblock.c            | 74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 34de69b3b8ba..945af2cc7966 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -31,6 +31,7 @@ extern unsigned long long max_possible_pfn;
  * @MEMBLOCK_HOTPLUG: hotpluggable region
  * @MEMBLOCK_MIRROR: mirrored region
  * @MEMBLOCK_NOMAP: don't add to kernel direct mapping and treat as
+ * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
  * reserved in the memory map; refer to memblock_mark_nomap() description
  * for further details
  */
@@ -39,6 +40,7 @@ enum memblock_flags {
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_CRYPTO_CAPABLE = 0x8,  /* capable of hardware encryption */
 };
 
 /**
@@ -102,6 +104,7 @@ static inline void memblock_discard(void) {}
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
+int memblock_add_crypto_capable(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
@@ -111,6 +114,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
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
index 5096500b2647..805e0e43ec66 100644
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
@@ -694,6 +715,31 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
 
+/**
+ * memblock_add_crypto_capable - add new memblock region capable of
+ * hardware encryption
+ * @base: base address of the new region
+ * @size: size of the new region
+ *
+ * Add new memblock region [@base, @base + @size) to the "memory" type
+ * and set the MEMBLOCK_CRYPTO_CAPABLE flag. See memblock_add_range()
+ * description for mode details
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_add_crypto_capable(phys_addr_t base,
+						phys_addr_t size)
+{
+	const phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
+		     &base, &end, (void *)_RET_IP_);
+
+	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES,
+				  MEMBLOCK_CRYPTO_CAPABLE);
+}
+
 /**
  * memblock_isolate_range - isolate given range into disjoint memblocks
  * @type: memblock type to isolate range for
@@ -884,6 +930,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
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

