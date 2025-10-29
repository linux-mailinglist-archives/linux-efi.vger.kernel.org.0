Return-Path: <linux-efi+bounces-5239-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F544C1D5AF
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3E9403AAB
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38143318131;
	Wed, 29 Oct 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxufvlBt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8203161B3;
	Wed, 29 Oct 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771974; cv=none; b=FMFzQHJsXmivPXcBVhT5fU6cGMM1/Cb8PBxOrMHKHRg9wDm7sGfmhEjn1IhzPGt6V0NcoqGWA0CzXKBY9QbiBGkeFYecY359BIn3tzWso08N3bpgpjh2k5BNpIt4FXV8mnfjtpaTR0jyih8tKdCGG3sapIaPkp8JSNp29mr9JFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771974; c=relaxed/simple;
	bh=GZa1beWO4jpQv3wxEbsNLlIWVYDJxzg3uVKa586FHhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agM/m6RoIqndFhxmfOvNJG72yGyKaEmodfzNk7+slK2wrczJvqVxj/wFzoFc0BVjDQyjW9zQe9UMFta9qinXsepUSFagtnXyJnP6p3JZo1pjEPv+DDV+FGFoPHIRo0mdns85k0pmK6ISAq4nbNrPMC72813go4cYBKNfUtjdyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxufvlBt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771973; x=1793307973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZa1beWO4jpQv3wxEbsNLlIWVYDJxzg3uVKa586FHhc=;
  b=jxufvlBtFT8//gMjPqLPstS9oiM1zRMb6Hpt8Fi60rBP4wmVwW+Y/QXP
   MZpqDJXW5Wx32EBSSUcndQXV5163wlXtxDBNCF1Q987ycxiIwiHR5fNfL
   KaZYUuHExQti8nh8VLjQaott6PYSiAUBB+kt4nQ/Af69Rmr31j2Felc/j
   JxtLEd2+RWAA774kTyIobgtvWJAqsBlqo6h9pW4qE7AoSpw/W3g38ssXS
   D+iLQacc2UwD7akmDGOI5YtwyLDnfAkdbbjgAf7/eCUjDiSl89DrTYIC0
   bMys5XIwqd+wFRCYmNKOYsUFmCinS+4CGGFg/eQwrR2KSt6WKzm+nPZgP
   A==;
X-CSE-ConnectionGUID: ylEt+4b4RZyTPWSPBzbYNA==
X-CSE-MsgGUID: hsuB4Q38Qbi9r+o4REsEIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002735"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:11 -0700
X-CSE-ConnectionGUID: I39g/gr5RVqFZ+HSYL59LQ==
X-CSE-MsgGUID: /8v8SkanQyqcr4BR4xLWgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431969"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:10 -0700
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
Subject: [PATCH v11 1/9] x86/cpufeatures: Enumerate the LASS feature bits
Date: Wed, 29 Oct 2025 14:03:02 -0700
Message-ID: <20251029210310.1155449-2-sohil.mehta@intel.com>
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
---
v11:
 - Split the SMAP dependency hunk into a separate patch (patch 2).
 - Improve commit message.

v10:
 - Do not modify tools/**/cpufeatures.h as those are synced separately.
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


