Return-Path: <linux-efi+bounces-5502-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B7C5A607
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DD33B2DE9
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999BD32863E;
	Thu, 13 Nov 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhhnJUm8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65843271E2;
	Thu, 13 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073923; cv=none; b=qlEXxDv4M0UDjlRirgk1cDHITD87qx3C3/TzWx3a/4Ih8/FC73bCk7B/L5Fxp3bgVEvDIWt/k+5UhkTkO0+O9XownGToPzf/bzfazrjbYUz5t9F8ZGumcdlTOzfoK+AYXbGowMB0cFx1zbvfTclNSqp9b2PnOdvob1HeADuQPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073923; c=relaxed/simple;
	bh=FMmtFZ5dyAmInWmEgEfrEufXRj0thkkit9CXc/uLAnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXEgeQ46uXx1vyRZ5TJnRE3e2PElaF+6eScrX4qRjpBLMiT8laL0xk17a8uKkGfOGwol1kA0xWh9oYPXU+V9UKefIdZ2BhkLPqLMW3DJBap7jS8I1Joj41HStGN8k8zpn28ibhwwGbYghkw8y9ObJctyzSe5WMJJx6o7Rmrq8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhhnJUm8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073922; x=1794609922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMmtFZ5dyAmInWmEgEfrEufXRj0thkkit9CXc/uLAnA=;
  b=bhhnJUm8kD4vUQMfmZS4YAjiKv3OuFqHJzdCsg+4mKBjuZyYZSJk8IEv
   66hTW4/bjx0UrCJRlcKHTBN+dkwEcqYkHRXKt9WsphCYI8CjT7zlsamIv
   X/qjrB/SJb/kWN4ciBjnlsH19KtyLgW/iY8swLYW4DBHiKNsyyTzwuA6d
   SqSGXaSotE8ygIceE4c4fJrx47qM9bEEWAtKaTNDkOBpHBpP50Vm+FvRV
   Y5B7l6+G1d4E8eIDqvSdZgqVGZu9EA1bhk26uFPhE5Oni91dinI1AcCRc
   dd9hzIM6XKZY93wraNt88eiIRuM010/X+S5UKTlMyz2Jb28oMUl96zafc
   w==;
X-CSE-ConnectionGUID: rAQ4huBMSHSSxPMZVOtnTw==
X-CSE-MsgGUID: wHdQHLsNRy+YGNptdbBm6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051966"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051966"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:18 -0800
X-CSE-ConnectionGUID: EfkjGwVWRomRvrVTPZc1Uw==
X-CSE-MsgGUID: faF83c4sTb6SsH5bYPq0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611102"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:17 -0800
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
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v12 6/8] x86/traps: Communicate a LASS violation in #GP message
Date: Thu, 13 Nov 2025 14:42:02 -0800
Message-ID: <20251113224204.50391-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113224204.50391-1-sohil.mehta@intel.com>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

A LASS violation typically results in a #GP. With LASS active, any
invalid access to user memory (including the first page frame) would be
reported as a #GP, instead of a #PF.

Unfortunately, the #GP error messages provide limited information about
the cause of the fault. This could be confusing for kernel developers
and users who are accustomed to the friendly #PF messages.

To make the transition easier, enhance the #GP Oops message to include a
hint about LASS violations. Also, add a special hint for kernel NULL
pointer dereferences to match with the existing #PF message.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - Improve commit log.
---
 arch/x86/kernel/traps.c | 45 ++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6b22611e69cc..30d5c690f9a1 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -635,13 +635,23 @@ DEFINE_IDTENTRY(exc_bounds)
 enum kernel_gp_hint {
 	GP_NO_HINT,
 	GP_NON_CANONICAL,
-	GP_CANONICAL
+	GP_CANONICAL,
+	GP_LASS_VIOLATION,
+	GP_NULL_POINTER,
+};
+
+static const char * const kernel_gp_hint_help[] = {
+	[GP_NON_CANONICAL]	= "probably for non-canonical address",
+	[GP_CANONICAL]		= "maybe for address",
+	[GP_LASS_VIOLATION]	= "probably LASS violation for address",
+	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
 };
 
 /*
  * When an uncaught #GP occurs, try to determine the memory address accessed by
  * the instruction and return that address to the caller. Also, try to figure
- * out whether any part of the access to that address was non-canonical.
+ * out whether any part of the access to that address was non-canonical or
+ * across privilege levels.
  */
 static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 						 unsigned long *addr)
@@ -663,14 +673,27 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 		return GP_NO_HINT;
 
 #ifdef CONFIG_X86_64
-	/*
-	 * Check that:
-	 *  - the operand is not in the kernel half
-	 *  - the last byte of the operand is not in the user canonical half
-	 */
-	if (*addr < ~__VIRTUAL_MASK &&
-	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
+	/* Operand is in the kernel half */
+	if (*addr >= ~__VIRTUAL_MASK)
+		return GP_CANONICAL;
+
+	/* The last byte of the operand is not in the user canonical half */
+	if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
 		return GP_NON_CANONICAL;
+
+	/*
+	 * If LASS is active, a NULL pointer dereference generates a #GP
+	 * instead of a #PF.
+	 */
+	if (*addr < PAGE_SIZE)
+		return GP_NULL_POINTER;
+
+	/*
+	 * Assume that LASS caused the exception, because the address is
+	 * canonical and in the user half.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		return GP_LASS_VIOLATION;
 #endif
 
 	return GP_CANONICAL;
@@ -833,9 +856,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	if (hint != GP_NO_HINT)
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
-						    : "maybe for address",
-			 gp_addr);
+			 kernel_gp_hint_help[hint], gp_addr);
 
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it
-- 
2.43.0


