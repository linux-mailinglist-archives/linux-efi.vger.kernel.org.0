Return-Path: <linux-efi+bounces-5500-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B891CC5A633
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C509F4E7D22
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBE32826B;
	Thu, 13 Nov 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzT6ehgS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A33326D6E;
	Thu, 13 Nov 2025 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073922; cv=none; b=JUC6C670oUYSn9OIZHn0Z5iT2m1yLB1/eCTZDASNpaU8o5Hbw9DQIpz1I24Uq0RACUzEvH9kIeNsNL8CfBnAb9rDT2glpV9Z6JQTStffgLUU/PtFh9mdvV0UBWbZBpvQV3gaRejod0Sk5VeFWpGnn0WG64OnCZV0LC6nlBnu+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073922; c=relaxed/simple;
	bh=gvbT3BHteEQ6s+AC0t6voXLmJ8qwMJg0xNxsHAAJFeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzD5gJjFL1wPOCgHZ6tmSKdo27F0drDTNLgho+01v1gXGDX0UdN3p+pkbqtWU1mB+VqSFSfDD0GP0skC3Wrb5RSle4WMAd3AacX8Gq/xU6hbqfFL3snFUkZNzfEUx7ZpmKE6HH1FA8lq0tK276dcY2cL2Jd/toM59Z0WAt+sUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzT6ehgS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073920; x=1794609920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvbT3BHteEQ6s+AC0t6voXLmJ8qwMJg0xNxsHAAJFeg=;
  b=QzT6ehgSHgtcJJXnc5z991kVckhPophCvzSmbGBkEUbRRHZaPR2JXwot
   CvibLNy00iL7JUA2qHPpu4HSsW/fDB2wqg0f8makyszRICIryaHr6nvyQ
   AaOgGzgn5LWO3XCigP/pv7CAfxmEmPyX79rZoHR9DZR/pvVWm9g7pNFn8
   CMZCDb5VbrTSbxdKohp8Qz3ujhZlt3SLFyZI0bePz3c0aeyiaw6DtOASl
   +u7KXmVKOjaqNB3l3rP7Fs9mTwlAdfYuJb0eYEVmq7fCKL7k9ztIAg3id
   04kNXD//byrTyTAY5AE2R+zUVRl+BrAVWMmOmNX5SvzyiCxv8f/Lj6dG4
   w==;
X-CSE-ConnectionGUID: Go3znnJRRQq6CmPcLu5zGw==
X-CSE-MsgGUID: Q5L4xATFRGWp70PIiGLTfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051941"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051941"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:17 -0800
X-CSE-ConnectionGUID: pZQDxvYSSiKFC5rfihB15Q==
X-CSE-MsgGUID: fITss5VlQ8KQ5Du+cgXcEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611092"
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
Subject: [PATCH v12 4/8] x86/alternatives: Disable LASS when patching kernel code
Date: Thu, 13 Nov 2025 14:42:00 -0800
Message-ID: <20251113224204.50391-5-sohil.mehta@intel.com>
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

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. LASS blocks these accesses because its
enforcement relies on bit 63 of the virtual address as opposed to SMAP
which depends on the _PAGE_BIT_USER bit in the page table. Disable LASS
enforcement by toggling the RFLAGS.AC bit during patching to avoid
triggering a #GP fault.

Introduce LASS-specific STAC/CLAC helpers to set the AC bit only on
platforms that need it. Name the wrappers as lass_stac()/_clac() instead
of lass_disable()/_enable() because they only control the kernel data
access enforcement. The entire LASS mechanism (including instruction
fetch enforcement) is controlled by the CR4.LASS bit.

Describe the usage of the new helpers in comparison to the ones used for
SMAP. Also, add comments to explain when the existing stac()/clac()
should be used. While at it, move the duplicated "barrier" comment to
the same block.

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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Revert to lass_clac()/lass_stac() naming.
 - Pick up review tag.

v11:
 - Use lass_enable()/lass_disable() naming.
 - Improve commit log and code comments.
---
 arch/x86/include/asm/smap.h   | 41 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 18 +++++++++++++--
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..20a3baae9568 100644
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
+ * Use lass_stac()/lass_clac() to toggle the AC bit for kernel data
+ * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
+ *
+ * Even with the AC bit set, LASS will continue to block instruction
+ * fetches from the user half of the address space. To allow those,
+ * clear CR4.LASS to disable the LASS mechanism entirely.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
+static __always_inline void lass_clac(void)
+{
+	alternative("", "clac", X86_FEATURE_LASS);
+}
+
+static __always_inline void lass_stac(void)
+{
+	alternative("", "stac", X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..5b09f89070f0 100644
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
+	lass_stac();
+	__inline_memcpy(dst, src, len);
+	lass_clac();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	lass_stac();
+	__inline_memset(dst, c, len);
+	lass_clac();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.43.0


