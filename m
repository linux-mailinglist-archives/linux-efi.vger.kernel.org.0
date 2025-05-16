Return-Path: <linux-efi+bounces-3731-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81866AB9C27
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCFDA21AC6
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5C241666;
	Fri, 16 May 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfQWAgML"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58323E35B;
	Fri, 16 May 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398810; cv=none; b=eEinJPaWBUHBVZZDjLb7A/GHXWv4U2gkaGRf+oRhbZPcqEkXVU3YcC6yoP4eLFE84nTV68wZz02J0WOB9BJIPqQJJi0En6E68/qnfcGCRpB9YSUNp9ptUhuLH6y4qFE5LMrgSJbqLTP7kgyGb10PjnPGS0uPPpUo3VE4CgR0mBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398810; c=relaxed/simple;
	bh=FwrfgfPnkyr0CzbMfObW1YFvcM2OTU+7sWSLkHKG0wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o64PXvp+eADM4q5L8757GFHIfg6SlIbd0S3PlH5Ux0dTdAn4DwZXMuF9/BfBsiHKgjqQjvPlfokZ5XgUkJ88t8Zph/4HBlBhGbk7pyYNF06Un/HXzNXdxEt42wnkzdMPa6FWrxGcGButDLvtoAsNx77ahVFdWeZ0neF9kEfgrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfQWAgML; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398808; x=1778934808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FwrfgfPnkyr0CzbMfObW1YFvcM2OTU+7sWSLkHKG0wM=;
  b=gfQWAgMLerf80+zyLY6cU8wKymdrbO/DG8clFnaXJEh5BsAQGb70OluL
   fJs1z8O5efTj9mYH2a2KYTkVhNwK3Wmn4V4KhKh/89ZFSGk49CLQLJLMC
   oYWqNUxPpKEPKOllb5mFtQR41a4qk7+DGcSodXVAiUKNfIepE692zhcMD
   rj1lpfdaE7uQVAzjRxNo/mMBE8mmoxvTZy0UW0v66LfM/cteqBm4KoJkS
   Ob2SX/co3+1sdeF8AdoorEE6NCaUeBt1oYR8NM5nJ8FhI+f2pGti98aRT
   HXWetbBOKYX3JdiUf4J2T1hwrYHmEP+iUDU9JygXQTqzeO4DVqApqHBa6
   A==;
X-CSE-ConnectionGUID: SLQi+1WTRsSQXRiON4rbcQ==
X-CSE-MsgGUID: OAAi5rOmScOsWGTnKuAW/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53041514"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53041514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:33:26 -0700
X-CSE-ConnectionGUID: noMYREHpQric5xrp77ZBhQ==
X-CSE-MsgGUID: WuumLvnSSjyhvXy9pxq7Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139216322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2025 05:33:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 60E58131; Fri, 16 May 2025 15:33:19 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCHv3 1/4] x86/64/mm: Always use dynamic memory layout
Date: Fri, 16 May 2025 15:33:03 +0300
Message-ID: <20250516123306.3812286-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic memory layout is used by KASLR and 5-level paging.

CONFIG_X86_5LEVEL is going to be removed, making 5-level paging support
unconditional which requires unconditional support of dynamic memory
layout.

Remove CONFIG_DYNAMIC_MEMORY_LAYOUT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                        | 8 --------
 arch/x86/include/asm/page_64_types.h    | 4 ----
 arch/x86/include/asm/pgtable_64_types.h | 6 ------
 arch/x86/kernel/head64.c                | 2 --
 scripts/gdb/linux/pgtable.py            | 4 +---
 5 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 891a69b308cb..d3c2da3b2f0b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1467,7 +1467,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select DYNAMIC_MEMORY_LAYOUT
 	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
@@ -2167,17 +2166,10 @@ config PHYSICAL_ALIGN
 
 	  Don't change this unless you know what you are doing.
 
-config DYNAMIC_MEMORY_LAYOUT
-	bool
-	help
-	  This option makes base addresses of vmalloc and vmemmap as well as
-	  __PAGE_OFFSET movable during boot.
-
 config RANDOMIZE_MEMORY
 	bool "Randomize the kernel memory sections"
 	depends on X86_64
 	depends on RANDOMIZE_BASE
-	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	help
 	  Randomizes the base virtual address of kernel memory sections
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 1faa8f88850a..6b8c8169c71d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -41,11 +41,7 @@
 #define __PAGE_OFFSET_BASE_L5	_AC(0xff11000000000000, UL)
 #define __PAGE_OFFSET_BASE_L4	_AC(0xffff888000000000, UL)
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
-#else
-#define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
-#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index e83721db18c9..eee06f77b245 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -128,15 +128,9 @@ extern unsigned int ptrs_per_p4d;
 #define __VMEMMAP_BASE_L4	0xffffea0000000000UL
 #define __VMEMMAP_BASE_L5	0xffd4000000000000UL
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
 # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
-#else
-# define VMALLOC_START		__VMALLOC_BASE_L4
-# define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
-# define VMEMMAP_START		__VMEMMAP_BASE_L4
-#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 # define DIRECT_MAP_PHYSMEM_END	direct_map_physmem_end
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 14f7dda20954..9f617be64fa9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -59,14 +59,12 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
 #endif
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
-#endif
 
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
diff --git a/scripts/gdb/linux/pgtable.py b/scripts/gdb/linux/pgtable.py
index 30d837f3dfae..09aac2421fb8 100644
--- a/scripts/gdb/linux/pgtable.py
+++ b/scripts/gdb/linux/pgtable.py
@@ -29,11 +29,9 @@ def page_mask(level=1):
         raise Exception(f'Unknown page level: {level}')
 
 
-#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
-POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
 def _page_offset_base():
     pob_symbol = gdb.lookup_global_symbol('page_offset_base')
-    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
+    pob = pob_symbol.name
     return gdb.parse_and_eval(pob)
 
 
-- 
2.47.2


