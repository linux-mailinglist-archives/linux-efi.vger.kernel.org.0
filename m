Return-Path: <linux-efi+bounces-3976-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C5AE8334
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF86917A505
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEC263F30;
	Wed, 25 Jun 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WscCoV8y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F45262FDB;
	Wed, 25 Jun 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855889; cv=none; b=XQbplz6OjB9sj/KrfGvIGHPmiBCET9FtZ1BLe1q9JJr9LpkwP2NPQ7t3M+PxQsZysOXQ+LAV4c7QGFDUysrP8cs53kKfLSJeNw4sq33shk5cCl+3cy67IDQdxhU5lMe5R4w01COWi6JAYjusPmEPHI4wbn1NtCJz+varrqMatXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855889; c=relaxed/simple;
	bh=1q6/ECc49ZMw6ZJhZhOn96PRYQi7zMMajTxiCNRfBKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWMXYrgJ1HxGqPVPRQVmiVF29Bi8ry83gkntmbAiW5Ef6J2fDDlZLmsuqQF3bLFk7Gl+Q6GDrxNrAP/a0x0nLWuo9emKVjnZPIyqauSI2xFatXwjLRa0QTpUpjKLOwG4p3YMcfMlHIQiOoLAeWFWVTwjsGV0EJqtnFgXQArNwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WscCoV8y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855887; x=1782391887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1q6/ECc49ZMw6ZJhZhOn96PRYQi7zMMajTxiCNRfBKg=;
  b=WscCoV8yPwfOTGXLUp9Bi3TikjexTFJjcdQGqktkJ3HTdTZ9WwGJdZgX
   o8e7PL0KhTJ+GvYdFORKkSX9zMsb2r4Hvc3N/TQ5lD2OOezePfR0fwjOf
   RNg0+t9qL63QfPmyzT+oEDh/WJV0bjnCRWkYt0ePnZO7SJO6AOAKS+RBZ
   rAvJoA+zBvPp8kQlQ6hh3c1iYSdI0whciJaR5LTvMs5r2jcbZYC8lPfRe
   bpVVNeTCbARK+vuMjqREqtLlvHC1Z5cK+p0gN/MacQAbh/zUDaA2soj0d
   ZIouC/7/nc2VQpRkHftlwb4zlCWg89bEKqgoMcLG6eKJ7ghpMBdXKDixz
   Q==;
X-CSE-ConnectionGUID: bU5KWPKmR4mRAFdK/Q0RLg==
X-CSE-MsgGUID: hy6svplUSNCgIJm7w2XVkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189499"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:26 -0700
X-CSE-ConnectionGUID: yazXotynQdmxFGtyq6wR+Q==
X-CSE-MsgGUID: QNwNu1pdSYWYab4XqA2Gqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 794752BA; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 02/16] x86/asm: Introduce inline memcpy and memset
Date: Wed, 25 Jun 2025 15:50:55 +0300
Message-ID: <20250625125112.3943745-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/include/asm/string.h     | 46 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/uaccess_64.h | 38 +++++++------------------
 arch/x86/lib/clear_page_64.S      | 10 +++++--
 3 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index c3c2c1914d65..5cd0f18a431f 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -1,6 +1,52 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_STRING_H
+#define _ASM_X86_STRING_H
+
+#include <asm/asm.h>
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
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
+#define ALT_64(orig, alt, feat) orig "\n"
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
index c8a5ae35c871..eb531e13e659 100644
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
@@ -178,25 +170,15 @@ rep_stos_alternative(void __user *addr, unsigned long len);
 
 static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
 {
+	void *ptr = (__force void *)addr;
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
+	ret = __inline_memset(ptr, 0, size);
 	clac();
 
-	return size;
+	return ret - ptr;
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


