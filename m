Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9B701A84
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEMWFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjEMWEz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008330E0;
        Sat, 13 May 2023 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015493; x=1715551493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vzNujRVXgfcy7qjArGlQaKcw6ocTEeuAnyV8Bln9kG4=;
  b=GfnJVBW8kpVpU87yrB3j9QostD4A0DFel3kpBJGAuS+ETFtRVfi4NN4a
   Br58RYMBJb2ibgTtHEvol1XNwa2czxuYZ3xET6xtLpRYym3aKwzr1xgy4
   4E6hG2hyazCVCbIL9KMetsSdVv1XXvENBvD5Kh8YWe+FYqGIPpvYIWq/E
   bSIMnYDRaHuG3OI7VDs64sYw50o+zyESR5tdwsn7YQ5oGaLkbcs01HsSG
   nZZJY5jEBSAhdD6BmpQXMKISQ5SJe4m4wAqbFZ6Qj2xcIYoe0iSO0EZJm
   OvwV7YMABSvFD86F2hIUC6m2wT/Ctc4PhvcCE0xXsw35pBDyQuwj7EtN5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="379142563"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="379142563"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="733429554"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="733429554"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1087C10CF7B; Sun, 14 May 2023 01:04:34 +0300 (+03)
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
Subject: [PATCHv11 5/9] efi: Provide helpers for unaccepted memory
Date:   Sun, 14 May 2023 01:04:14 +0300
Message-Id: <20230513220418.19357-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Core-mm requires few helpers to support unaccepted memory:

 - accept_memory() checks the range of addresses against the bitmap and
   accept memory if needed.

 - range_contains_unaccepted_memory() checks if anything within the
   range requires acceptance.

Architectural code has to provide efi_get_unaccepted_table() that
returns pointer to the unaccepted memory configuration table.

arch_accept_memory() handles arch-specific part of memory acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/efi.c               |   6 ++
 drivers/firmware/efi/unaccepted_memory.c | 103 +++++++++++++++++++++++
 include/linux/efi.h                      |   1 +
 4 files changed, 111 insertions(+)
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
index 7dce06e419c5..e15a2005ed93 100644
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

