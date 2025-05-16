Return-Path: <linux-efi+bounces-3730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA1AB9C22
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1FE1B6790B
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CE23FC68;
	Fri, 16 May 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQggBOxE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB923F291;
	Fri, 16 May 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398810; cv=none; b=PRLf12L1yvMxPVazzhY/eUeUiHtQ1vbL3o6XCONNNql2h4aQPpt/IqrQcmKjMFtUt8CUrGS+W7nePc7Sz+JL5b3ufi1IKDHlJat4NqgOQXaeF3D4LUqc3mTRxQFf4Vvkit8QF3P7cMC9WKLMncpOBypIQON8kxrpoiCQ1ZGscWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398810; c=relaxed/simple;
	bh=9/eYZH9fUVb4XvXJWOCTFMqsPVNNqU/AsYWyG9w11z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrYbFpWWKvsroFDCrX2yhXGTAQNyX1uQrc+reTZmrWldZkfxyexXUZc/5aF+SOSUJpL86BV+v7gLTkyqb1/9HUFuTANcMncG0lDqWJhXL30txEAJ1C/BAT4kcjSwRymMz6Uxm77x/5pr+FmFOcHFevY4O/TRdFMMrxZqI6V/UYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQggBOxE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398809; x=1778934809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/eYZH9fUVb4XvXJWOCTFMqsPVNNqU/AsYWyG9w11z8=;
  b=nQggBOxEGkOm3hJO1l0FcEQG5mXbSgfncebh0AJv5qKuenu52Nd7SUrV
   keBw5gcrTD9DrhoEk+QNKyt6KMDeJYl+zxKt7VNpn43lCt89ERl8eh3qH
   ZixAN80JrrkEEyO64BImiOsh7KW2IHFdwFL58674Wr1ulegAaUHbWZQaq
   g7vzH38TRptJ2AvaKsW0Po3m/7zim4iJ7aueskbD8bwuVdKHeZENtSTqY
   zpMIHA4dSiSRd/InCYGeY3eiaX3z8nzHYZyZPTlZp4TLb5JEy+BgLye1J
   8RiKH4iGVnIFD7x4OADcFAt0NP0n8kUBEUxFZXARIXiPlhsZyx07q+OH5
   g==;
X-CSE-ConnectionGUID: T4jdRRRbTeGMog55MurvQQ==
X-CSE-MsgGUID: MV/Z2v1NRnmHfuF9iub8xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53041527"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53041527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:33:26 -0700
X-CSE-ConnectionGUID: 8KA4Juk6Qe2o+yIqI66QHw==
X-CSE-MsgGUID: dLeDzTlhSFS2K47dOQjSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139216324"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2025 05:33:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 703DD29B; Fri, 16 May 2025 15:33:19 +0300 (EEST)
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
Subject: [PATCHv3 2/4] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
Date: Fri, 16 May 2025 15:33:04 +0300
Message-ID: <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
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

5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
being phased out, making 5-level paging support mandatory.

Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
any associated conditional statements.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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


