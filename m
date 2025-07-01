Return-Path: <linux-efi+bounces-4066-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C60AEF43D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F46B3AF9E9
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592226FD97;
	Tue,  1 Jul 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZg4iR85"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F84221281;
	Tue,  1 Jul 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363964; cv=none; b=AhUcQn37vB+iADKWEJbKbg5icZdocQlx+nZ7nXq6cSGdQjua2vTyj9+d2D240//Ewp+T9c6ugNPFUVcF3S/4u/pH6tZizgL7tv3iLasFHfmINhgZFcd1f3KAyfYyemIdVMAkqtxdWrhAAelLf2Luv1CCfQ9UqKXFf5YflPrFtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363964; c=relaxed/simple;
	bh=BDM4GULv098OkgaG9+t85KmDsV77Wx362tvBjQprKsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHOBImQcp1mzdzMliGp9O22Z6tjN98OYNkdPPgWkRspspuVkw7og8pMptpOBpFSJUhsQiyyR7wiOjC8gPh66dJxPYeRupC1oiCUZe0MPrLuIgTgFKa5VFjsVR0ILcFNxnYD8PV0gYZ0/Us+6t/6PfUNoFzcbJ+ZGxyeHA6CNZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZg4iR85; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363964; x=1782899964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BDM4GULv098OkgaG9+t85KmDsV77Wx362tvBjQprKsg=;
  b=WZg4iR850EfFVt82YCjwO7jp06CE5I/5OKYy+6Y2yPrlITRgN+v9Dlkm
   PeeOx4fdgeiqDkxHj+yFveOSq1dxH6aWK9LjgHE+KQTFvn4JuOeyNDu1D
   0ror5A72WSdLLg0hq6O3QPnXwiQr+VrHmoFxOObFSDLC6e2WX1yl/grSD
   l3pHfZxzdbloPITZjE6xf7YwNdPA1h+hwH0ZqZXG0QuQoz3+lzDQOqiHt
   BBsVNZ8kSQvowsVxVlshXbyfZL8tG6snge6hQrqs7wzcmb1ZXxNU9TQXT
   C2l+HqCaMEPsc63wYZho2SkZ6jKM/dJE7EVn44eU2LsiGN8nTWse/aBNY
   Q==;
X-CSE-ConnectionGUID: EOtLsbgcQ4q/DV2cab/MAw==
X-CSE-MsgGUID: HBqwSWHBSEelqS1mn/extg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048738"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048738"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:23 -0700
X-CSE-ConnectionGUID: SwaahxybTzSPHC8U1d1nQQ==
X-CSE-MsgGUID: vDnNRCLrTGWlKa5z5g43AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390839"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:59:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D19BA892; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 13/17] x86/traps: Generalize #GP address decode and hint code
Date: Tue,  1 Jul 2025 12:58:42 +0300
Message-ID: <20250701095849.2360685-14-kirill.shutemov@linux.intel.com>
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

Handlers for #GP and #SS will now share code to decode the exception
address and retrieve the exception hint string.

The helper, enum, and array should be renamed as they are no longer
specific to #GP.

No functional change intended.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 5206eb0ab01a..ceb091f17a5b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -633,28 +633,28 @@ DEFINE_IDTENTRY(exc_bounds)
 	cond_local_irq_disable(regs);
 }
 
-enum kernel_gp_hint {
-	GP_NO_HINT,
-	GP_NON_CANONICAL,
-	GP_CANONICAL,
-	GP_LASS_VIOLATION,
-	GP_NULL_POINTER,
+enum kernel_exc_hint {
+	EXC_NO_HINT,
+	EXC_NON_CANONICAL,
+	EXC_CANONICAL,
+	EXC_LASS_VIOLATION,
+	EXC_NULL_POINTER,
 };
 
-static const char * const kernel_gp_hint_help[] = {
-	[GP_NON_CANONICAL]	= "probably for non-canonical address",
-	[GP_CANONICAL]		= "maybe for address",
-	[GP_LASS_VIOLATION]	= "LASS prevented access to address",
-	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
+static const char * const kernel_exc_hint_help[] = {
+	[EXC_NON_CANONICAL]	= "probably for non-canonical address",
+	[EXC_CANONICAL]		= "maybe for address",
+	[EXC_LASS_VIOLATION]	= "LASS prevented access to address",
+	[EXC_NULL_POINTER]	= "kernel NULL pointer dereference",
 };
 
 /*
- * When an uncaught #GP occurs, try to determine the memory address accessed by
- * the instruction and return that address to the caller. Also, try to figure
- * out whether any part of the access to that address was non-canonical.
+ * When an uncaught #GP/#SS occurs, try to determine the memory address accessed
+ * by  the instruction and return that address to the caller. Also, try to
+ * figure out whether any part of the access to that address was non-canonical.
  */
-static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
-						 unsigned long *addr)
+static enum kernel_exc_hint get_kernel_exc_address(struct pt_regs *regs,
+						   unsigned long *addr)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	struct insn insn;
@@ -662,15 +662,15 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip,
 			MAX_INSN_SIZE))
-		return GP_NO_HINT;
+		return EXC_NO_HINT;
 
 	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
-		return GP_NO_HINT;
+		return EXC_NO_HINT;
 
 	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 	if (*addr == -1UL)
-		return GP_NO_HINT;
+		return EXC_NO_HINT;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -680,16 +680,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	 */
 	if (*addr < ~__VIRTUAL_MASK &&
 	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
-		return GP_NON_CANONICAL;
+		return EXC_NON_CANONICAL;
 	else if (*addr < ~__VIRTUAL_MASK &&
 		 cpu_feature_enabled(X86_FEATURE_LASS)) {
 		if (*addr < PAGE_SIZE)
-			return GP_NULL_POINTER;
-		return GP_LASS_VIOLATION;
+			return EXC_NULL_POINTER;
+		return EXC_LASS_VIOLATION;
 	}
 #endif
 
-	return GP_CANONICAL;
+	return EXC_CANONICAL;
 }
 
 #define GPFSTR "general protection fault"
@@ -808,8 +808,8 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
-	enum kernel_gp_hint hint = GP_NO_HINT;
-	unsigned long gp_addr;
+	enum kernel_exc_hint hint = EXC_NO_HINT;
+	unsigned long exc_addr;
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
 		return;
@@ -846,21 +846,21 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
 	else
-		hint = get_kernel_gp_address(regs, &gp_addr);
+		hint = get_kernel_exc_address(regs, &exc_addr);
 
-	if (hint != GP_NO_HINT) {
+	if (hint != EXC_NO_HINT) {
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 kernel_gp_hint_help[hint], gp_addr);
+			 kernel_exc_hint_help[hint], exc_addr);
 	}
 
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it
 	 * otherwise.
 	 */
-	if (hint != GP_NON_CANONICAL)
-		gp_addr = 0;
+	if (hint != EXC_NON_CANONICAL)
+		exc_addr = 0;
 
-	die_addr(desc, regs, error_code, gp_addr);
+	die_addr(desc, regs, error_code, exc_addr);
 
 exit:
 	cond_local_irq_disable(regs);
-- 
2.47.2


