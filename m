Return-Path: <linux-efi+bounces-4973-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D42DDBC06FE
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 184594F3B5A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B125743E;
	Tue,  7 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2HIlisy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607C248891;
	Tue,  7 Oct 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820047; cv=none; b=lTpf7dkVCVVVcdKG1OMwZXlDtqjfTu/TYzm37blJ0t5cEWxGibp6QNkTOf/U4KPz48MutmWDH3ZFkpRgOtwW17Hnl2IhpWcf5mQPlebRcqIVCC62wjzCG25ssr9Te8Mxxf3ng8DQFSdl3EObWaX1DNRmZ5Kba6+9U+ZgZg2lPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820047; c=relaxed/simple;
	bh=v/AnKYeaBYwv41cfbhsnq6Xu2el1+0Obs9DJw12Tbk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU4KRG8yNp+fJX0NKg3ML4mK0Atd6WCaL/2/eZs/XsyNghX9YgQ3zpHItSLqFXmGOXA3ICoLokiPdsEYLFjOj375S+alENbNjpzem/ueh7cLoiaHnhewcQEMB0qQX48zYvHhRAKqjiG5t3O+VHKFR4bnLcG5gd3jIv8qmiPzniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2HIlisy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820045; x=1791356045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/AnKYeaBYwv41cfbhsnq6Xu2el1+0Obs9DJw12Tbk8=;
  b=C2HIlisyJCZrzXDq2V7yKg+KhF4T5qctl7cvDW3vSRfXw5xOtOyZK48f
   ipqMF+o3sQeV5rkmiceB4H3T1+Ljtx5caPIpDsl/nfSPxKTyUutOtFvLu
   jUVViTL+ugEAIqGMOYDVA1iu7X1qn139cGZv32kYofXjne/Kjv1rTE/dR
   xSSDiNjcOIfxklTdkcvKq4b/Bm694TPk9pEFQjReteDvzgBDEoAFhsWO6
   tV+jY1GzICxtpTI/g3Vixf7XHDpEJ0TqMbv1VE9HsYJZgRXhB2kMDGZtW
   w3r5byFtChezA7ydvsnchZ6rZvvE2V21a5v9bHsbjGzVrecLwsEPIwXMK
   Q==;
X-CSE-ConnectionGUID: tx64B/g8RXCf3vOSGOr8NQ==
X-CSE-MsgGUID: eXYu5cC8SH2o6L4uLe+MZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254550"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:04 -0700
X-CSE-ConnectionGUID: 3KaV5gyFQ0qS21LHPv6qNg==
X-CSE-MsgGUID: YTkL3ObtQ2qdJffQ0doyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354508"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:04 -0700
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
Subject: [PATCH v10 12/15] x86/traps: Communicate a LASS violation in #GP message
Date: Mon,  6 Oct 2025 23:51:16 -0700
Message-ID: <20251007065119.148605-13-sohil.mehta@intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

A LASS violation typically results in a #GP. Provide a more helpful
message for a #GP when a kernel-side LASS violation is detected.

Currently, a kernel NULL pointer dereference triggers a #PF, which
prints a helpful message. Because LASS enforcement is pre-paging,
accesses to the first page frame would now be reported as a #GP, with an
LASS violation hint. Add a special case to print a friendly message
specifically for kernel NULL pointer dereferences.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Minor improvement to code comments and hints.
---
 arch/x86/kernel/traps.c | 45 ++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 59bfbdf0a1a0..a5d10f7ae038 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -636,13 +636,23 @@ DEFINE_IDTENTRY(exc_bounds)
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
@@ -664,14 +674,27 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
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
@@ -835,9 +858,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
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


