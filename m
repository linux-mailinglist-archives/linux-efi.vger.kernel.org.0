Return-Path: <linux-efi+bounces-3850-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA3AE1CBA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC30172664
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22BD29551E;
	Fri, 20 Jun 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U02h4ToN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9828B7C5;
	Fri, 20 Jun 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427627; cv=none; b=WXlBWMRWrgdMzAmuY8WuWjgNqmQ221MWWs7sBebxUvMcgGzbAyST49F5X7ATRHCnZtDOa1teK2sma24ferBwanosKEMTW7yk6bO8Ew3pY2kgJfg8+8NCj0noz4R4zbzl2GONyF/hrc0cThywBU8qRzmN/owCR1irFOOWX3rol2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427627; c=relaxed/simple;
	bh=cyQl5wwakRbv76k1YvxJC2e2S422at1UGipEhH7xKXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm3StKZ0BNPR73cxjRv5jjrBfZOXMkFcCBZIHWCkdTB1ggKSryVUQnNHoTen4yK0oKG7Z6+vYehm0iom8KLi6zo8osceG/q5jo+eK9PGMAZGEVWRwqoLPPLGHCOOAD0UIMkQH7MGcbOw4BNsX06GjXCMJtWFtY7RBR6I5K5AhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U02h4ToN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427626; x=1781963626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cyQl5wwakRbv76k1YvxJC2e2S422at1UGipEhH7xKXo=;
  b=U02h4ToNecaXijsYtclrWrHnTJMCCmnfFxuceeWTsEWiOnIlIGnQwZ2u
   bn8DBeIuY+m6+Sd0VubEqUv6B45Tgk8eGQk7nxIiAQ+CH44Q67vlq5yA4
   8iy4y3fZSvuHKmEbkfcWOv//AoLF/Y5IlYUEWSgVt4iX9WDsGnjlvj81V
   WdJse2tMd1y33/DJss/ZVF5axknbddPa+Igx/I+ASSjC3sdMiwgxKCP82
   QhwRN/F+j3h2md8NQ13uprBbywQoaEytaPdbdjbD7zM5wBTFRUaUmzuii
   NnucL7hcB/wjLzpxih5PxR4SeKaUcIi4OxWyxZb11z9W9veiDB+7vEIYF
   g==;
X-CSE-ConnectionGUID: IL2dPsF9Qi6otpcZfQv4tw==
X-CSE-MsgGUID: Ki/Ki7yxTM6tqb7XsecJrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64047082"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="64047082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:43 -0700
X-CSE-ConnectionGUID: LsVYINO5ReazqEHBTdUpag==
X-CSE-MsgGUID: dBoUO9spSxmOf6qslGubPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150412000"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 20 Jun 2025 06:53:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4E163AF; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	Yian Chen <yian.chen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Date: Fri, 20 Jun 2025 16:53:09 +0300
Message-ID: <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

Linear Address Space Separation (LASS) is a security feature that
intends to prevent malicious virtual address space accesses across
user/kernel mode.

Such mode based access protection already exists today with paging and
features such as SMEP and SMAP. However, to enforce these protections,
the processor must traverse the paging structures in memory.  Malicious
software can use timing information resulting from this traversal to
determine details about the paging structures, and these details may
also be used to determine the layout of the kernel memory.

The LASS mechanism provides the same mode-based protections as paging
but without traversing the paging structures. Because the protections
enforced by LASS are applied before paging, software will not be able to
derive paging-based timing information from the various caching
structures such as the TLBs, mid-level caches, page walker, data caches,
etc.

LASS enforcement relies on the typical kernel implementation to divide
the 64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space

Any data access or code execution across address spaces typically
results in a #GP fault.

The LASS enforcement for kernel data access is dependent on CR4.SMAP
being set. The enforcement can be disabled by toggling the RFLAGS.AC bit
similar to SMAP.

Define the CPU feature bits to enumerate this feature and include
feature dependencies to reflect the same.

Co-developed-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig.cpufeatures                |  4 ++++
 arch/x86/include/asm/cpufeatures.h          |  1 +
 arch/x86/include/asm/smap.h                 | 22 +++++++++++++++++++--
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
 tools/arch/x86/include/asm/cpufeatures.h    |  1 +
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 250c10627ab3..9574c198fc08 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
 	def_bool y
 	depends on !X86_64
 
+config X86_DISABLED_FEATURE_LASS
+	def_bool y
+	depends on !X86_64
+
 config X86_DISABLED_FEATURE_PKU
 	def_bool y
 	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ee176236c2be..4473a6f7800b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..1f36c5b26949 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,36 @@
 
 #else /* __ASSEMBLER__ */
 
+/*
+ * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP.
+ *
+ * X86_FEATURE_LASS requires flipping the AC flag when accessing the lower half
+ * of the virtual address space, regardless of the _PAGE_BIT_USER bit in the
+ * page tables. lass_clac/stac() should be used for these cases.
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
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index e02be2962a01..20df2ce5d339 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
-- 
2.47.2


