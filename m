Return-Path: <linux-efi+bounces-4061-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EEFAEF425
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349494A1CC4
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077D272E41;
	Tue,  1 Jul 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjeXVxIF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F327145B;
	Tue,  1 Jul 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363951; cv=none; b=WZTYVUXkvV9WtnyNqzjA9pDEDv6Dy050MR1dxLACwdSw4l5SUchIhiX8L6euVjf7X5TDVYjdiL1K8Tq1wYDGGH7S+yHjCmMVXBQjJUi3+4/ki+26fY0C7fwRbExdC0w0qpn8LHsxuhbAXa5Jfak7+YX04OdD+vpXhGxfUHHu/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363951; c=relaxed/simple;
	bh=Y6wMD+f3zIu+lL8OF4jucYTQX8f5E+hJrr2IotIkhTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrgO1cBLxCo3ENU3bvDrPJqQLyHH2d4JwCyq7GozvhrOS2mCzk2eESlQ6kmmTijF3lFaIKCZy+QV0Qnj03jM1PGiI1wm/JTp8A44LwbCHNe/TS9RxTJCW29WaC3xdg9qkjQUzlXzPAtUviTKCPmeWl4WMcgwW7xvmpD2/JjyeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjeXVxIF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363950; x=1782899950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6wMD+f3zIu+lL8OF4jucYTQX8f5E+hJrr2IotIkhTA=;
  b=kjeXVxIFkLTUtS9bLn+hbN+enwixkKQ9BlrDjic5pQWCvamV7TbLtdeQ
   hsE3O6LM7Ayl8SHLw0No1Zx/K26RfH0bHVOuzOdmaAJfhyOA3uNYI9hs7
   4ta2I4lboZZ9/4KZoo+wewHy4EwRDFJhDcpudRB0GdIXPckn9q5Uk9PAY
   DX/VbaEMxuSyjwtJuHkxPoXuII30NIMRSBZ/5sOakluLC5Q9PppZPqCIz
   OZI9YChpiMnh3qR4MZ8rqsc/RiHQCc7hT0tDM7jWqZHaIqrl3/VBRCttJ
   suH/ESIXl5u6ViSjuTuoBZh+AJbQ2rdN/Mkq/DyNRHlNLFxo7irY5zJ/M
   Q==;
X-CSE-ConnectionGUID: L/cu2zDcT9mLlZxKdatVJA==
X-CSE-MsgGUID: 86CEY7AiSOy4/CO02BvU0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048670"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048670"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:10 -0700
X-CSE-ConnectionGUID: 50qUsqSFTjCgdkVjSs68gQ==
X-CSE-MsgGUID: Vgf+hGwgSeeLMGPVR5qUIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390828"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:58:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9FBA1627; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 09/17] x86/vsyscall: Add vsyscall emulation for #GP
Date: Tue,  1 Jul 2025 12:58:38 +0300
Message-ID: <20250701095849.2360685-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 14 +++++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++++
 arch/x86/kernel/traps.c               |  4 ++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 25f94ac5fd35..be77385b311e 100644
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
@@ -278,6 +278,18 @@ bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
 	return false;
 }
 
+bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return false;
+
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
index 10856e0ac46c..40e34bb66d7c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -69,6 +69,7 @@
 #include <asm/tdx.h>
 #include <asm/cfi.h>
 #include <asm/msr.h>
+#include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -817,6 +818,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_umip_exception(regs))
 			goto exit;
 
+		if (emulate_vsyscall_gp(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.47.2


