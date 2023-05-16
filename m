Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40737704D64
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjEPMHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjEPMHH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 08:07:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1022213A;
        Tue, 16 May 2023 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684238824; x=1715774824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzWOm3Mewv0PjnBqLlqHuGcExnpl6kTEJiKYo8/CWf0=;
  b=SjkKdDdMLKlpOIyZG1BMmOgLWAm2V6mYY9CStjMe3mtcMxChaYdzElVg
   z5lcq99I25RYtw+MLmjJ/EoFvHxuNTWZ8ZvYbQDslEBN4DhokwQRp72K2
   uphPOPFrYkeCO2i4mLbq+Twa8qZmkS1evemADS4umcFQfpVIt479sC7oe
   ihGeLOLLISVTSAGD6jNkMoidfv12CxjigksYBhdhWNMsetHXHm18XjOpK
   +0U8GvdgOm1UYIv2u3oulFwGsOaq8wJqSkdfblzngVgIshgW9Unh3qP+b
   NnJpLaY90kmQcGod7A/LXG7HFzGOimsxqTKDz/0I3LF6Zx9Oqzfjcn3/p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350294644"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="350294644"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678828131"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678828131"
Received: from unisar-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.243])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:06:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9DA9310DF0F; Tue, 16 May 2023 15:06:53 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill.shutemov@linux.intel.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        khalid.elmously@canonical.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, marcelo.cerri@canonical.com,
        mgorman@techsingularity.net, mingo@redhat.com, pbonzini@redhat.com,
        peterx@redhat.com, peterz@infradead.org, philip.cox@canonical.com,
        rientjes@google.com, rppt@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        tim.gardner@canonical.com, vbabka@suse.cz, x86@kernel.org
Subject: [PATCHv11.1 5/9] efi: Add unaccepted memory support
Date:   Tue, 16 May 2023 15:06:46 +0300
Message-Id: <20230516120646.31195-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-6-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_config_parse_tables() reserves memory that holds unaccepted memory
configuration table so it won't be reused by page allocator.

Core-mm requires few helpers to support unaccepted memory:

 - accept_memory() checks the range of addresses against the bitmap and
   accept memory if needed.

 - range_contains_unaccepted_memory() checks if anything within the
   range requires acceptance.

Architectural code has to provide efi_get_unaccepted_table() that
returns pointer to the unaccepted memory configuration table.

arch_accept_memory() handles arch-specific part of memory acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

v11.1:
 - Add missing memblock_reserve() for the unaccepted memory
   configuration table.

---
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/efi.c               |  25 ++++++
 drivers/firmware/efi/unaccepted_memory.c | 103 +++++++++++++++++++++++
 include/linux/efi.h                      |   1 +
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/firmware/efi/unaccepted_memory.c

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index b51f2a4c821e..e489fefd23da 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7dce06e419c5..d817e7afd266 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	.coco_secret		= EFI_INVALID_TABLE_ADDR,
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	.unaccepted		= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
+#endif
 #ifdef CONFIG_EFI_GENERIC_STUB
 	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
 #endif
@@ -759,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
+		struct efi_unaccepted_memory *unaccepted;
+
+		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
+		if (unaccepted) {
+			unsigned long size;
+
+			if (unaccepted->version == 1) {
+				size = sizeof(*unaccepted) + unaccepted->size;
+				memblock_reserve(efi.unaccepted, size);
+			} else {
+				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
+			}
+
+			early_memunmap(unaccepted, sizeof(*unaccepted));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
new file mode 100644
index 000000000000..bb91c41f76fb
--- /dev/null
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <linux/memblock.h>
+#include <linux/spinlock.h>
+#include <asm/unaccepted_memory.h>
+
+/* Protects unaccepted memory bitmap */
+static DEFINE_SPINLOCK(unaccepted_memory_lock);
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, range_end;
+	unsigned long flags;
+	u64 unit_size;
+
+	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
+		return;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
+				   DIV_ROUND_UP(end, unit_size)) {
+		unsigned long phys_start, phys_end;
+		unsigned long len = range_end - range_start;
+
+		phys_start = range_start * unit_size + unaccepted->phys_base;
+		phys_end = range_end * unit_size + unaccepted->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted->bitmap, range_start, len);
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long flags;
+	bool ret = false;
+	u64 unit_size;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return false;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return false;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	while (start < end) {
+		if (test_bit(start / unit_size, unaccepted->bitmap)) {
+			ret = true;
+			break;
+		}
+
+		start += unit_size;
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return ret;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 29cc622910da..9864f9c00da2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -646,6 +646,7 @@ extern struct efi {
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
+	unsigned long			unaccepted;		/* Unaccepted memory table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
-- 
2.39.3

