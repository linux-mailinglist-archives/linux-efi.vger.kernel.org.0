Return-Path: <linux-efi+bounces-2047-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64A9B5213
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 19:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA81286342
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19DC2010ED;
	Tue, 29 Oct 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YmaWnHFA"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161E200CB9;
	Tue, 29 Oct 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227752; cv=none; b=r82rmanAoDEGYlpU9h8F3V9Gn/c5N/dINK3Z6dwI1mNnPtf2Te7AF4++9RG0mnrZmK0KGk/wGRvtMbVvEGwr6fTt34TJR/bh3zD8dj8Y9ZMBurlydTZwU29QugK0BD0/IkeZ/IvfYx6vV0NCZ6y9o0ODitCeF1a6qfEIfm77OfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227752; c=relaxed/simple;
	bh=PkvA5fzNrzR2TUSikcBbgOCuOSwlBMxBi+Saje4BysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9aufN4DJ8mdM8alv5ECZ/6q1BlLuciZ+odZ0CUiGWuaiPwPNkWLGi+iwbbW0MdzNYAgJS77NuwHzTnuyq8aNqp3IRok2BCrHhvAohT0DvlE0XJKrlAeYkd3P6/hxM1WeMc5uLZtzD078BLavDkMG7tQOF8yMJUcPZzwUogRsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YmaWnHFA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UErh4zeCMgQHZMV/kkgBSrhYI6M3+izHPip1uO4S+YM=; b=YmaWnHFAvsRuluoaVtOFhr47ML
	nLkaDpaP+4LI68o5DmnleoD3H2tCZBlO58XrTTGew3nmpEeLVjn1xZ6/h/Krb9vZiGpMh3cYDnepa
	bV4iZZHPFZITeSjIAWj+pkYFLWOV1w0VY45INENu5We76mCL2tneDy2D7D7/R4L2uCn+A+/KqxIRy
	sEMU9JfPk41okFpwi2EQS3sLQ58bwOporjRK0T8ncE3xDnMIeGa1rBSMINAiUKJ/DUWV+a0Fr01lQ
	I/lIu2r7f8dVI+4R/7Kd+YYZ6T6yLZTixLyrS+haOrVIDOPAaxrqcHXKtsHc99oS/gb2yilkOmH5C
	6BfIsjNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rGi-0000000AI9Q-1rOk;
	Tue, 29 Oct 2024 18:48:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82BA330073F; Tue, 29 Oct 2024 19:48:40 +0100 (CET)
Date: Tue, 29 Oct 2024 19:48:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20241029184840.GJ14555@noisy.programming.kicks-ass.net>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-4-alexander.shishkin@linux.intel.com>
 <7897bc3e-2d68-4aef-8668-f6eb9f8efd7f@intel.com>
 <20241029113611.GS14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029113611.GS14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 12:36:11PM +0100, Peter Zijlstra wrote:

> Anyway, looking at this, I see we grew rep_{movs,stos}_alternative, as
> used in copy_user_generic() and __clear_user(). Which are all somewhat
> similar.

That is, we could consider something like the completely untested and
probably broken, will light your granny on fire and maul pets like
below..

---
diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index 9cb5aae7fba9..e25a988360a1 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -2,31 +2,50 @@
 #ifndef _ASM_X86_STRING_H
 #define _ASM_X86_STRING_H
 
+#include <asm/asm.h>
+#include <asm/alternative.h>
+
 #ifdef CONFIG_X86_32
 # include <asm/string_32.h>
 #else
 # include <asm/string_64.h>
 #endif
 
+#ifdef CONFIG_X86_64
+#define ALT_64(orig, alt, feat) ALTERNATIVE(orig, alt, feat)
+#else
+#define ALT_64(orig, alt, feat) orig
+#endif
+
 static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
 {
 	void *ret = to;
 
-	asm volatile("rep movsb"
-		     : "+D" (to), "+S" (from), "+c" (len)
-		     : : "memory");
-	return ret;
+	asm volatile("1:\n\t"
+		     ALT_64("rep movsb",
+			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		     "2:\n\t"
+		     _ASM_EXTABLE_UA(1b, 2b)
+		     : "+D" (to), "+S" (from), "+c" (len), ASM_CALL_CONSTRAINT
+		     : : "memory", _ASM_AX);
+
+	return ret + len;
 }
 
 static __always_inline void *__inline_memset(void *s, int v, size_t n)
 {
 	void *ret = s;
 
-	asm volatile("rep stosb"
-		     : "+D" (s), "+c" (n)
+	asm volatile("1:\n\t"
+		     ALT_64("rep stosb",
+			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		     "2:\n\t"
+		     _ASM_EXTABLE_UA(1b, 2b)
+		     : "+D" (s), "+c" (n), ASM_CALL_CONSTRAINT
 		     : "a" ((uint8_t)v)
-		     : "memory");
-	return ret;
+		     : "memory", _ASM_SI);
+
+	return ret + len;
 }
 
 #endif /* _ASM_X86_STRING_H */
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index b0a887209400..9f2d2c2ca731 100644
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
-	might_fault();
-	stac();
+	void *ret;
 
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
+	might_fault();
 
+	stac();
+	ret = __inline_memset(addr, 0, size);
 	clac();
 
-	return size;
+	return ret - addr;
 }
 
 static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 2760a15fbc00..17d4bf6f50e5 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -53,16 +53,22 @@ SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
 
 /*
- * Default clear user-space.
+ * Default memset
  * Input:
  * rdi destination
+ * rsi scratch
  * rcx count
- * rax is zero
+ * al is value
  *
  * Output:
- * rcx: uncleared bytes or 0 if successful.
+ * rcx: unset bytes or 0 if successful.
  */
 SYM_FUNC_START(rep_stos_alternative)
+
+	movzbl %al, %rsi
+	movabs $0x0101010101010101, %rax
+	mulq %rsi
+
 	cmpq $64,%rcx
 	jae .Lunrolled
 

