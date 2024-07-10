Return-Path: <linux-efi+bounces-1399-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30892D5E8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F252885A6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC9198E6D;
	Wed, 10 Jul 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2rzLwGH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972C198A30;
	Wed, 10 Jul 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627836; cv=none; b=lhbKuwEolkJSuE1x5XebpK/9cHHqQNbZfvmk827+hvP8Qp0jFRMMsM2T77pgn5CpA2ALgeOhmT+nDIvS0kC35xvlQakhU29Dix8kdlrxAS7VtSNIrrNVVAFxnmFMMphvExDWf+AQ8wSoDDIwYbiVVNVdeeBdLs1nGPxuCjbdYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627836; c=relaxed/simple;
	bh=gph/ljZ0prpurgzSmZ7d5c6Ku+SAKC4eKNi4YbQVLg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQYuXk3H9Nwqan3ZiIPYbwZNtZDMofx5pxdPlIcsbTIMjJkmBlo3s3EWgua58MG+FRBq6VAz0D47Tiwa4Yumr9zj318Z/TDXMziTPAu6R8O23/wM/7NqCLvq2S1XiSzJTtUx+fM99smJvxq88XfWAH8erI93kf1GTPvLpf26GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2rzLwGH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627835; x=1752163835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gph/ljZ0prpurgzSmZ7d5c6Ku+SAKC4eKNi4YbQVLg8=;
  b=h2rzLwGHQBpWMr5dZ1G2oQiNGqEpY+3Bg4p9DaJTZ/9drvdNNbJnl1Y3
   WkNQw/Qi1/6NuZWdQQQ7Zq/pt2aJvuUr/IxtTjZDvtbJizfEvyEubN5zM
   8bIqX1ue9y7jlH0XUZBOPZRg7y+h8fEFkal0ouZKOwv3kfUluc+JbAqmj
   5eWr0iEPBsnSJ4lKklL48NU8cHBQTge9sVQkgQkvWwvU9cxibd/zexCpy
   694H2+UI5vL7irXQbCCWrzXL45uRjXyhSTQF1d3gNMCa0w58HbrCOMlcL
   aH9TNQ3lRFCxCg+QRXb2rhxwrP/YOnnPo/Y9QCGQB8sa5DPCJwAIBuC3H
   w==;
X-CSE-ConnectionGUID: 4d6i8inFTgyabNMgkKctNg==
X-CSE-MsgGUID: /OA4Mcw1SNOKLiAd+xB2aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103291"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103291"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:10:33 -0700
X-CSE-ConnectionGUID: MD3L6TcwRuKXb100C4OIhg==
X-CSE-MsgGUID: O/j+Vu7GRAeJtwJyPtZD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53085359"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:10:20 -0700
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
	Yian Chen <yian.chen@intel.com>,
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
Subject: [PATCH v4 10/16] x86/vsyscall: Add vsyscall emulation for #GP
Date: Wed, 10 Jul 2024 19:06:46 +0300
Message-ID: <20240710160655.3402786-11-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

The legacy vsyscall page is mapped at a fixed address in the kernel
address range 0xffffffffff600000-0xffffffffff601000. Prior to LASS being
introduced, a legacy vsyscall page access from userspace would always
generate a page fault. The kernel emulates the execute (XONLY) accesses
in the page fault handler and returns back to userspace with the
appropriate register values.

Since LASS intercepts these accesses before the paging structures are
traversed it generates a general protection fault instead of a page
fault. The #GP fault doesn't provide much information in terms of the
error code. So, use the faulting RIP which is preserved in the user
registers to emulate the vsyscall access without going through complex
instruction decoding.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 11 ++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++++
 arch/x86/kernel/traps.c               |  4 ++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e89d7d83a594..97608883b4b4 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -23,7 +23,7 @@
  * soon be no new userspace code that will ever use a vsyscall.
  *
  * The code in this file emulates vsyscalls when notified of a page
- * fault to a vsyscall address.
+ * fault or a general protection fault to a vsyscall address.
  */
 
 #include <linux/kernel.h>
@@ -276,6 +276,15 @@ bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
 	return __emulate_vsyscall(regs, address);
 }
 
+bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	/* Emulate only if the RIP points to the vsyscall address */
+	if (!is_vsyscall_vaddr(regs->ip))
+		return false;
+
+	return __emulate_vsyscall(regs, regs->ip);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 214977f4fa11..4eb8d3673223 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -16,6 +16,7 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  */
 extern bool emulate_vsyscall_pf(unsigned long error_code,
 				struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall_gp(struct pt_regs *regs);
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall_pf(unsigned long error_code,
@@ -23,6 +24,11 @@ static inline bool emulate_vsyscall_pf(unsigned long error_code,
 {
 	return false;
 }
+
+static inline bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	return false;
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ae34e03739cb..c70d75769b1a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -67,6 +67,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -669,6 +670,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
 			goto exit;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) && emulate_vsyscall_gp(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.43.0


