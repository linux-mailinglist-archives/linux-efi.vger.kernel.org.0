Return-Path: <linux-efi+bounces-5497-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5203C5A5E2
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371EA3B14B0
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D995326D6D;
	Thu, 13 Nov 2025 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRaSSnLm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F6326942;
	Thu, 13 Nov 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073920; cv=none; b=tXik9x3EmtwIaZNs81T1mC3r0Uyt9quOX27gigEKQxBRzvMcFj1pgu/m1+zdkjyOI5AUhFI6bJFU+QuC2mW7KBCGUqVRG4bAznfcFIpDEARRvB/eY39Ngtw9+XyQLDfORrj38IMBv9DJuHhEHaRS9j+nwT9E6DLNAmPw0xxc/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073920; c=relaxed/simple;
	bh=iGj4Bp38cIMAdXi3xTm5k9nWPfso400Ax3LsO+5Bkt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2yYVuDP3APaD7/sYy4XRR2gokpbGcB7i4RV23EGmzMxOxurZQoiAW9IY3aOa/w5SmPnp/l9eZyVNGJ0SIGSLl/pWep2qgl8OeWXfyge9vO9cppXGow6i8ttPMB2XHWZ7ts3h9+JHdN1kLkNIBMfA0wFuzBEYDpbrjSuj9BzkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRaSSnLm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073918; x=1794609918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iGj4Bp38cIMAdXi3xTm5k9nWPfso400Ax3LsO+5Bkt0=;
  b=LRaSSnLmHKuRNnGIZIdsIRtgY+GH4QoxidmG+mIQy1Rtviipkzxe7muv
   OQPPKTac8oev9rQBt9y2xR3JYYojJac85A0QRXn6cnagKJU6B6DS4G112
   4EHV3UdYfsLi9f2q5P9CNpG6PbA1RDFZypJ0eS2xn7MlOF9kSQOl/o9qR
   sdaGGSYtpC6c9iZDfcljSDqhm0rg/qZ/865/F9kVE80luJw6FqyzoUtmg
   rlm+WnHbob07usWTpmKeakx5XTuzSTlqBjRoYHBGNwqkv9KdCxAbWSNIY
   QezU/A3Jjy0ALTnjOSujmnfFM2UUn/6cfrGIJTtFiyJrg2EKGfoK5uyJ9
   g==;
X-CSE-ConnectionGUID: VmDIYkm1Sim96wwJDukcDw==
X-CSE-MsgGUID: KyNqWnMeQCKQbd7HGHcHYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051900"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:16 -0800
X-CSE-ConnectionGUID: LK5OceK0SFO1rOK39TwQLQ==
X-CSE-MsgGUID: UEHLRbkPRkOOOEw+/P7YXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611081"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:15 -0800
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
Subject: [PATCH v12 1/8] x86/cpufeatures: Enumerate the LASS feature bits
Date: Thu, 13 Nov 2025 14:41:57 -0800
Message-ID: <20251113224204.50391-2-sohil.mehta@intel.com>
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

Linear Address Space Separation (LASS) is a security feature that
mitigates a class of side-channel attacks relying on speculative access
across the user/kernel boundary.

Privilege mode based access protection already exists today with paging
and features such as SMEP and SMAP. However, to enforce these
protections, the processor must traverse the paging structures in
memory. An attacker can use timing information resulting from this
traversal to determine details about the paging structures, and to
determine the layout of the kernel memory.

LASS provides the same mode-based protections as paging but without
traversing the paging structures. Because the protections are enforced
prior to page-walks, an attacker will not be able to derive paging-based
timing information from the various caching structures such as the TLBs,
mid-level caches, page walker, data caches, etc.

LASS enforcement relies on the kernel implementation to divide the
64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space

Any data access or code execution across address spaces typically
results in a #GP fault, with an #SS generated in some rare cases. The
LASS enforcement for kernel data accesses is dependent on CR4.SMAP being
set. The enforcement can be disabled by toggling the RFLAGS.AC bit
similar to SMAP.

Define the CPU feature bits to enumerate LASS. Also, disable the feature
at compile time on 32-bit kernels. Use a direct dependency on X86_32
(instead of !X86_64) to make it easier to combine with similar 32-bit
specific dependencies in the future.

LASS mitigates a class of side-channel speculative attacks, such as
Spectre LAM, described in the paper, "Leaky Address Masking: Exploiting
Unmasked Spectre Gadgets with Noncanonical Address Translation".

Add the "lass" flag to /proc/cpuinfo to indicate that the feature is
supported by hardware and enabled by the kernel. This allows userspace
to determine if the system is secure against such attacks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - Split the SMAP dependency hunk into a separate patch (patch 2).
 - Improve commit message.
---
 arch/x86/Kconfig.cpufeatures                | 4 ++++
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 250c10627ab3..733d5aff2456 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
 	def_bool y
 	depends on !X86_64
 
+config X86_DISABLED_FEATURE_LASS
+	def_bool y
+	depends on X86_32
+
 config X86_DISABLED_FEATURE_PKU
 	def_bool y
 	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4091a776e37a..8d872eb08c16 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -314,6 +314,7 @@
 #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index f1a4adc78272..81d0c8bf1137 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -136,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LASS_BIT	27 /* enable Linear Address Space Separation support */
+#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
 #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
 #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
-- 
2.43.0


