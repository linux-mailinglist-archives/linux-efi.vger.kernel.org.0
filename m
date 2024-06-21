Return-Path: <linux-efi+bounces-1275-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F1912BA8
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C71C2688E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476EB166311;
	Fri, 21 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ih3Si3Ao"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69491607AD;
	Fri, 21 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988268; cv=none; b=Hx969sgQJxYpts+dr1SPmPVdI+pxrUDhI+F4YUMliLuf4Ua8yh0BlMZxhXplqR1vZnNguEeHAGYuicLZMuCySjKVJdBn8s4UPHjf9CudYP6cw8v1HlLeStUpn64th/8BNHELddIhgj0E/rtwpBbrcMiTYqd3Mm5AhhZDirDustI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988268; c=relaxed/simple;
	bh=1jHhrYMe7a3/ohkHtpaJJmyxwj3amjnL9BxFfmnB90E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To2WIgvZ0UpgMy07pSfHDzdErkTawiX+DCbKzBYBqwb4UZ7Nb2NOCvtndklYINMDX+aunLOsa1uDz8Cr6eF3R2fzpQdv3hHQwoNgBq5UXQb8ryR5VGvjc1B/oBePD3lOYMd+OdPfEZLSCXwLQttK602+O7lH2zCp4s20TdWesF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ih3Si3Ao; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718988267; x=1750524267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jHhrYMe7a3/ohkHtpaJJmyxwj3amjnL9BxFfmnB90E=;
  b=ih3Si3AoW/6UskLj1aevPovzuzl60xDjrJSll/p6UOQ/64CViirMBttK
   trOZ5EOOB9vumA+f9gemqOncG58/YaCZ5O2jaBZROFsW8TJXHC/uBRqYs
   LyGrWEhgGAgasUEOe7j9OG3Ld9qTZPfsjB4ZLk0Z48x0FluEgaY1vFHfn
   8PFUfmYDP7fYiCtKPw7OpPRUVJKeG6kn7BSa6K3yjG285ksGg1gzeBgao
   co8F9ImDNKgzGtuHTIizPK3oANEc/YPqocyEASkTWzgHCCy/XMnYR+c2Y
   Gghe/4gQZUF+Hl8cBzUBE45wY1PQtneojn0AyapgzGmLqS2061VvUhafz
   Q==;
X-CSE-ConnectionGUID: XMiNO8V0SLKVRFNBDeaNVg==
X-CSE-MsgGUID: kPPvrddFRCCu1bsEIzKFvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15727160"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15727160"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:44:23 -0700
X-CSE-ConnectionGUID: a4aJpdS9R9qGyjNv7x3NEg==
X-CSE-MsgGUID: ScJEe9lLTj2jJq5Yf9OUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42745628"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Jun 2024 09:44:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4E5FB1F8; Fri, 21 Jun 2024 19:44:17 +0300 (EEST)
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
Subject: [PATCH 2/3] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
Date: Fri, 21 Jun 2024 19:44:05 +0300
Message-ID: <20240621164406.256314-3-kirill.shutemov@linux.intel.com>
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

5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
being phased out, making 5-level paging support mandatory.

Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
any associated conditional statements.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig      | 2 +-
 arch/x86/mm/init_64.c | 9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 827928680ed6..54ad2462e9ef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1501,7 +1501,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
@@ -1625,6 +1624,7 @@ config ARCH_SPARSEMEM_ENABLE
 	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
+	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 28002cc7a37d..552a11d5829a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -835,7 +835,6 @@ void __init paging_init(void)
 	zone_sizes_init();
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 #define PAGE_UNUSED 0xFD
 
 /*
@@ -934,7 +933,6 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	if (!IS_ALIGNED(end, PMD_SIZE))
 		unused_pmd_start = end;
 }
-#endif
 
 /*
  * Memory hotplug specific functions
@@ -1133,16 +1131,13 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
-			}
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-			else if (vmemmap_pmd_is_unused(addr, next)) {
+			} else if (vmemmap_pmd_is_unused(addr, next)) {
 					free_hugepage_table(pmd_page(*pmd),
 							    altmap);
 					spin_lock(&init_mm.page_table_lock);
 					pmd_clear(pmd);
 					spin_unlock(&init_mm.page_table_lock);
 			}
-#endif
 			continue;
 		}
 
@@ -1490,7 +1485,6 @@ unsigned long memory_block_size_bytes(void)
 	return memory_block_size_probed;
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
  */
@@ -1639,4 +1633,3 @@ void __meminit vmemmap_populate_print_last(void)
 		node_start = 0;
 	}
 }
-#endif
-- 
2.43.0


