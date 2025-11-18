Return-Path: <linux-efi+bounces-5604-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54715C6B3E7
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34BBE4E520C
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95512E0922;
	Tue, 18 Nov 2025 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpfC8mDi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14592E06ED;
	Tue, 18 Nov 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490899; cv=none; b=TyCtZNz/zKvyY0ZyBXD2hplO6bmcIv8OSXKzDC8X8ML9teA0jPPyf2ctNiwC8/QbfCJNdVwo/Qi5eo9MYwAX3d1OoB4QXx5ZZKE2xc5nCRqpW0rX9Haz8EDzQAtx5EMNCLBdHiUaXBHgpqxI1OtzOqV0aPqlQsQrw+BLqYRuNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490899; c=relaxed/simple;
	bh=zghdUcfGJrBJt+l+cxe42GPOYm5btcUr2ZEKw1Z2Ojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV0dMXPKgVkbVf3p08KWLDYeL6zwdVhsSFtOCQjwPH+xThMOT7maGVM3mURHriTwNAHDv9SQ3vMAKoRi2AQwGjK5t4fAIzARK64/0L6EWhq8LbKk/aBjrAUel+OG98qJR/Ib5yJHtBy5QNvWUD2rj4z/Z0jOv2LDsd0xHWZojZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpfC8mDi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490898; x=1795026898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zghdUcfGJrBJt+l+cxe42GPOYm5btcUr2ZEKw1Z2Ojw=;
  b=CpfC8mDiFGW5wgDcoXXj6Z+Xsa3D9UioMtzVkU1PNK5eI2ZWFP6mKrTR
   vJfLqkMi1ArwtFAekgPB2T8iZ30mw1DwUbRWg086MOUp0mHTTrTSmU7HK
   EmXyz8NiXnWWH6Bc+PSOBEs5BQXxZKqlQHqwRN72IjGdKP/VNgejlQ2Cn
   y280EXWcIHXWHJqSw9I4a+RRUkfpoWORu2b+YGy+fKPH43QdeO2uCZY9L
   SxwPjWm04wDxvzr4gcJYmeF5xfjq6Y6OTPholqcmzS7rYMYVYqOik2oSC
   LM3UEcXwYcNVsrWs0589joBZy1na/Fxow2iS63BRQop/UNiueWScp1a8u
   g==;
X-CSE-ConnectionGUID: tEwMwGs4Sq+VUpt8RdY3/g==
X-CSE-MsgGUID: 16d/7rezTXOHcBQI/SWsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979924"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:56 -0800
X-CSE-ConnectionGUID: XcL1OKMKS5W21CL6MjjVzg==
X-CSE-MsgGUID: YnhCGqWPRbm7NO/nV66u1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088952"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:56 -0800
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
Subject: [PATCH v13 6/8] x86/traps: Communicate a LASS violation in #GP message
Date: Tue, 18 Nov 2025 10:29:08 -0800
Message-ID: <20251118182911.2983253-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118182911.2983253-1-sohil.mehta@intel.com>
References: <20251118182911.2983253-1-sohil.mehta@intel.com>
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
v13:
 - Update comment to clarify NULL pointer case.

v12:
 - Pick up review tag.

v11:
 - Improve commit log.
---
 arch/x86/kernel/traps.c | 46 ++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6b22611e69cc..1b9177b93433 100644
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
@@ -663,14 +673,28 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
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
+	 * A NULL pointer dereference usually causes a #PF. However, it
+	 * can result in a #GP when LASS is active. Provide the same
+	 * hint in the rare case that the condition is hit without LASS.
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
@@ -833,9 +857,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
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


