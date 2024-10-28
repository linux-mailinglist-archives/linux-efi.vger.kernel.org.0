Return-Path: <linux-efi+bounces-2027-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693B9B35F4
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2C4B230A5
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9A1DEFD7;
	Mon, 28 Oct 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuCmtkvi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047A1DED6D;
	Mon, 28 Oct 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131828; cv=none; b=uiasrgQWd9YDZM22dAPu9uFDUYwYWoYMJPxKEXG+INchxM9/H/Jiynlqns3UXn7fmQof/U6fO0yigS6l9RnpZnVbz7Q+OHu1KtU6nIrNvL+EtODfVhaFGWtolH2JVd7nHrcEzLiJe5CfRlokrXi/IU6zgxLfp2JbSlnthVhHOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131828; c=relaxed/simple;
	bh=NS1oZqVmDFSqOd7suxOZQbWGb+FfwQyfnc6oWKU6zlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czj33TWc9ndPKQJeRUSzgEVDDqr9Hv1QdSGwebY+DdkNjx3pSAy508WRsTNu5xZgSJng4gTtDuMl4ltQU5CgTtMf6zMcfvDLY12ygTYkQXR46X7nsmJeX8lul8iUc9Ke1zmmslIObRzYuroO/DIDVe8PGWTS7k8WkZ2hWDQZhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuCmtkvi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131827; x=1761667827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NS1oZqVmDFSqOd7suxOZQbWGb+FfwQyfnc6oWKU6zlU=;
  b=cuCmtkvitEPJgPO4vzlQJf1PrEpsDapQioAcAy6TdS87N4oT2++vEPQ/
   818R8HtePCPTcHEEbjbfbN+fwt6JKLkiah8sc5Tc0U5SdFM15R0c20Rze
   0H2H+nmkE8/lLycnE+0cvOSGY9giqbSQ0C4OydAf0n1jSah+7Rk/hJS7n
   t4iW2Femz8cEpJ8JOn0ibi5dBluH6AZYWH81HwUVMCVrMgLwX1o1T7DtM
   ZNKqLcuzXzqnMNscf6OWP/UugqjSCpfGcZHDtYGj3vkBkcK7aIxWQ8SX6
   EXwND0Ks+BYfsyUL3sCwULL/x7/3/UxTOSmLsCIASlwcHvwBzKOunHM6c
   Q==;
X-CSE-ConnectionGUID: RG/G9f/xRNmwGYrlC7f6Sg==
X-CSE-MsgGUID: Ja4spV/ATwiJ7B2XvoIN1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32593829"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32593829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:10:26 -0700
X-CSE-ConnectionGUID: k0VhDcnvRoK3Cl8XAKKg0w==
X-CSE-MsgGUID: dV8sUVfnRK6J46aXc35MXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478007"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:10:14 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
	linux-efi@vger.kernel.org
Subject: [PATCH v5 04/16] init/main.c: Move EFI runtime service initialization to x86/cpu
Date: Mon, 28 Oct 2024 18:07:52 +0200
Message-ID: <20241028160917.1380714-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
the thing to the arch_cpu_finalize_init() path on x86 and get rid of
the #ifdef in start_kernel().

No functional change intended.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 7 +++++++
 init/main.c                  | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f41ab219cf1..b24ad418536e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/efi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2382,6 +2383,12 @@ void __init arch_cpu_finalize_init(void)
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
index c4778edae797..1d3a0a82d136 100644
--- a/init/main.c
+++ b/init/main.c
@@ -51,7 +51,6 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/cgroup.h>
-#include <linux/efi.h>
 #include <linux/tick.h>
 #include <linux/sched/isolation.h>
 #include <linux/interrupt.h>
@@ -1072,10 +1071,6 @@ void start_kernel(void)
 
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
2.45.2


