Return-Path: <linux-efi+bounces-5245-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01CC1D60D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EABE4E52F5
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685E34888F;
	Wed, 29 Oct 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egEC0Mwm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843D31C58E;
	Wed, 29 Oct 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771978; cv=none; b=lNUTxeZ2HnkbyHpFAyUcLLD2FJtpjHog2uUVaS8qOYr2xYx46i71myiijMqsg04a94M/gaYo7rsErO1reupBpsvVo46OjexYXmAEgxSTDnMthbaMdcbuipdTliHyrWyRvNV5+wyXEIoUD/0fzhV/W5Y2M/AGjOuiY+B2uuSVltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771978; c=relaxed/simple;
	bh=wwQQCNi8H/JsqJV/nx2+iP3dZDBjDCblP8QvGNVggWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+o+0tzyz+mk7BdTMe8/U2niigX49VbVtqZUudBoeyrTLoQdR/pONcRHGQ23j3ECOPNKiEsZyV7donvk1ve817hDyoqtsKg59gikRENBR3iLCLvUNXPId9p52U0UMPCl9lfx+wYAYCnsxAZEholgkqyFLyByYIo4gUX2B3a4J0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egEC0Mwm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771977; x=1793307977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwQQCNi8H/JsqJV/nx2+iP3dZDBjDCblP8QvGNVggWA=;
  b=egEC0MwmuYayyIoP/S/SDFboEA9s4SUOSrE9wnu9eSI7qkxEJDhKzO2m
   Ap3wJqparBE1AYl4AY9lr+KDvWHZHMFbJK9OgnHJQfyyvejTNHeS/HZsA
   VktJR/2T6q3zQRRbP2xwSy/0Y3i207QNpwJ7CsltFlpHxAvHKaiAdyv45
   pz6iRRDGIkOPQLnMfPZGYFIujSDiLJTOW5+3MG58vLx2Jbxw6jp0P3r/X
   ZjX96uRgfhuLmHY7oD4ogK7h08uIcoXCa+HSpVNAieKCF/0cw7yYcKqAg
   ZbW8mqOXNM+dPAbequHdoWt6r/FTZ+BVoEG2stxfpkbLOQv0yGxZ4Mmx1
   g==;
X-CSE-ConnectionGUID: h9WsjTkdSOSn3crNLMHKGA==
X-CSE-MsgGUID: mCokZYUkT4y6caV/ZVwi4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002743"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:15 -0700
X-CSE-ConnectionGUID: uGrXlBUiT7uTxu0ezlPFeQ==
X-CSE-MsgGUID: bEV/d0/STi6UXTrhZdAqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216432005"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:14 -0700
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
Subject: [PATCH v11 7/9] x86/traps: Communicate a LASS violation in #GP message
Date: Wed, 29 Oct 2025 14:03:08 -0700
Message-ID: <20251029210310.1155449-8-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029210310.1155449-1-sohil.mehta@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
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
---
v11:
 - Improve commit log.

v10:
 - Minor improvement to code comments and hints.
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


