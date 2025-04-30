Return-Path: <linux-efi+bounces-3495-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D7AA49C2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E1B4E32C8
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2380248F40;
	Wed, 30 Apr 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MnYymzMs"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50398204F9C;
	Wed, 30 Apr 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012407; cv=none; b=YZF4AVrajaUfSIeAgcb1u9kFvihdqYTMs1M5pdazXmjO3KIkKQlD4yL+UkVZfdEPIMPHxZPo2G09Ym48VXc+QONFA66k7cMzFq0gYONhzi9iKQvA0/3cYlfoVA1daaCo+kZwiNIeSSO4sn+eDvYUCD+BTmSS2xpji1tC0GzQ3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012407; c=relaxed/simple;
	bh=pQ9Yaxx54zBVXHxbZ2BkYpBzdP6e5jjIv6A+opO62k8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S27yRrdjUjQ4ydtm3aMx7dte02O6/mQbGRmegJCvbyfxYB1yBgWkUW0907BLOMkadAegZTBNGNHZo9lhw344DLYB+pAPjI6QfAOlspwjwfj7c3aSOrscBF4STv5rB90vNKbCHGrAByHkZ17FU3EEXYhwB3G9BPq1thcMDqGznkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MnYymzMs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=2FI0P7JQN/8TK4ts59kC/fO10NTZfLMEix72+dV+X7U=; b=MnYymzMsf8tkCwJFiDMJ/8gnOa
	DXoYNnPBrg2IMJdeR7FTzqwJuhRsvmXO9rQXn7ozeb6wlzWjSQYKRaYMYvXWFQL0DHRhYbqpD7S5O
	gws0BM8Eb4LNTlQzIogrPJ98yx16HDhgwh2o6SIMTFonBPQchAx10WKaxbILUiWHHv3lxntQZjvvY
	OEs/98UXbBfPGF1zkrWkqfMMl7gwBxqoTTUDKIb+0IIyloGLx37zzqH1GjnG2m0wRsg/i/QOZTVhY
	Pku0geu+XPfgXCc3W61vDb8mIE2Frb2NwEiYR2z2QyAnC3j8vMk2v+V6l3Pe8Hkk0lXcIbq1NaObm
	FbHC/Sxg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA5aH-0000000C6a5-02iR;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E08E63061EE; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.751028945@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:41 +0200
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
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 jpoimboe@kernel.org,
 peterz@infradead.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH v2 07/13] x86/kvm/emulate: Introduce COP1SRC2
References: <20250430110734.392235199@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP1SRC2*() instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -317,6 +317,24 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: COP_ASM1(op##q, rax); break;) \
 	COP_END
 
+/* 1-operand, using "c" (src2) */
+#define COP1SRC2(op, name) \
+	COP_START(name) \
+	case 1: COP_ASM1(op##b, cl); break; \
+	case 2: COP_ASM1(op##w, cx); break; \
+	case 4: COP_ASM1(op##l, ecx); break; \
+	ON64(case 8: COP_ASM1(op##q, rcx); break;) \
+	COP_END
+
+/* 1-operand, using "c" (src2) with exception */
+#define COP1SRC2EX(op, name) \
+	COP_START(name) \
+	case 1: COP_ASM1_EX(op##b, cl); break; \
+	case 2: COP_ASM1_EX(op##w, cx); break; \
+	case 4: COP_ASM1_EX(op##l, ecx); break; \
+	ON64(case 8: COP_ASM1(op##q, rcx); break;) \
+	COP_END
+
 /* 2-operand, using "a" (dst), "d" (src) */
 #define COP2(op) \
 	COP_START(op) \
@@ -1074,10 +1092,10 @@ COP2(cmp);
 COP2(test);
 COP2(xadd);
 
-FASTOP1SRC2(mul, mul_ex);
-FASTOP1SRC2(imul, imul_ex);
-FASTOP1SRC2EX(div, div_ex);
-FASTOP1SRC2EX(idiv, idiv_ex);
+COP1SRC2(mul, mul_ex);
+COP1SRC2(imul, imul_ex);
+COP1SRC2EX(div, div_ex);
+COP1SRC2EX(idiv, idiv_ex);
 
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
@@ -4103,10 +4121,10 @@ static const struct opcode group3[] = {
 	I(DstMem | SrcImm | NoWrite, em_test),
 	I(DstMem | SrcNone | Lock, em_not),
 	I(DstMem | SrcNone | Lock, em_neg),
-	F(DstXacc | Src2Mem, em_mul_ex),
-	F(DstXacc | Src2Mem, em_imul_ex),
-	F(DstXacc | Src2Mem, em_div_ex),
-	F(DstXacc | Src2Mem, em_idiv_ex),
+	I(DstXacc | Src2Mem, em_mul_ex),
+	I(DstXacc | Src2Mem, em_imul_ex),
+	I(DstXacc | Src2Mem, em_div_ex),
+	I(DstXacc | Src2Mem, em_idiv_ex),
 };
 
 static const struct opcode group4[] = {



