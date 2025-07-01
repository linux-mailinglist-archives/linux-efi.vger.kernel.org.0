Return-Path: <linux-efi+bounces-4052-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1544AEF40A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9477188C1BE
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0326E6EA;
	Tue,  1 Jul 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b09akE0g"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1A26CE12;
	Tue,  1 Jul 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363945; cv=none; b=PSfSU3M5k+77OWGeEiC5ogzv5JZ4EtB4RJWVldpOzJ/QIdjsk0j2KUD+v9CyEHwuqYNRMUwSQoFD7Bi9ZA+ZT2STPt94VHaZwdK++cBmLu9Vwc37PaqtzaKqJKyO+/3VP5gAEXjZvXQ5hkFhIpUHF7wLYqXqv5+fjQIn7HScDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363945; c=relaxed/simple;
	bh=MH1IaDp7hDo603CvtHddFJjtTuSQLBftTzwh28qZu1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S99OGOcO/TvGlZiyGyPJ2vqrMkzmqi11lo+GUf/0MgJW6elhELmYR7EI1Hx9oINtk+Vgl1pUYX0PfcWafLskiyYfk4A6dwGp3nT1praeLzm/9kJlmQ0RJaeU5SNGtO64Ymwa9pfDhAqFu2qoEtfzwbs6D3m4S3caE1uZUXLsPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b09akE0g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363944; x=1782899944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MH1IaDp7hDo603CvtHddFJjtTuSQLBftTzwh28qZu1M=;
  b=b09akE0gkoxZH7eLMMtU+1/kfGDrkQwMsWJpPnwi0SMBcuSDLhLtlAJW
   tYm2RJPjAJDFRuTBH8X38CGkewQh89t5e2BNyyZ4RTtyc9mOa8k7CHDaR
   ZagxdFbKsbdMOOIJLKhrPHQd9ePviy7i11OpPO0AKnt8ddnY4Rkzj+Zw4
   jQdce78nulsEfMr409azo4xQv1dCVZzl3dQnZRGWY5bvqnJUnmrb9TYJe
   U+HK3YLpwzUcWt322TqYbUThaJls4MjSpNblstup+uO2E2Eq/MWhISrKW
   KgAnuWYykARz2evt0VF3iCh+dd37c48Ee9D0UCak9BLdF1lvl/rak6gr+
   A==;
X-CSE-ConnectionGUID: lneFF278QA6mUaOemILZcA==
X-CSE-MsgGUID: B/yPu5S4Se+y8eC7hm0EwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57427942"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57427942"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:03 -0700
X-CSE-ConnectionGUID: OH/TrHlOTry9t2jFI1A5rA==
X-CSE-MsgGUID: OQFG+yXBQoip9IzJR/wuMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896388"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:58:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3697E376; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Date: Tue,  1 Jul 2025 12:58:31 +0300
Message-ID: <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
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
 arch/x86/lib/clear_page_64.S      | 13 +++++++--
 3 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index c3c2c1914d65..17f6b5bfa8c1 100644
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
+		     : "+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
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
+		     : "memory", _ASM_SI, _ASM_DX);
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
index a508e4a8c66a..47b613690f84 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
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
+ * rdx: clobbered
  */
 SYM_FUNC_START(rep_stos_alternative)
 	ANNOTATE_NOENDBR
+
+	movzbq %al, %rsi
+	movabs $0x0101010101010101, %rax
+
+	/* RDX:RAX = RAX * RSI */
+	mulq %rsi
+
 	cmpq $64,%rcx
 	jae .Lunrolled
 
-- 
2.47.2


