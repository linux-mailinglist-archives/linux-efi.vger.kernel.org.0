Return-Path: <linux-efi+bounces-4962-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D5BC066B
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4245F189EDA7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154B231A24;
	Tue,  7 Oct 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+acjty+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F322A7E0;
	Tue,  7 Oct 2025 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820040; cv=none; b=Hw7vA0CHkldZR9nP3OuJq40aYPJJPiIRZkSO2J9a20+siUcmd3r0KMN33lHLVA+APrJEcSRJLtnqggax3GE4DP31uXf2e2VqZdb66xXzR9o9gz05Paea7jha5/rQYupiFxKRySmcV58I2R6DlCTqwYnHLDR6Ptxw+WQr4dHpVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820040; c=relaxed/simple;
	bh=4N/ktkwoSE/cm5M0B9yQP4RXULxVaZNEE+v/jC6bd5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBwqUi0ypJ/i5yiN2UutP0m2VTuMeIhyY5EPl84TD7faozgUrXk0rMnXwQ1Yud3fKkzn0hKvFP5fJ8Qbb4xadJK6bIPkAjvNRvfAimTUyHA5a0RQuqTHX8LR0VToPtBrxT9qlrax8hqtGv6tnRiYnrjyHDgfEdjhkIqst0IvX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+acjty+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820038; x=1791356038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4N/ktkwoSE/cm5M0B9yQP4RXULxVaZNEE+v/jC6bd5g=;
  b=K+acjty+Y78GcTPLbFR+fjwbIEeaKWKXnhTbJyceyOjCQjBGow/yQmRC
   qipqo+jQHUEwwUfe2OAkAsHe5kLOxEV49tivElYdDzmGd5w3MIko0yfXa
   Jiq1yyyIlSbvchA92GAuNPPNvKE12wRpTl2+O2iVn/Xke4+ekFthWl4yw
   weSb3pJghDqyfY1T7HqAgjzHFboiqAqO47HWkdvJyIE+LZZnYokBpQSKl
   qF5Ni5DL88FnAuppS6MRaHW6SQN181u2dxn2iT6Y4vNrOteWXi+3QucsK
   wcbySxD0prFG+QCTSka/yti653aoEbVNEnj99kXne5xje8MNT2HcpMf57
   A==;
X-CSE-ConnectionGUID: EzgN6OugROulQmOH+3g1lg==
X-CSE-MsgGUID: QdZ39y5kQ2O9+99YzN/fOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254387"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254387"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:53:56 -0700
X-CSE-ConnectionGUID: LMRMWWtuRHG4Els7b6KfKw==
X-CSE-MsgGUID: tVe1ucdQSjSKaDssIHSvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354460"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:53:56 -0700
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
Subject: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Date: Mon,  6 Oct 2025 23:51:05 -0700
Message-ID: <20251007065119.148605-2-sohil.mehta@intel.com>
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

Linear Address Space Separation (LASS) is a security feature that
intends to prevent malicious virtual address space accesses across
user/kernel mode.

Such mode based access protection already exists today with paging and
features such as SMEP and SMAP. However, to enforce these protections,
the processor must traverse the paging structures in memory. An attacker
can use timing information resulting from this traversal to determine
details about the paging structures, and to determine the layout of the
kernel memory.

LASS provides the same mode-based protections as paging but without
traversing the paging structures. Because the protections are enforced
pre-paging, an attacker will not be able to derive paging-based timing
information from the various caching structures such as the TLBs,
mid-level caches, page walker, data caches, etc.

LASS enforcement relies on the kernel implementation to divide the
64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space

Any data access or code execution across address spaces typically
results in a #GP fault. The LASS enforcement for kernel data accesses is
dependent on CR4.SMAP being set. The enforcement can be disabled by
toggling the RFLAGS.AC bit similar to SMAP.

Define the CPU feature bits to enumerate LASS and add a dependency on
SMAP.

LASS mitigates a class of side-channel speculative attacks, such as
Spectre LAM [1]. Add the "lass" flag to /proc/cpuinfo to indicate that
the feature is supported by hardware and enabled by the kernel.  This
allows userspace to determine if the system is secure against such
attacks.

Link: https://download.vusec.net/papers/slam_sp24.pdf [1]
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Xin Li (Intel) <xin@zytor.com>
---
v10:
 - Do not modify tools/**/cpufeatures.h as those are synced separately.
---
 arch/x86/Kconfig.cpufeatures                | 4 ++++
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
 4 files changed, 8 insertions(+)

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
index b2a562217d3f..1283f3bdda0d 100644
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
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 46efcbd6afa4..98d0cdd82574 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -89,6 +89,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
+	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
 	{}
 };
 
-- 
2.43.0


