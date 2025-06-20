Return-Path: <linux-efi+bounces-3847-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9AAE1CB6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871E83BC8F9
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76028FFE7;
	Fri, 20 Jun 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ8fkJ3N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0028A3FA;
	Fri, 20 Jun 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427625; cv=none; b=iTofMtt/gfeN9wn4gkCo33Ak3OOdnuoiAX/tvn3xVnp1uYen9BCd8i+9rJ6NvnL2C9qXG0ldHuMzhZ8bat/JKfZkfS2qSaXYG8dDmtj0iizfN4DeDbPFF+YTJ4MQAe0fqUmcELcBxHtp6GTqfNHszd5KWT0Q6d+S+aUDh6zipOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427625; c=relaxed/simple;
	bh=N62kbho1jMdeETBlPvgpq8U6Bw47E8U+afNewvipmRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuLfxxmrKaI0f/kL/nsCKX/YhKA2kwr/JJGY6jL0/PXOSypdP7HzAAVQiql/ba7lvOfzJ2SX06+l+CLI/V1oq8KfFCVsqSPr/Hf51veHwyE6B2xYHREDv+IlGXD0z5wAIb7LSx5i1RXm07MGdEakFh/nykzdTNSelOpx4CoPVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ8fkJ3N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427624; x=1781963624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N62kbho1jMdeETBlPvgpq8U6Bw47E8U+afNewvipmRc=;
  b=OJ8fkJ3NX7dYDn2XvXISfaCad6xUASl2b1swVdO125LV7eH5ei1bXmtM
   RJlYeKAGFfZjFjTVx8V1ModBFgF+o52e1EZsYXfRsa2vxDkV1y+krBpQG
   XDBA99dtP0E/6XZd9lnofvgW0/jFoCjcdl+Mgsfhg89J8lpY2iiijTLz1
   8EOIGJU7yrOQwLJwPgh5J6QA7GK7/120SlxIUcQ3itWJE7anaeKNi32H5
   FkQChxf3caZrmuYQ32SiLukrJoq0NKW8fSoerPY615mGfMrus4sJNY3La
   MCc081uRFax+LhCj532tL7RYkVLCnE6CWXeJyZ5HPdGTJcfDxXGh47rJZ
   Q==;
X-CSE-ConnectionGUID: waY6nITTR8isX2HNIhYFOg==
X-CSE-MsgGUID: L8OLEa3mR6+vuaW3mqCB5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55326060"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="55326060"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:43 -0700
X-CSE-ConnectionGUID: VmCNAmhNQ3GnZINpICb0UQ==
X-CSE-MsgGUID: EhLoZQRUTZGUkYJvmk4JQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151227074"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 06:53:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8CA742C0; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 05/16] x86/cpu: Defer CR pinning setup until after EFI initialization
Date: Fri, 20 Jun 2025 16:53:13 +0300
Message-ID: <20250620135325.3300848-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

In order to map the EFI runtime services, set_virtual_address_map()
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around
this call. This can only be done before the CR pinning is set up.

Move CR pinning setup behind the EFI initialization.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4f430be285de..1a779e302872 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2081,7 +2081,6 @@ static __init void identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
-	setup_cr_pinning();
 
 	tsx_init();
 	tdx_init();
@@ -2532,10 +2531,21 @@ void __init arch_cpu_finalize_init(void)
 
 	/*
 	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 *
+	 * It also needs to precede the CR pinning setup, because the CR4.LASS
+	 * bit has to be cleared temporarily in order to execute the
+	 * set_virtual_address_map() EFI call, which resides in lower addresses
+	 * and would trip LASS if enabled.
+	 *
+	 * Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not
+	 * enough because AC flag gates data accesses, but not instruction
+	 * fetch. Clearing the CR4 bit is required.
 	 */
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		efi_enter_virtual_mode();
 
+	setup_cr_pinning();
+
 	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
-- 
2.47.2


