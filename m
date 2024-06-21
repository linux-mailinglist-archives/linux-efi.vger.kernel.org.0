Return-Path: <linux-efi+bounces-1276-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F4912BAB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3B1F21EE8
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045C16849B;
	Fri, 21 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCuy782g"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82A160865;
	Fri, 21 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988268; cv=none; b=tLmL61a0/ucwYtioza0Bfy+P1qKv/14qiJjsaifkbc82DW1CifZ2VrurfyPoOnmC30MNYx783iBRNNDoyH1TXVjm1iKs+a4/pWwTUeHGKpuL1vaAgD6bukxBs4KTRzjlkbPe8L/pCE08LYu2i+UW0azBrdWizJjrO/AWBKmmePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988268; c=relaxed/simple;
	bh=vQhv6zBl+J5Tnsr+ly6iaE4iRU0OCteyzIdlEzGRYuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxaT7CIGyw/2AWbgC+LWVFhCperlikG3+00kF61EDpRuPmftIlRAtFCNkYWwJ1uhhZk4tXlWQjh6WV6c2cCD5BpR7fMpAU4doaEiM7+SU1Hbd0lpNLqqZCct2l2xFy1lT+phIw444O/LYWc2n3tvqJLSn7baJYQZw2aEItbqbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCuy782g; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718988267; x=1750524267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQhv6zBl+J5Tnsr+ly6iaE4iRU0OCteyzIdlEzGRYuI=;
  b=lCuy782gOhNJ889ttFhuYVq20H7XkMAT6IlUGLm+zGnm+JQeef6mRrsT
   86sCalfdqswI65wc1U36uvu5TMKsyZwrt4rjafTAgO/TRKpOgedgUn7vl
   VeG0pL+dueNeJqDM2csS/8O53lIhOeBy7+jvQzW+V7Enu6FSK60BzIy7d
   R3RF0Rf1bxBfAjInWhY3vapu/nbUWM1Rz+dREX3132siPMPaCPm8jP3m3
   zrYxJ+ZyB1s42HF6cRQuYZjLQa0px9Aoxg2xTUz9trmisfmdEJ6vqRkxd
   JD0v7I7GC2xp1uksPuOeI+40lOXhgd2Iktem5VQ6q4jVrtGRnF60RyA8d
   A==;
X-CSE-ConnectionGUID: Z3C/CHeARVOYpQXFBIuzbQ==
X-CSE-MsgGUID: h36VyECMSpGQ5c3puvEqkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15727182"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15727182"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:44:24 -0700
X-CSE-ConnectionGUID: irTw7mS5TLWlF9ye/qQdGg==
X-CSE-MsgGUID: s2D0gDk6ReGQKZ1Ozj6i6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42745631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Jun 2024 09:44:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 42799122; Fri, 21 Jun 2024 19:44:17 +0300 (EEST)
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
Subject: [PATCH 1/3] x86/64/mm: Always use dynamic memory layout
Date: Fri, 21 Jun 2024 19:44:04 +0300
Message-ID: <20240621164406.256314-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621164406.256314-1-kirill.shutemov@linux.intel.com>
References: <20240621164406.256314-1-kirill.shutemov@linux.intel.com>
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
index e30ea4129d2c..827928680ed6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1501,7 +1501,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select DYNAMIC_MEMORY_LAYOUT
 	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
@@ -2237,17 +2236,10 @@ config PHYSICAL_ALIGN
 
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
index 06ef25411d62..c2f3c50a2787 100644
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
index 9053dfe9fa03..09df8939b997 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -130,15 +130,9 @@ extern unsigned int ptrs_per_p4d;
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
 
 /*
  * End of the region for which vmalloc page tables are pre-allocated.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..ec36ad7117ae 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -60,14 +60,12 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
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
 
 static inline bool check_la57_support(void)
 {
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
2.43.0


