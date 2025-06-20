Return-Path: <linux-efi+bounces-3846-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FEAAE1CB3
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2838216D9FD
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F07628E5E6;
	Fri, 20 Jun 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nx1YbC3u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611728C2AC;
	Fri, 20 Jun 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427625; cv=none; b=cLx5/Zp/8alRHAp93B2+D29tVw+R+JubyHx7A1JdYLQihUuMB4QgoQ98wRqkWWNN77p5p7l5RqYaGauRPjOf1kL7cta5hmZkv71giGZu/R10bDWFTi6AfLMTKFFXScqKDoijX3xLJlFYuloOdX+45/hNiXTGimyWSgxzdOae0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427625; c=relaxed/simple;
	bh=hBguH5HKy6qvaWcEryNxH+ubaULuT1r46czj/O7PFco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi33oDq4EpsZX1trGhD0wXWqWBJ4JNO399cT9SmgxBlGxIhC5Sm/7sTODpzDb0U3A90EcKBzIiRnAkXQBZpxwIwJlevri1hVNRLhr4eZp2n363X5A+MvXJphE20XibcM+RZXcj4+4kR7KZbngv8mRW8L8EMy7hGyWKERgJUnJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nx1YbC3u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427623; x=1781963623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBguH5HKy6qvaWcEryNxH+ubaULuT1r46czj/O7PFco=;
  b=nx1YbC3ueZVteFfjUuyLfFWxwPraMio2bv/3ZRnlcLNwtfFQUkKGVXgg
   dGox+Wn+eljg7FxS5MKk6VAXKFL1RN0QCyXNnPtWCW3+jxEsgQZ+JPoJh
   eYGynYhyfmux+SZvGEmXQvDd6GYekENaI63cfTWdL9bJr6mdNp69+D0Nj
   swxXB/SJJjvbo+NMPCYRXYhIJbcu9DqprxUuonP4g9V7kCrfWVn08su1l
   jVI9xNjWPRQCKMR6Y4Gm6rt4G+h3KPhdhFRZ2Dm5wYu/Jf8RWzwH/bJiy
   X2vHsnFfbvTpjwKrtN4F+bQp/RB5Kl+LmuTxPxgzQHu9vBBojKAAcLPdQ
   w==;
X-CSE-ConnectionGUID: P8h7opJUQ2CF/QJb1LC6Lw==
X-CSE-MsgGUID: 3/Nn2zmvQl6O5NIFNoZ1Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64047006"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="64047006"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:42 -0700
X-CSE-ConnectionGUID: CUmkhyVxSLO2jeEuBWPjNA==
X-CSE-MsgGUID: Hg2dxZkKQnWtzjMi6WgRnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150411986"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 20 Jun 2025 06:53:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5CC3A131; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
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
Subject: [PATCHv6 02/16] x86/asm: Introduce inline memcpy and memset
Date: Fri, 20 Jun 2025 16:53:10 +0300
Message-ID: <20250620135325.3300848-3-kirill.shutemov@linux.intel.com>
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

Extract memcpy and memset functions from copy_user_generic() and
__clear_user().

They can be used as inline memcpy and memset instead of the GCC builtins
whenever necessary. LASS requires them to handle text_poke.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241029184840.GJ14555@noisy.programming.kicks-ass.net/
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/string.h     | 45 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/uaccess_64.h | 37 +++++++------------------
 arch/x86/lib/clear_page_64.S      | 10 +++++--
 3 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index c3c2c1914d65..d75e965d1ce4 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -1,6 +1,51 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_STRING_H
+#define _ASM_X86_STRING_H
+
+#include <asm/asm.h>
+#include <asm/alternative.h>
+
 #ifdef CONFIG_X86_32
 # include <asm/string_32.h>
 #else
 # include <asm/string_64.h>
 #endif
+
+#ifdef CONFIG_X86_64
+#define ALT_64(orig, alt, feat) ALTERNATIVE(orig, alt, feat)
+#else
+#define ALT_64(orig, alt, feat) orig
+#endif
+
+static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
+{
+	void *ret = to;
+
+	asm volatile("1:\n\t"
+		     ALT_64("rep movsb",
+			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		     "2:\n\t"
+		     _ASM_EXTABLE_UA(1b, 2b)
+		     :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
+		     : : "memory", _ASM_AX);
+
+	return ret + len;
+}
+
+static __always_inline void *__inline_memset(void *addr, int v, size_t len)
+{
+	void *ret = addr;
+
+	asm volatile("1:\n\t"
+		     ALT_64("rep stosb",
+			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		     "2:\n\t"
+		     _ASM_EXTABLE_UA(1b, 2b)
+		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
+		     : "a" ((uint8_t)v)
+		     : "memory", _ASM_SI);
+
+	return ret + len;
+}
+
+#endif /* _ASM_X86_STRING_H */
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..30cc318eb3ed 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -13,6 +13,7 @@
 #include <asm/page.h>
 #include <asm/percpu.h>
 #include <asm/runtime-const.h>
+#include <asm/string.h>
 
 /*
  * Virtual variable: there's no actual backing store for this,
@@ -118,21 +119,12 @@ rep_movs_alternative(void *to, const void *from, unsigned len);
 static __always_inline __must_check unsigned long
 copy_user_generic(void *to, const void *from, unsigned long len)
 {
+	void *ret;
+
 	stac();
-	/*
-	 * If CPU has FSRM feature, use 'rep movs'.
-	 * Otherwise, use rep_movs_alternative.
-	 */
-	asm volatile(
-		"1:\n\t"
-		ALTERNATIVE("rep movsb",
-			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
-		"2:\n"
-		_ASM_EXTABLE_UA(1b, 2b)
-		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax");
+	ret = __inline_memcpy(to, from, len);
 	clac();
-	return len;
+	return ret - to;
 }
 
 static __always_inline __must_check unsigned long
@@ -178,25 +170,14 @@ rep_stos_alternative(void __user *addr, unsigned long len);
 
 static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
 {
+	void *ret;
+
 	might_fault();
 	stac();
-
-	/*
-	 * No memory constraint because it doesn't change any memory gcc
-	 * knows about.
-	 */
-	asm volatile(
-		"1:\n\t"
-		ALTERNATIVE("rep stosb",
-			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
-		"2:\n"
-	       _ASM_EXTABLE_UA(1b, 2b)
-	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
-	       : "a" (0));
-
+	ret = __inline_memset(addr, 0, size);
 	clac();
 
-	return size;
+	return ret - addr;
 }
 
 static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index a508e4a8c66a..ca94828def62 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -55,17 +55,23 @@ SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
 
 /*
- * Default clear user-space.
+ * Default memset.
  * Input:
  * rdi destination
+ * rsi scratch
  * rcx count
- * rax is zero
+ * al is value
  *
  * Output:
  * rcx: uncleared bytes or 0 if successful.
  */
 SYM_FUNC_START(rep_stos_alternative)
 	ANNOTATE_NOENDBR
+
+	movzbq %al, %rsi
+	movabs $0x0101010101010101, %rax
+	mulq %rsi
+
 	cmpq $64,%rcx
 	jae .Lunrolled
 
-- 
2.47.2


