Return-Path: <linux-efi+bounces-4159-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE0AFAE1A
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F984218D4
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E36293C65;
	Mon,  7 Jul 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9JeVgnF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419C29346F;
	Mon,  7 Jul 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875426; cv=none; b=Gz1aCjM2RKRqistEYyhDi+JQeZ3sD5DY8su/p7ZiZhwMAS6/8Dsm6t5NMgNhgbAHdAFqrI81gbh/XtblDMV+N/fyYMPrybdq2/BK7HY4VnyFpSO0AiemwNKUgT04P2ULVvyzumhI6ODmBM3lbkY8KzLfx3hFKlV4sV4FdpHfNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875426; c=relaxed/simple;
	bh=zmJ0SsTgrIsGwH/KhdgcrCgX4qTp57IuWr6AQEqkrvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXRcjzLAdMpLnUaCJ+2b2oB+/qPxXCvQRmCQWqjUUQYQAK4GG8Ua8SgnztAUwse/IRVIEYqfWe25/1d4tpofQuW8SSWbB1GD2m2w6xcW6Z5w3kEsnb82u7hRsS+KIyaL6azRDz+SpMEqFBuW6+abMQkZhffcc+IuBgCx6xXbSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9JeVgnF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875425; x=1783411425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmJ0SsTgrIsGwH/KhdgcrCgX4qTp57IuWr6AQEqkrvM=;
  b=R9JeVgnF33ux6dCFjWbHNtmVyF+ePU3No+J2GfIHLYxO8DOE2uf6GMM2
   w7iYzPtzbAXRcQ36ZAj0Dg2saiEYod8rBgL6U25s7kg4jAnnxyVNIKtM/
   kB+V/8ZK/BldukDsYoqjMOOVr/hYykz1o+YsinBfNcV3rNJcvyM1Ib+Th
   pjjpI2DRSxaiV1KvPx2FpczOT/hx1cgy0nWL3qZc4IXhknmx81z0uYE5w
   QEUBtJfKxmmrwep8TL9VJidAW1awA2NuOEv9+2hSPmbdkz9ClFwEb1H3R
   TtOeSpyrx9gzX8yD4DcfCwRvD/deBRceH8otFx9cOjxk+BpVZNWPkLzC7
   Q==;
X-CSE-ConnectionGUID: jGf0D+X+Tn6S3Lda1D+/Hw==
X-CSE-MsgGUID: OuNsnhRdTna6X2RmOVyZ6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="57891170"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="57891170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:43 -0700
X-CSE-ConnectionGUID: 2AH2cPTGSACdcl2bkvyuZQ==
X-CSE-MsgGUID: rhjMIjipQl++rGKx2/3w4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="186171990"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 07 Jul 2025 01:03:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6D8F4BC2; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 16/16] x86: Re-enable Linear Address Masking
Date: Mon,  7 Jul 2025 11:03:16 +0300
Message-ID: <20250707080317.3791624-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.

LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
commit made LAM depend on LASS, so we no longer need to disable LAM at
compile time, so revert the commit that disables LAM.

Adjust USER_PTR_MAX if LAM enabled, allowing tag bits to be set for
userspace pointers. The value for the constant is defined in a way to
avoid overflow compiler warning on 32-bit config.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig             | 1 -
 arch/x86/kernel/cpu/common.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..2b48e916b754 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2181,7 +2181,6 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
-	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382b687ce7e2..7ae757498a6f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2553,11 +2553,8 @@ void __init arch_cpu_finalize_init(void)
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
 
-		/*
-		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
-			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
-		 */
+			USER_PTR_MAX = (-1UL >> 1) & PAGE_MASK;
 		runtime_const_init(ptr, USER_PTR_MAX);
 
 		/*
-- 
2.47.2


