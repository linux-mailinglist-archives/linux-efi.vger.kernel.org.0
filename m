Return-Path: <linux-efi+bounces-4964-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3ABC067A
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D238F34CCA2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164023A9B0;
	Tue,  7 Oct 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4rh5EWU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FE82866;
	Tue,  7 Oct 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820041; cv=none; b=UBsTyKg97Pw2V+48xk5/r7qZirZxgqC6zDEloZMXsbVa9G4sK0C0AYhI2kHfUE4Co0AQcmTmWo6yELp4qg+NDeMUN4QlNcn+0QFb4eFx+X2NCW6wnJpJgRLkG236fsrXgmvNfwP5Nc+DdVU4Vk/asE5CucvnlAZNSkod3GG4igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820041; c=relaxed/simple;
	bh=Xe1JDPucIxQIhHiVPqvH+i1PVjohP3EYCdrPV9RmZEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUaKgna1wob6ji6G+FtykQvj5BBW0JzS4bXxgu2Baej/B3BH5hOqwvUHHIZN3O38iN9zoe2NHsHiBr23XdQ46AYD7R0mVQ1sjvuNA0OzXbrSu4AqeN04ilP/0KYMTsuQfefFYA0sNNMH8HTCw6MmorLaFdtOIl2WqT2xfMTXZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4rh5EWU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820039; x=1791356039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xe1JDPucIxQIhHiVPqvH+i1PVjohP3EYCdrPV9RmZEE=;
  b=Y4rh5EWUtiCZaOxwCqI0piLWPIs7pf9FVTQKEa8lnsnhdACpdBKfwnSU
   MPG8nf1xissO3FUIsvi9g6ZC+2121LdPaJZ18EbdFxOK+ulMb5W0Ry48E
   IqG3gZerMgveOXaNz2QLordTK+/dmzJpn0efEOhN82WOGDiVy2WTafUZ5
   G/RLVKgCPx47Ka6ZduuVMR90ZSrAZY9KwRf8rmMLWKfpph+f685UabQXl
   HIuiz3CKo+ahX80r74EEO4tp+bZk8YmwBFkGYjS+2Pemn1m8eRLjkNu2c
   n4jf+CIJNIXCEWUjQzunZQ5qvxSjG3no2FSJ7kqJi37w0u0nxIkkZNt3Z
   Q==;
X-CSE-ConnectionGUID: UnoBXe4OTXC38TrOiqfFyA==
X-CSE-MsgGUID: 62OxOoG+Q86vqA3cCAZ8Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254418"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254418"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:53:58 -0700
X-CSE-ConnectionGUID: IKJ8wIuJRKehU57wuQbKug==
X-CSE-MsgGUID: n87D1ICVSdqkVTwkww7imA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354469"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:53:57 -0700
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
Subject: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching kernel alternatives
Date: Mon,  6 Oct 2025 23:51:07 -0700
Message-ID: <20251007065119.148605-4-sohil.mehta@intel.com>
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

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. Disable LASS enforcement by toggling the
RFLAGS.AC bit during patching to avoid triggering a #GP fault.

Introduce LASS-specific stac()/clac() helpers along with comments to
clarify their usage versus the existing stac()/clac() helpers for SMAP.

Text poking functions used while patching kernel alternatives use the
standard memcpy()/memset(). However, objtool complains about calling
dynamic functions within an AC=1 region.

One workaround is to add memcpy() and memset() to the list of functions
allowed by objtool. However, that would provide a blanket exemption for
all usages of memcpy() and memset().

Instead, replace the standard memcpy() and memset() calls in the text
poking functions with their unoptimized inline versions. Considering
that patching is usually small, there is no performance impact expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Revert to the inline functions instead of open-coding in assembly.
 - Simplify code comments.
---
 arch/x86/include/asm/smap.h   | 35 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 18 ++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..3ecb4b0de1f9 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,49 @@
 
 #else /* __ASSEMBLER__ */
 
+/*
+ * The CLAC/STAC instructions toggle the enforcement of X86_FEATURE_SMAP
+ * and X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page
+ * tables. The kernel is not allowed to touch pages with the bit set
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
+ * virtual address space unless the AC bit is set.
+ *
+ * Use lass_stac()/lass_clac() when accessing kernel mappings
+ * (!_PAGE_USER) in the lower half of the address space.
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
index 79ae9cb50019..dc90b421d760 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2409,16 +2409,30 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
+ *
+ * Also, objtool enforces a strict policy of "no function calls within
+ * AC=1 regions". Adhere to the policy by using inline versions of
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


