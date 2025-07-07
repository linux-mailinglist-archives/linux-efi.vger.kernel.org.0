Return-Path: <linux-efi+bounces-4156-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C74AFAE10
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90417AF3EE
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C96290080;
	Mon,  7 Jul 2025 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3QzUPH6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102022797AB;
	Mon,  7 Jul 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875421; cv=none; b=izJnW2QGnEzK6oi7R8oRxAozIbGrCkG7lt88XWIPaFaR8io4Y4WJ+haaXyNbe7hcwUBawbmHm+ZX4hZOhEAD5MfTPZHnDVIGta3TlimEBTpyfk0VRIDs+gEIe5gHvYgEkgNkokmB/uujExWPcc9K5DMaJkVvIhs4iZJ8Y5zpB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875421; c=relaxed/simple;
	bh=JeSkJUV3cdv7bNcvYQkT6zLEZGmKlSxMDoJgLXtp5FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN5p2csRgYejpPVT5lluQLUtRnAQ2ct/6jM/hFZBudKA7nzdukS6LQeZmCEeEKpPGejlsNpVbaPqdI4dxRUMJ5LYBP2a8s0lZU02yoY6z80guz5/HHaVupkkX6IexTPz/vi85EOYhI48i8HSpeVcBwIE/opKVlEjid0AOWIAITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3QzUPH6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875420; x=1783411420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeSkJUV3cdv7bNcvYQkT6zLEZGmKlSxMDoJgLXtp5FU=;
  b=O3QzUPH699LY85K/Y4Ll5b6hYDR1ny9pz2VibqwSJpacXkkb/lDxgjwn
   DvfgXioRwMPQc1vdovmjGeASmNMp9UhFLSuv5Fb4R8VAIlfXtIO3pYtt8
   4rIwVtuzKMhsoVSzGJkYCj6BVjPE11bZ+8QKSWqfPK1ozF1JGJHmrrELG
   FLVqN6e93BRAvMuuz/yHEhZlbwMkPAq3qYuc61vErIfm27KewXgs8n5SK
   VZAgTCxVIkB9tM53wjTsahRjzZd+ppTO19kHiuptLMr80cLa3iBL+6Ign
   DyPk35BSx6GzbsQcgZIxG1rLqZRsVLICTar2kZzi75VLbXn7loNhRm3uV
   Q==;
X-CSE-ConnectionGUID: cjL3D1CrSEadWlxHH/mnzg==
X-CSE-MsgGUID: InMQzxUFSGO4qOKZqAISfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="57891128"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="57891128"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:39 -0700
X-CSE-ConnectionGUID: WKwvMiHoQbqZAzVx9c7oRQ==
X-CSE-MsgGUID: 1odox0lWS0iLMEK0BglNLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="186171982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 07 Jul 2025 01:03:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 394C6983; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 12/16] x86/traps: Generalize #GP address decode and hint code
Date: Mon,  7 Jul 2025 11:03:12 +0300
Message-ID: <20250707080317.3791624-13-kirill.shutemov@linux.intel.com>
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

In most cases, an access causing a LASS violation results in a general
protection exception (#GP); for stack accesses (those due to
stack-oriented instructions, as well as accesses that implicitly or
explicitly use the SS segment register), a stack fault (#SS) is
generated.

Handlers for #GP and #SS will now share code to decode the exception
address and retrieve the exception hint string.

The helper, enum, and array should be renamed as they are no longer
specific to #GP.

No functional change intended.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/dumpstack.c |  6 ++--
 arch/x86/kernel/traps.c     | 58 ++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..e0f85214e92f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -441,14 +441,14 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
-void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr)
+void die_addr(const char *str, struct pt_regs *regs, long err, long addr)
 {
 	unsigned long flags = oops_begin();
 	int sig = SIGSEGV;
 
 	__die_header(str, regs, err);
-	if (gp_addr)
-		kasan_non_canonical_hook(gp_addr);
+	if (addr)
+		kasan_non_canonical_hook(addr);
 	if (__die_body(str, regs, err))
 		sig = 0;
 	oops_end(flags, regs, sig);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a4194e1d119..f75d6a8dcf20 100644
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
@@ -662,37 +662,37 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
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
 	/* Operand is in the kernel half */
 	if (*addr >= ~__VIRTUAL_MASK)
-		return GP_CANONICAL;
+		return EXC_CANONICAL;
 
 	/* The last byte of the operand is not in the user canonical half */
 	if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
-		return GP_NON_CANONICAL;
+		return EXC_NON_CANONICAL;
 
 	/*
 	 * If LASS is enabled, NULL pointer dereference generates
 	 * #GP instead of #PF.
 	 */
 	if (*addr < PAGE_SIZE)
-		return GP_NULL_POINTER;
+		return EXC_NULL_POINTER;
 
 	if (cpu_feature_enabled(X86_FEATURE_LASS))
-		return GP_LASS_VIOLATION;
+		return EXC_LASS_VIOLATION;
 #endif
 
-	return GP_CANONICAL;
+	return EXC_CANONICAL;
 }
 
 #define GPFSTR "general protection fault"
@@ -811,7 +811,7 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
-	enum kernel_gp_hint hint = GP_NO_HINT;
+	enum kernel_exc_hint hint = EXC_NO_HINT;
 	unsigned long gp_addr;
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
@@ -849,18 +849,18 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
 	else
-		hint = get_kernel_gp_address(regs, &gp_addr);
+		hint = get_kernel_exc_address(regs, &gp_addr);
 
-	if (hint != GP_NO_HINT) {
+	if (hint != EXC_NO_HINT) {
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 kernel_gp_hint_help[hint], gp_addr);
+			 kernel_exc_hint_help[hint], gp_addr);
 	}
 
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it
 	 * otherwise.
 	 */
-	if (hint != GP_NON_CANONICAL)
+	if (hint != EXC_NON_CANONICAL)
 		gp_addr = 0;
 
 	die_addr(desc, regs, error_code, gp_addr);
-- 
2.47.2


