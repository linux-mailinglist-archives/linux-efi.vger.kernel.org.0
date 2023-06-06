Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C7245E9
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjFFO1x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbjFFO1u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 10:27:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB8EE42;
        Tue,  6 Jun 2023 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686061669; x=1717597669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsajNby4k25P3GH221zoPAce6NyJi0NyX4YPbFlC4wQ=;
  b=OJpVx8O/+BP8dZZP9JhATrBol5Gju3R3XiMmGokbFbRuMfbFvTSbeGIp
   VdK7AObRn0p0Kft2nvaKCcE4uaJN/M3M6wqV1FZCyzhM61c9HXdkeLbBJ
   g9ggL4WBQUGMm4LG0jOy+8CwZbgFnFsOULqIdBInjPYQ8TXldaKKJ73eN
   HuOxGu3IuWbnNVSLXHnv7bEJ50wcELzbqfd31lZIRxMn6Dx5NzGOlcTWS
   cuxO/SiT8dKJamgVOcWUd+qBoudPD7vNqBE5HyTMj7FDkuodXMjsHwL8U
   2MureQw4NAzP5ZB7NmTKRGUx48MeXaNGR8QqhvfMBf6K3vElR8nV2S2Dq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341337203"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341337203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738815175"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="738815175"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:26:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5619010D6F6; Tue,  6 Jun 2023 17:26:42 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 5/9] efi: Add unaccepted memory support
Date:   Tue,  6 Jun 2023 17:26:33 +0300
Message-Id: <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/platform/efi/efi.c              |   3 +
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/efi.c               |  25 +++++
 drivers/firmware/efi/unaccepted_memory.c | 112 +++++++++++++++++++++++
 include/linux/efi.h                      |   1 +
 5 files changed, 142 insertions(+)
 create mode 100644 drivers/firmware/efi/unaccepted_memory.c

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f3f2d87cce1b..e9f99c56f3ce 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -96,6 +96,9 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	&efi.coco_secret,
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	&efi.unaccepted,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
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
index 000000000000..08a9a843550a
--- /dev/null
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -0,0 +1,112 @@
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
+/*
+ * accept_memory() -- Consult bitmap and accept the memory if needed.
+ *
+ * Only memory that is explicitly marked as unaccepted in the bitmap requires
+ * an action. All the remaining memory is implicitly accepted and doesn't need
+ * acceptance.
+ *
+ * No need to accept:
+ *  - anything if the system has no unaccepted table;
+ *  - memory that is below phys_base;
+ *  - memory that is above the memory that addressable by the bitmap;
+ */
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, range_end;
+	unsigned long flags;
+	u64 unit_size;
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

