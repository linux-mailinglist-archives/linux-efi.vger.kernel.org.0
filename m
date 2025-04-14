Return-Path: <linux-efi+bounces-3326-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06194A87F5E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13AF1897E23
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05C2BEC26;
	Mon, 14 Apr 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QoQL3hqs"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92929CB4B;
	Mon, 14 Apr 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630782; cv=none; b=np5ohpbDhzMsGX9MKmILSR8aFUKG/s8eNgtqQBAK3kCwOa0BMkkDZECGZM574uRy4nHU0i3dFYA4ENDy+ZtOuFnP21At1CndvMg3X4w/zd46ujnSCYuZUHVL1bZdostSADUwtLTW1VacsPYRtL4obhxEkqdUL42e+eidN6kjsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630782; c=relaxed/simple;
	bh=pcCiP5FTA+Lm/bobq6YiOZWGbXIV/H7h3fpmxDOHmBo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RdBBkNEaOXZdLDktwWSmI/FF9nOIg6yG9tCl3vonJvghiExM/vlNo/O8RTlLR5yA7ruOsALNCIHixLjECuWEzhvsR44tB2Q2mjbVjsyqWxCr7ZvpcRRq8C71C86Gj6yn4SC48pAv+Qaj5pCN95DDHJoSlUOw/Vi7bA9JR2xhjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QoQL3hqs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Af6nUOSfZkjof68kUCgJ+wjJzCjJKMFbRfwFCJ9l/cg=; b=QoQL3hqsSj3gkdRkvHLFh78e+A
	mTih0+/n7JGn+dj+avJt7OZK3u6HQ34OY22w+lS50anSC2L2luJXadQoK2XSBJhLqFCV21ZT48o4w
	dUC7tC5XYhn6rRcrUzzDCmDbXpo+JXkWkMMAm3r5sIAluoH3MVwBEDOgmj7qn21MJYHtN0YksIxb+
	jRpaSUHvauq6e5xJOTwfv2x4z0PftPJbCcoqRCS3jOse/PTyBrGQ22mwqb61yg8mH+7kUxv4el1yS
	mSOYs9srmYOdRm8usvxY0nYwgZ99SrvCGwgClDY5SMB+7wnhtjiRukIPkmKJelHhFRItvYsdJdnjX
	ZhDjvdAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I9u-000000084Gs-0ohz;
	Mon, 14 Apr 2025 11:39:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2A55D30082A; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414113754.062619856@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 peterz@infradead.org,
 jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH 2/6] x86/kvm/emulate: Implement test_cc() in C
References: <20250414111140.586315004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Current test_cc() uses the fastop infrastructure to test flags using
SETcc instructions. However, int3_emulate_jcc() already fully
implements the flags->CC mapping, use that.

Removes a pile of gnarly asm.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   20 +++++++++++++-------
 arch/x86/kvm/emulate.c               |   34 ++--------------------------------
 2 files changed, 15 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -177,9 +177,9 @@ void int3_emulate_ret(struct pt_regs *re
 }
 
 static __always_inline
-void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
+bool __emulate_cc(unsigned long flags, u8 cc)
 {
-	static const unsigned long jcc_mask[6] = {
+	static const unsigned long cc_mask[6] = {
 		[0] = X86_EFLAGS_OF,
 		[1] = X86_EFLAGS_CF,
 		[2] = X86_EFLAGS_ZF,
@@ -192,15 +192,21 @@ void int3_emulate_jcc(struct pt_regs *re
 	bool match;
 
 	if (cc < 0xc) {
-		match = regs->flags & jcc_mask[cc >> 1];
+		match = flags & cc_mask[cc >> 1];
 	} else {
-		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
-			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		match = ((flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
 		if (cc >= 0xe)
-			match = match || (regs->flags & X86_EFLAGS_ZF);
+			match = match || (flags & X86_EFLAGS_ZF);
 	}
 
-	if ((match && !invert) || (!match && invert))
+	return (match && !invert) || (!match && invert);
+}
+
+static __always_inline
+void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
+{
+	if (__emulate_cc(regs->flags, cc))
 		ip += disp;
 
 	int3_emulate_jmp(regs, ip);
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -26,6 +26,7 @@
 #include <asm/debugreg.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
+#include <asm/text-patching.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -416,31 +417,6 @@ static int fastop(struct x86_emulate_ctx
 	ON64(FOP3E(op##q, rax, rdx, cl)) \
 	FOP_END
 
-/* Special case for SETcc - 1 instruction per cc */
-#define FOP_SETCC(op) \
-	FOP_FUNC(op) \
-	#op " %al \n\t" \
-	FOP_RET(op)
-
-FOP_START(setcc)
-FOP_SETCC(seto)
-FOP_SETCC(setno)
-FOP_SETCC(setc)
-FOP_SETCC(setnc)
-FOP_SETCC(setz)
-FOP_SETCC(setnz)
-FOP_SETCC(setbe)
-FOP_SETCC(setnbe)
-FOP_SETCC(sets)
-FOP_SETCC(setns)
-FOP_SETCC(setp)
-FOP_SETCC(setnp)
-FOP_SETCC(setl)
-FOP_SETCC(setnl)
-FOP_SETCC(setle)
-FOP_SETCC(setnle)
-FOP_END;
-
 FOP_START(salc)
 FOP_FUNC(salc)
 "pushf; sbb %al, %al; popf \n\t"
@@ -1068,13 +1044,7 @@ static int em_bsr_c(struct x86_emulate_c
 
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 {
-	u8 rc;
-	void (*fop)(void) = (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
-
-	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=a"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(flags));
-	return rc;
+	return __emulate_cc(flags, condition & 0xf);
 }
 
 static void fetch_register_operand(struct operand *op)



