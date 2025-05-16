Return-Path: <linux-efi+bounces-3718-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D3AB9876
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8394E7C38
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32A230D2B;
	Fri, 16 May 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a35dFR+1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC72309AF;
	Fri, 16 May 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386948; cv=none; b=uOgMGg2sbJYimdEM3QvGxQ0CScQ+t3qIqmyfMUP/I4yykYX81a8y2TKnu/VMV5jnADPWtrnIsVymREUv6eR40Su6vlEeJjLCYA1xUYFbRca4qL/ovHVUbyDwznzqwFluUF55731FKqH1/9N9F5qRWoCsSuVIYAcPo7r+xB2uvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386948; c=relaxed/simple;
	bh=2KE05UQzIRlAfabsyuWXczUgkDHBW/1hRqGuOVIU5fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou4eZGYjKoyg4ecYl/8K67MBSqqaDYg+8jUuZXk0vsYT+YM3XF8uQ8c9WuTuo0y1oKem5CVmcX2XbTOLw4qBQrdA4u/p8PlrDvz76C/7DdJoEioqTYSdlIjVZBJqsAhGjCbi7OJd5Cj7zqFbPliQR/4LrTddwdM75ldtPt6qQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a35dFR+1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747386946; x=1778922946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2KE05UQzIRlAfabsyuWXczUgkDHBW/1hRqGuOVIU5fY=;
  b=a35dFR+1TeG6m6a5gGmSQ+gm6pDPUmQ4dWX5ZWxfvFauj8YopbwmuP1B
   DZIxY7ljEDDS7iNnIe4a8JoUAF31U6CvCArxwB+g8WHTzLIWUj/136Wze
   1Pu2SU+GL1fSUz1KX6WFkSPZSGkNVWZ0hfc3KjA3AIl4HyNFt4Y744MTB
   nIufa/XotWaGg7EAbBeUjDmWquAq64ndktxA7kaM9V2KwrqzPF83LiczV
   w4Uj8PX0l4SmbRMxEMyghPmq6nCb+TI3OBRbIZtGWCtOO+C136olCEl7W
   er3uzDWe7FKv+9iu8i9Y5sDGO+mn2j1XefMyLslqF0Acjegmc17yr43+G
   w==;
X-CSE-ConnectionGUID: 5B93RP3LQT+2lg0BOaqPZg==
X-CSE-MsgGUID: xzcUPLXKRPGppqHHkzZ6BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60375790"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60375790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:15:43 -0700
X-CSE-ConnectionGUID: 1Wy1vj20STWNM0bHPQPhMg==
X-CSE-MsgGUID: b0/PqiYPSpehnIaTM11IXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138527546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 16 May 2025 02:15:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1768846C; Fri, 16 May 2025 12:15:37 +0300 (EEST)
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
Subject: [PATCHv2 2/3] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
Date: Fri, 16 May 2025 12:15:32 +0300
Message-ID: <20250516091534.3414310-3-kirill.shutemov@linux.intel.com>
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
index d3c2da3b2f0b..45b36a019b5e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1467,7 +1467,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
@@ -1579,6 +1578,7 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
+	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index bf45c7aed336..66330fe4e18c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -833,7 +833,6 @@ void __init paging_init(void)
 	zone_sizes_init();
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 #define PAGE_UNUSED 0xFD
 
 /*
@@ -932,7 +931,6 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	if (!IS_ALIGNED(end, PMD_SIZE))
 		unused_pmd_start = end;
 }
-#endif
 
 /*
  * Memory hotplug specific functions
@@ -1152,16 +1150,13 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
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
 
@@ -1500,7 +1495,6 @@ unsigned long memory_block_size_bytes(void)
 	return memory_block_size_probed;
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
  */
@@ -1647,4 +1641,3 @@ void __meminit vmemmap_populate_print_last(void)
 		node_start = 0;
 	}
 }
-#endif
-- 
2.47.2


