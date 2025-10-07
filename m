Return-Path: <linux-efi+bounces-4974-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98949BC06C2
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC931890E0C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92492258EC1;
	Tue,  7 Oct 2025 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5e4UpV7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58525254849;
	Tue,  7 Oct 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820048; cv=none; b=njAwHsByuIUBWDy187v787aj2TnJ4UTtXfym0018AMAPFYMPQOvfYDG3CWHBiU0A36NLlp8Z5YWUbr8PgwLGwEYkSRRfTl8X1VFWYXTORUnqaVxCBdTIVkZFeuefpluggzGnC3ptMLD9DWI9LAeLPxmsg5BJ4PpTc7WMICQAv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820048; c=relaxed/simple;
	bh=lVd0dGclYG6A0JMoKxaE+Hy/0Xq4JKmJR9usTLj67Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iECc9AGL1Wunt1Z5RjIdy511ddmpoTX8X80ynG0r+s5KgK3RopZdZJorBPoFglDDPPMLCJzru/OjdqMy2jyEoGl3gYaY5wqjfM5PwryzNrfT8nHgPAc6goEIHWOe+TwJf7nmJI/mYlSaF04w2GQ3sHu5e4C3CBQ1dewvv6CdqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5e4UpV7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820046; x=1791356046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVd0dGclYG6A0JMoKxaE+Hy/0Xq4JKmJR9usTLj67Vs=;
  b=k5e4UpV7CsiWV+T02m3ha1vkEseu8MZY0ny4uglDJLYXXY9D/M+fypBV
   CD/7/Tg5RvkFYuNg8zPj74Ff3kMRC2nfyjhNIOcvMIv1vC5yhcbc+2EOO
   A3nZ+SmCCiIlGQxCECf8cDTe18atvlNhahBB7sqrsv26iTBQPoH8/UZEl
   hlAa9WMc0lv4YrcW/9ILb5q/zVJ0koNWp/G486Qi26/JAggV/z8+JY9Cl
   PRbxmZpkvAn8gZVXWBACdV7XtR/V3L32oBzywWKo6D3fGi3YTcrjl+rRY
   Rqi8MRkZNMKAsQ7eBB1DsfPH1LA1RVKB50XgHQd5D5ClMyk+x/A6CXZFH
   g==;
X-CSE-ConnectionGUID: B6ScM5yfRwqRGwHY/dA+YA==
X-CSE-MsgGUID: CnAYBM/jRymj7X/e4fCvHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254564"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:05 -0700
X-CSE-ConnectionGUID: +JZNyZGFSHqDN4Hc4BrdOw==
X-CSE-MsgGUID: nbpydRRJQwOukf8imMUlcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354513"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:05 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v10 13/15] x86/traps: Generalize #GP address decode and hint code
Date: Mon,  6 Oct 2025 23:51:17 -0700
Message-ID: <20251007065119.148605-14-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007065119.148605-1-sohil.mehta@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

In most cases, an access causing a LASS violation results in a #GP, for
stack accesses (those due to stack-oriented instructions, as well as
accesses that implicitly or explicitly use the SS segment register), a
stack segment fault (#SS) is generated.

Handlers for #GP and #SS will soon share code to decode the exception
address and retrieve the exception hint string. Rename the helper
function as well as the enum and array names to reflect that they are no
longer specific to #GP.

No functional change intended.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - No change.
---
 arch/x86/kernel/dumpstack.c |  6 ++--
 arch/x86/kernel/traps.c     | 60 ++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

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
index a5d10f7ae038..3ee8a36a4e6a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -633,29 +633,29 @@ DEFINE_IDTENTRY(exc_bounds)
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
-	[GP_LASS_VIOLATION]	= "probably LASS violation for address",
-	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
+static const char * const kernel_exc_hint_help[] = {
+	[EXC_NON_CANONICAL]	= "probably for non-canonical address",
+	[EXC_CANONICAL]		= "maybe for address",
+	[EXC_LASS_VIOLATION]	= "probably LASS violation for address",
+	[EXC_NULL_POINTER]	= "kernel NULL pointer dereference",
 };
 
 /*
- * When an uncaught #GP occurs, try to determine the memory address accessed by
- * the instruction and return that address to the caller. Also, try to figure
- * out whether any part of the access to that address was non-canonical or
- * across privilege levels.
+ * When an uncaught #GP/#SS occurs, try to determine the memory address
+ * accessed by the instruction and return that address to the caller.
+ * Also, try to figure out whether any part of the access to that
+ * address was non-canonical or across privilege levels.
  */
-static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
-						 unsigned long *addr)
+static enum kernel_exc_hint get_kernel_exc_address(struct pt_regs *regs,
+						   unsigned long *addr)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	struct insn insn;
@@ -663,41 +663,41 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
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
 	 * If LASS is active, a NULL pointer dereference generates a #GP
 	 * instead of a #PF.
 	 */
 	if (*addr < PAGE_SIZE)
-		return GP_NULL_POINTER;
+		return EXC_NULL_POINTER;
 
 	/*
 	 * Assume that LASS caused the exception, because the address is
 	 * canonical and in the user half.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_LASS))
-		return GP_LASS_VIOLATION;
+		return EXC_LASS_VIOLATION;
 #endif
 
-	return GP_CANONICAL;
+	return EXC_CANONICAL;
 }
 
 #define GPFSTR "general protection fault"
@@ -816,7 +816,7 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
-	enum kernel_gp_hint hint = GP_NO_HINT;
+	enum kernel_exc_hint hint = EXC_NO_HINT;
 	unsigned long gp_addr;
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
@@ -854,17 +854,17 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
 	else
-		hint = get_kernel_gp_address(regs, &gp_addr);
+		hint = get_kernel_exc_address(regs, &gp_addr);
 
-	if (hint != GP_NO_HINT)
+	if (hint != EXC_NO_HINT)
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 kernel_gp_hint_help[hint], gp_addr);
+			 kernel_exc_hint_help[hint], gp_addr);
 
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it
 	 * otherwise.
 	 */
-	if (hint != GP_NON_CANONICAL)
+	if (hint != EXC_NON_CANONICAL)
 		gp_addr = 0;
 
 	die_addr(desc, regs, error_code, gp_addr);
-- 
2.43.0


