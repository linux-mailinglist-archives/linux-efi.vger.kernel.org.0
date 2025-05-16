Return-Path: <linux-efi+bounces-3716-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1650AB9874
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C39E85F6
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDAD230996;
	Fri, 16 May 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSoy9zme"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1B230274;
	Fri, 16 May 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386946; cv=none; b=nU705I73uNKnmJeygavX3s0tHlEmLhJ71UAWWkMgqXUgVululuS1jlwruT8Ove8LuHbfNIJ9/7L5BCzcZGCFt7iq3KzcGJKrkou93gafAT6ykhIw9gUvbQWsiEPlgHVYBPcqPwC8nVc/bb0yJ43bZ7aQkh7P7h29jLPHwGsspLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386946; c=relaxed/simple;
	bh=qHa068Z4tNA2EKL3RSWrNOGmS2Oavr7psnUz+YrP6jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctpLxTFOUwkyJZrDYdWg9/1CsC9Mh9ji/9GUp8fn4BMw/xMqdSfFA24AoBdb/2MpOmmbFvLRxKy7nGFUY+b3p65QDZPW7wLHpysoNKxqA5yRX3DUb3OB4xZKmcVA9Sc6rCGu1jqtAG7kdWXTbxFf19AtsIg9f5Y+JtU0pYnHBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSoy9zme; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747386944; x=1778922944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHa068Z4tNA2EKL3RSWrNOGmS2Oavr7psnUz+YrP6jU=;
  b=FSoy9zmeV3Z0vPTyiOQd3zXnHF4qwqmCzjmMqA3VHFPvpORWlp4yL7bR
   FbzD/cA0jqowQIHybuu7zX/fSNOzhKqpDMW9VYjYUhZjAUW63U77L2ymu
   T94kU5dPPt/3FHu5bnl2HHCX8H9BSWSg+tGuFv0FC/sreTLzIW+o/X2IA
   sAugGxyJ/4vZw3pox55A0FVyoHa2XtS/L0C7leYm+7sG2gbyAceQ4fTu2
   zqMYf4I7b1Fyo1CFauKu4VU4dUzszMI5FMGuQIXpeThFJwfO7VfbWDWDQ
   CK8fKiDRkBbidFOZsnTKXbMQkiOHOY9AwSiDS0vXa6JxPxTbWaRjc9sl4
   A==;
X-CSE-ConnectionGUID: rsOLf6kORveah6OeEVlYcw==
X-CSE-MsgGUID: ZkTBUtEbTAybxoantLvHdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48605808"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48605808"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:15:43 -0700
X-CSE-ConnectionGUID: DsjJgBYNRiiX9ads9rcshQ==
X-CSE-MsgGUID: 4fl8596/SnCRBtotG2f4ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143749858"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2025 02:15:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 03A7323F; Fri, 16 May 2025 12:15:36 +0300 (EEST)
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
Subject: [PATCHv2 1/3] x86/64/mm: Always use dynamic memory layout
Date: Fri, 16 May 2025 12:15:31 +0300
Message-ID: <20250516091534.3414310-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
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


