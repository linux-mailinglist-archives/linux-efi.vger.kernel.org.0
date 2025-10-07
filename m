Return-Path: <linux-efi+bounces-4969-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016EBC069E
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB8EC34CDBD
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5D246BDE;
	Tue,  7 Oct 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz0mPSeu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84123D291;
	Tue,  7 Oct 2025 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820045; cv=none; b=c1F8dpkuNjOIen8REvD6Dye0CfhdqWhILW7N+YiFCaIjhajHmRmPMp29yGlPa6TjMMqXW3RVfrasv4RVXP3vmTl5AO35gvPnTxiPdJNX17pkVi9vVFRrqgibnvbuFedFgR2qqwR7LLH3KWIkUmeO/6RgFWVyKosfHYrmn8kBCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820045; c=relaxed/simple;
	bh=L1412De9Yvq24CgH8jzCj11Nqy+A7G5FnvSZgrqJw+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUIJnCJdLgynX/sOyRllLAHxurRWWBrSIG9mLuPcA3GE6qOROQ9pxFZHlpOrHHIhsCptRBVjpGUsrowsmeUWlCByRbarfZ4eXbr0+KJhuRKcm4Qw3KC/eli5j/mOZ5d3LXObMN8onTPTRhSxgtODc7JSCAlu2xOcuDRF+VALUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz0mPSeu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820043; x=1791356043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1412De9Yvq24CgH8jzCj11Nqy+A7G5FnvSZgrqJw+s=;
  b=cz0mPSeu1YfwdCdQzNrQ4P4GyrbWp/1l++zADpH3BiNmGBisxzKkq34x
   HxcpqsmeOeK7eItx9R+ibTcsNqifX+kr/2SSkhbfcYqzJhin4abls4ncH
   QEiMRVrUKhDOoyppiXntvjlA84eD+1vjqMwaa3AKPA4TSTP57PUJ70d6X
   OVAT9UghFnUzxP0bv11VzboIZhL2Zs5CKCQ/rkfXhvsyuBOG6ajBjPHLX
   4VDFUWy1Mtj1ufvBFmVqD/cc3x+tTq6EOm/+l5P6NS15WxgXzBRxYYTy/
   dUnncrcApsSZjuvoWr4mg/N07GrpEiYN+qtoGkj5OirsPMNCwRGJo/PGC
   w==;
X-CSE-ConnectionGUID: ojAaAOM5Qa+KTIxg7qM30w==
X-CSE-MsgGUID: WeAS9pTNTfiS184pVJXLUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254492"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254492"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:01 -0700
X-CSE-ConnectionGUID: ZwlmAu9rTFaY9fu19UBIhg==
X-CSE-MsgGUID: Y3nw+8ShSqenP1s8GIBW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354491"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:01 -0700
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
Subject: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault emulation code
Date: Mon,  6 Oct 2025 23:51:12 -0700
Message-ID: <20251007065119.148605-9-sohil.mehta@intel.com>
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

Separate out the actual vsyscall emulation from the #PF specific
handling in preparation for the upcoming #GP emulation.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v10:
 - Modify the code flow slightly to make it easier to follow.
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 63 ++++++++++++++-------------
 arch/x86/include/asm/vsyscall.h       |  7 ++-
 arch/x86/mm/fault.c                   |  2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 6e6c0a740837..4c3f49bf39e6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -112,43 +112,13 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	}
 }
 
-bool emulate_vsyscall(unsigned long error_code,
-		      struct pt_regs *regs, unsigned long address)
+static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 {
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
 	long ret;
 	unsigned long orig_dx;
 
-	/* Write faults or kernel-privilege faults never get fixed up. */
-	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
-		return false;
-
-	/*
-	 * Assume that faults at regs->ip are because of an
-	 * instruction fetch. Return early and avoid
-	 * emulation for faults during data accesses:
-	 */
-	if (address != regs->ip) {
-		/* Failed vsyscall read */
-		if (vsyscall_mode == EMULATE)
-			return false;
-
-		/*
-		 * User code tried and failed to read the vsyscall page.
-		 */
-		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
-		return false;
-	}
-
-	/*
-	 * X86_PF_INSTR is only set when NX is supported.  When
-	 * available, use it to double-check that the emulation code
-	 * is only being used for instruction fetches:
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_NX))
-		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
-
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
@@ -281,6 +251,37 @@ bool emulate_vsyscall(unsigned long error_code,
 	return true;
 }
 
+bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
+			 unsigned long address)
+{
+	/* Write faults or kernel-privilege faults never get fixed up. */
+	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
+		return false;
+
+	/*
+	 * Assume that faults at regs->ip are because of an instruction
+	 * fetch. Return early and avoid emulation for faults during
+	 * data accesses:
+	 */
+	if (address != regs->ip) {
+		 /* User code tried and failed to read the vsyscall page. */
+		if (vsyscall_mode != EMULATE)
+			warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
+
+		return false;
+	}
+
+	/*
+	 * X86_PF_INSTR is only set when NX is supported.  When
+	 * available, use it to double-check that the emulation code
+	 * is only being used for instruction fetches:
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_NX))
+		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
+
+	return __emulate_vsyscall(regs, address);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 472f0263dbc6..f34902364972 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -14,12 +14,11 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  * Called on instruction fetch fault in vsyscall page.
  * Returns true if handled.
  */
-extern bool emulate_vsyscall(unsigned long error_code,
-			     struct pt_regs *regs, unsigned long address);
+bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs, unsigned long address);
 #else
 static inline void map_vsyscall(void) {}
-static inline bool emulate_vsyscall(unsigned long error_code,
-				    struct pt_regs *regs, unsigned long address)
+static inline bool emulate_vsyscall_pf(unsigned long error_code,
+				       struct pt_regs *regs, unsigned long address)
 {
 	return false;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 998bd807fc7b..fbcc2da75fd6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1316,7 +1316,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(error_code, regs, address))
+		if (emulate_vsyscall_pf(error_code, regs, address))
 			return;
 	}
 #endif
-- 
2.43.0


