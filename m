Return-Path: <linux-efi+bounces-4054-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C3AEF409
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5793F178804
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760E26FD97;
	Tue,  1 Jul 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCpTGRmz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5F26E706;
	Tue,  1 Jul 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363947; cv=none; b=VFJL74vBd5231s/JUmoaVRh5VamDlz3o2SF/xR7IEcMJX2fg6sWPNl6RQiuNWwP7rgUTcVYhPv9bwFpqZTmHc9awBWrKxt3TrbX+ZrZje9T5jrjvcBSMYHGYMSRcGWnk7qkhIOgDeSox7Bb75UI/G6pPJNJWxLt2Lftd+MX0mqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363947; c=relaxed/simple;
	bh=y0vn0lcrJETMXdw4LaYM0L/E+gW//EAzSxILZz0c9ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0CuFgWPiTXtjV6Pw3pgOZsh2AgDa7bTGYj5AvziXxZsDzrrDgpMXCZvYq9/310KAG+5NT6lguoO1LNEthzw4O/gzdbWWuS0engEULvnLtsSFacDNd6bQm0gB11dITmhwzAik+w/GOqdx8g6n9y1x2m6O2w2B3V7sTd1orcErOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCpTGRmz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363946; x=1782899946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0vn0lcrJETMXdw4LaYM0L/E+gW//EAzSxILZz0c9ew=;
  b=FCpTGRmzfshdF+FsGlYDTiHYI1QR2TMbTquAkTuqu9H9RBMhDYt7ZMcj
   KViqOjQi93KNJP4hdESeHCoPpLzwV018yKZsxAGxsgnVf3FBD3UA3Kzp3
   tx9hTo/L+BOOQtzalQA7QOa1vfHTbNVSUcDNLhNXK/Z7HMpmsPJAxo3ZI
   iKN3a8PTrI64uXBW35wRtHBQqhmwKBJn831IXfxLtb5bZNNUoeHgFbl0r
   lazT8BMLYZwyhgLru63ZygAiiBuSrWBwE6qFhIiznDJ+H1BkomxqfeowY
   hGb9KvRJjYeNUPg49ZrvjkvrqeXB1kpOgSYpJAQqFBRc90dbsoaF6aDKq
   w==;
X-CSE-ConnectionGUID: YwrEUj3DR4aRjrDrEv/WYA==
X-CSE-MsgGUID: Ijodw2LKS1q2yrLfax5gkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57427975"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57427975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:05 -0700
X-CSE-ConnectionGUID: 6jGzRELIQ7uUqZi1iPqqRA==
X-CSE-MsgGUID: TCotVfYvQPq6dUnaXH4C2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896398"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:58:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 48BFC3EA; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 03/17] x86/alternatives: Disable LASS when patching kernel alternatives
Date: Tue,  1 Jul 2025 12:58:32 +0300
Message-ID: <20250701095849.2360685-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. See commit 4fc19708b165 ("x86/alternatives:
Initialize temporary mm for patching").

Disable LASS enforcement during patching to avoid triggering a #GP
fault.

The objtool warns due to a call to a non-allowed function that exists
outside of the stac/clac guard, or references to any function with a
dynamic function pointer inside the guard. See the Objtool warnings
section #9 in the document tools/objtool/Documentation/objtool.txt.

Considering that patching is usually small, replace the memcpy and
memset functions in the text poking functions with their inline versions
respectively.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/smap.h   | 33 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 14 ++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..d0cc24348641 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,47 @@
 
 #else /* __ASSEMBLER__ */
 
+/*
+ * The CLAC/STAC instructions toggle the enforcement of X86_FEATURE_SMAP and
+ * X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page tables: the
+ * kernel is not allowed to touch pages with the bit set unless the AC bit is
+ * set.
+ *
+ * LASS enforcement is based on bit 63 of the virtual address. The kernel is
+ * not allowed to touch memory in the lower half of the virtual address space
+ * unless the AC bit is set.
+ *
+ * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
+ * regardless of location.
+ *
+ * Use lass_stac()/lass_clac() when accessing kernel mappings (!_PAGE_USER)
+ * in the lower half of the address space.
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea1d984166cd..3d2bcb7682eb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2447,16 +2447,26 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
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
2.47.2


