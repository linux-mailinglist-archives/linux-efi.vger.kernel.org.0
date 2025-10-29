Return-Path: <linux-efi+bounces-5242-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE2C1D5C3
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E063834D34A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1931986E;
	Wed, 29 Oct 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND2RNMmL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F06318135;
	Wed, 29 Oct 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771976; cv=none; b=D8KGcY3zB2QfUVwyRhAExZbpkEWlZT18aatfjusuV8LJ1cJ5B0DmaFPD9TWBJ1Y2kH8CGFq9Sa3rExJWMHC2mdLcZx+WOcBuRnE8EGv6DhJSntFCZWKvJZrkus3+s6LLUhuC/c/cX85Fx1IMMFuMWHXw1YP0tBGbufmo046RJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771976; c=relaxed/simple;
	bh=hVnO1b5BjhuoDuyzGkyBRnDpiZj/eQG7KV9yBG1SLmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDt2rBg6C5QMYeOclMYK5UF4MKDr/ORXk/I9VlGgKl33oUw/aM288mZVy/vdNQ1n6Ldz6ME4BoRPI60UNrGfcoDhgKJzRkWZRcy1Gl60A4BKj39BHAKLFk93BUgFyOTXezquiAOI33gXp0+Zmj60fTMNUsqFSQ3UudushySycl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND2RNMmL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771974; x=1793307974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVnO1b5BjhuoDuyzGkyBRnDpiZj/eQG7KV9yBG1SLmI=;
  b=ND2RNMmLeVzv4+gxy6nd81Zsus/H2K5vHKxCCnth+EqVb1UoEFafE7+I
   O5YkUijX2zuvFGxv+U1LgGjVY7IaWJl5FEYK6S1ED3Zs13sQHNrnpl4Ak
   p+ZrXKS1lRYaewGV9GgDKHyWp2aM4Tl2nxweS9/UdsycbhCLVAlL1q6gr
   90IPeygWD3hRdrHlMb9yilSwvXyqZ5Tc03SKU4GvKIfkp0rsfGpQ1AS6t
   QXLCadSqGA2W7uTVm2ipUxJVSaB2hxCINKIko2vl/V469igvtawx0F2sn
   CUIHm7Q/bIPTdVHsRrSvPmW9yOqMCjaaMpJiVJGRFE71tw72IQXa+g0G2
   w==;
X-CSE-ConnectionGUID: DXsPXNvlR1S304Q8CEh+aQ==
X-CSE-MsgGUID: OrkTrluDQ5e0uB9ywG2DWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002739"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002739"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:13 -0700
X-CSE-ConnectionGUID: Cv0k/yrMTzeen3nRR24P4w==
X-CSE-MsgGUID: A2CmuLODQBanbse6Ej/4qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431991"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:12 -0700
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
Subject: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching kernel code
Date: Wed, 29 Oct 2025 14:03:05 -0700
Message-ID: <20251029210310.1155449-5-sohil.mehta@intel.com>
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

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. LASS blocks these accesses because its
enforcement relies on bit 63 of the virtual address as opposed to SMAP
which depends on the _PAGE_BIT_USER bit in the page table. Disable LASS
enforcement by toggling the RFLAGS.AC bit during patching to avoid
triggering a #GP fault.

Introduce LASS-specific STAC/CLAC helpers to set the AC bit only on
platforms that need it. Clarify the usage of the new helpers versus the
existing stac()/clac() helpers for SMAP.

The Text poking functions use standard memcpy()/memset() while patching
kernel code. However, objtool complains about calling such dynamic
functions within an AC=1 region. See warning #9, regarding function
calls with UACCESS enabled, in tools/objtool/Documentation/objtool.txt.

To pacify objtool, one option is to add memcpy() and memset() to the
list of allowed-functions. However, that would provide a blanket
exemption for all usages of memcpy() and memset(). Instead, replace the
standard calls in the text poking functions with their unoptimized,
always-inlined versions. Considering that patching is usually small,
there is no performance impact expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - Use lass_enable()/lass_disable() naming.
 - Improve commit log and code comments.

v10:
 - Revert to the inline functions instead of open-coding in assembly.
 - Simplify code comments.
---
 arch/x86/include/asm/smap.h   | 41 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 18 +++++++++++++--
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..90f178c78f9c 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,55 @@
 
 #else /* __ASSEMBLER__ */
 
+/*
+ * The CLAC/STAC instructions toggle the enforcement of
+ * X86_FEATURE_SMAP along with X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page
+ * tables. The kernel is not allowed to touch pages with that bit set
+ * unless the AC bit is set.
+ *
+ * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
+ * regardless of location.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
 static __always_inline void clac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "clac", X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "stac", X86_FEATURE_SMAP);
 }
 
+/*
+ * LASS enforcement is based on bit 63 of the virtual address. The
+ * kernel is not allowed to touch memory in the lower half of the
+ * virtual address space.
+ *
+ * Use lass_disable()/lass_enable() to toggle the AC bit for kernel data
+ * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
+ *
+ * Even with the AC bit set, LASS will continue to block instruction
+ * fetches from the user half of the address space. To allow those,
+ * clear CR4.LASS to disable the LASS mechanism entirely.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
+static __always_inline void lass_enable(void)
+{
+	alternative("", "clac", X86_FEATURE_LASS);
+}
+
+static __always_inline void lass_disable(void)
+{
+	alternative("", "stac", X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..b38dbf08d5cd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2469,16 +2469,30 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
+ *
+ * objtool enforces a strict policy of "no function calls within AC=1
+ * regions". Adhere to the policy by using inline versions of
+ * memcpy()/memset() that will never result in a function call.
+ */
+
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	lass_disable();
+	__inline_memcpy(dst, src, len);
+	lass_enable();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	lass_disable();
+	__inline_memset(dst, c, len);
+	lass_enable();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.43.0


