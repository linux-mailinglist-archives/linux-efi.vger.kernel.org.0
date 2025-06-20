Return-Path: <linux-efi+bounces-3849-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95366AE1CB9
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858AC7A4C3A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D324294A0D;
	Fri, 20 Jun 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSse4H3Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7728E610;
	Fri, 20 Jun 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427627; cv=none; b=uIg5+mVBmcG1rXMFEaGEajqYiLeQbr6BEwiruHeceUXZpx/h1H2+kQrWoTPGcPP2pogAT0rnZzKSFi0EEfv+gKND164k/ebnNSYpBCCrqWdWZXxWPJM3LHLIFOjfVVitv4nqvHH66QYNcE3c6tGFrsqP1PQao37v9t2FU4Yf9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427627; c=relaxed/simple;
	bh=QTbN9NXSoblvysDv8AoUns4aJP3a3HG8dD3wrltp4po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8edtJ2GcJj/tErGCeSEqAG+RK0sMUQguHeeKh93V6eNNTRYxmjcg7TOgKuZZxmbGOtTK5FYKRlac1ilV/tgZf93r7wClA+meDNJI/RE6Mxw+JqWYKm31RCO82eNzy09lh6MCBDqDnC89/JexqxXnQ2nVs2Uq5qKhIEnRLs1snY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSse4H3Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427626; x=1781963626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTbN9NXSoblvysDv8AoUns4aJP3a3HG8dD3wrltp4po=;
  b=hSse4H3Z580o9+vATJ3Nxs7Qwjucxq+2mGhd3Y6aaFj22AYSTZ5gSqgi
   c2fwvfr2Uy72tPgj3QPE4p+1vePqW9o3RsKiJzNiobv6BR++To2BtW5nV
   iQ1EK80zod3Yw3Ue7EyN9ttY++j+geWFCq03B4yWLXBI4UkwVwnmU/uYj
   qciiYFGixGwb9r4vGLrg3iI2z8fdf4X9up9Ju4WkR77i8keNad9Fbjn2r
   w/ODCD6/+CrQFv/VFdtEp6oRRbkGtYfn2EJeDiIJWncwRIffWX8vLIRyF
   6fXL7+RXlQDVS/Ex/fhPGztm5ZAT+0hyMMpDSuILJoxKbG+2hhnrlnjb1
   w==;
X-CSE-ConnectionGUID: 7NfkzfLWQwWoDr70TvIEAA==
X-CSE-MsgGUID: RTcaXiK2RXiIxVp2KQM1EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64047049"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="64047049"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:43 -0700
X-CSE-ConnectionGUID: n+0MzPtZQjqxYuXzQHPI7Q==
X-CSE-MsgGUID: BKM2Z4zZTT2q7PYD+E+s4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150411998"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 20 Jun 2025 06:53:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7E65820A; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
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
Subject: [PATCHv6 04/16] x86/efi: Move runtime service initialization to arch/x86
Date: Fri, 20 Jun 2025 16:53:12 +0300
Message-ID: <20250620135325.3300848-5-kirill.shutemov@linux.intel.com>
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

The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
the thing to the arch_cpu_finalize_init() path on x86 and get rid of
the #ifdef in start_kernel().

No functional change intended.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 7 +++++++
 init/main.c                  | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8feb8fd2957a..4f430be285de 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/efi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2529,6 +2530,12 @@ void __init arch_cpu_finalize_init(void)
 	fpu__init_system();
 	fpu__init_cpu();
 
+	/*
+	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_enter_virtual_mode();
+
 	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
diff --git a/init/main.c b/init/main.c
index 225a58279acd..f9f401b6fdfb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -53,7 +53,6 @@
 #include <linux/cpuset.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
-#include <linux/efi.h>
 #include <linux/tick.h>
 #include <linux/sched/isolation.h>
 #include <linux/interrupt.h>
@@ -1068,10 +1067,6 @@ void start_kernel(void)
 
 	pid_idr_init();
 	anon_vma_init();
-#ifdef CONFIG_X86
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_enter_virtual_mode();
-#endif
 	thread_stack_cache_init();
 	cred_init();
 	fork_init();
-- 
2.47.2


