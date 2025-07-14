Return-Path: <linux-efi+bounces-4330-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62959B03C57
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101131A6144C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F424EF8B;
	Mon, 14 Jul 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmbNuKXm"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADF2472BD;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489910; cv=none; b=Yt7d5ed49T3pAEAlkbM5f0zuxevFmZSKtY0M7zv0VKMUwmSEjaToyVYjl/dspkAdxJU5OktRTfANHJc0iko0ieGFNsP9LzFyFwaFiHP6vng6Ww0YiDv3hIGpy5TZoVtTM0/WtyHxP3R0ojz9DMLJbgo/LtmABQCjMp0dvNlDSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489910; c=relaxed/simple;
	bh=fTgYF2PsGCwY0Pjg20fnmDCk2omHnQd0aXz+zTQIPzU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dsFTrctb+weXUWKL8sTldZDy88ACMXtaZ7sgClTZKjMxLEji0o8bUPWmB97YdfTddL5pNRN3fMeKUWwlrsDGupnhDtVDpIhv2xWVkLgu62OsCv+GED1hD56lZbC2/2Oyp5hKj+x9fQTYGsIElXxqVMHh2WC7tOtfLgI0rZDGYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WmbNuKXm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=I75Per9iZErX40IGaiBRNDtT7hqKwKBYiyZ5s6JY19U=; b=WmbNuKXmKkjgJlREf8zjge3ONa
	/p38PPMwiE1NMuDJSHVKMuVz2y+l0qRh9YdzfavyRnS7Q/2fWjjYCxBQgHuRNs6LXytpDf4ZMvl+S
	pfTfENAlx0xazbtkZTKm+TrYnViW5Hb6HgGSYJXux4EjcaDJAxy69K2rWj6YfFOZi1id/durWwrdv
	Hyq+EDOBKTf1e0e+gHoVWnBwjxUC2tyKTxcky/lFqHMJ5ICxmADDLIdf1eRvgFuhQVPqT8PW+MTK5
	8ruOW2sZgtUHMCTR+bQUT7vxQJ1pLlgTfUzaCQlEHo4Y9MhI4l2/itkWGgaIbXcTR2M0/ts/l/BHn
	xPgZRk+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGfz-00000009kca-3A1l;
	Mon, 14 Jul 2025 10:44:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D613F300DD3; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103439.903697475@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:14 +0200
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
Subject: [PATCH v3 03/16] x86/kvm/emulate: Introduce EM_ASM_2
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP2 instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   85 +++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -317,6 +317,15 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
 	EM_ASM_END
 
+/* 2-operand, using "a" (dst), "d" (src) */
+#define EM_ASM_2(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_2(op##b, al, dl); break; \
+	case 2: __EM_ASM_2(op##w, ax, dx); break; \
+	case 4: __EM_ASM_2(op##l, eax, edx); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1027,15 +1036,16 @@ static int read_descriptor(struct x86_em
 	return rc;
 }
 
-FASTOP2(add);
-FASTOP2(or);
-FASTOP2(adc);
-FASTOP2(sbb);
-FASTOP2(and);
-FASTOP2(sub);
-FASTOP2(xor);
-FASTOP2(cmp);
-FASTOP2(test);
+EM_ASM_2(add);
+EM_ASM_2(or);
+EM_ASM_2(adc);
+EM_ASM_2(sbb);
+EM_ASM_2(and);
+EM_ASM_2(sub);
+EM_ASM_2(xor);
+EM_ASM_2(cmp);
+EM_ASM_2(test);
+EM_ASM_2(xadd);
 
 FASTOP1SRC2(mul, mul_ex);
 FASTOP1SRC2(imul, imul_ex);
@@ -1067,7 +1077,6 @@ FASTOP2W(bts);
 FASTOP2W(btr);
 FASTOP2W(btc);
 
-FASTOP2(xadd);
 
 FASTOP2R(cmp, cmp_r);
 
@@ -2304,7 +2313,7 @@ static int em_cmpxchg(struct x86_emulate
 	ctxt->dst.val = reg_read(ctxt, VCPU_REGS_RAX);
 	ctxt->src.orig_val = ctxt->src.val;
 	ctxt->src.val = ctxt->dst.orig_val;
-	fastop(ctxt, em_cmp);
+	em_cmp(ctxt);
 
 	if (ctxt->eflags & X86_EFLAGS_ZF) {
 		/* Success: write back to memory; no update of EAX */
@@ -3069,7 +3078,7 @@ static int em_das(struct x86_emulate_ctx
 	ctxt->src.type = OP_IMM;
 	ctxt->src.val = 0;
 	ctxt->src.bytes = 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
 	ctxt->eflags &= ~(X86_EFLAGS_AF | X86_EFLAGS_CF);
 	if (cf)
 		ctxt->eflags |= X86_EFLAGS_CF;
@@ -3095,7 +3104,7 @@ static int em_aam(struct x86_emulate_ctx
 	ctxt->src.type = OP_IMM;
 	ctxt->src.val = 0;
 	ctxt->src.bytes = 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
 
 	return X86EMUL_CONTINUE;
 }
@@ -3113,7 +3122,7 @@ static int em_aad(struct x86_emulate_ctx
 	ctxt->src.type = OP_IMM;
 	ctxt->src.val = 0;
 	ctxt->src.bytes = 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
 
 	return X86EMUL_CONTINUE;
 }
@@ -3998,9 +4007,9 @@ static int check_perm_out(struct x86_emu
 #define I2bvIP(_f, _e, _i, _p) \
 	IIP((_f) | ByteOp, _e, _i, _p), IIP(_f, _e, _i, _p)
 
-#define F6ALU(_f, _e) F2bv((_f) | DstMem | SrcReg | ModRM, _e),		\
-		F2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
-		F2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
+#define I6ALU(_f, _e) I2bv((_f) | DstMem | SrcReg | ModRM, _e),		\
+		I2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
+		I2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
 
 static const struct opcode group7_rm0[] = {
 	N,
@@ -4038,14 +4047,14 @@ static const struct opcode group7_rm7[]
 };
 
 static const struct opcode group1[] = {
-	F(Lock, em_add),
-	F(Lock | PageTable, em_or),
-	F(Lock, em_adc),
-	F(Lock, em_sbb),
-	F(Lock | PageTable, em_and),
-	F(Lock, em_sub),
-	F(Lock, em_xor),
-	F(NoWrite, em_cmp),
+	I(Lock, em_add),
+	I(Lock | PageTable, em_or),
+	I(Lock, em_adc),
+	I(Lock, em_sbb),
+	I(Lock | PageTable, em_and),
+	I(Lock, em_sub),
+	I(Lock, em_xor),
+	I(NoWrite, em_cmp),
 };
 
 static const struct opcode group1A[] = {
@@ -4064,8 +4073,8 @@ static const struct opcode group2[] = {
 };
 
 static const struct opcode group3[] = {
-	F(DstMem | SrcImm | NoWrite, em_test),
-	F(DstMem | SrcImm | NoWrite, em_test),
+	I(DstMem | SrcImm | NoWrite, em_test),
+	I(DstMem | SrcImm | NoWrite, em_test),
 	I(DstMem | SrcNone | Lock, em_not),
 	I(DstMem | SrcNone | Lock, em_neg),
 	F(DstXacc | Src2Mem, em_mul_ex),
@@ -4258,29 +4267,29 @@ static const struct instr_dual instr_dua
 
 static const struct opcode opcode_table[256] = {
 	/* 0x00 - 0x07 */
-	F6ALU(Lock, em_add),
+	I6ALU(Lock, em_add),
 	I(ImplicitOps | Stack | No64 | Src2ES, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2ES, em_pop_sreg),
 	/* 0x08 - 0x0F */
-	F6ALU(Lock | PageTable, em_or),
+	I6ALU(Lock | PageTable, em_or),
 	I(ImplicitOps | Stack | No64 | Src2CS, em_push_sreg),
 	N,
 	/* 0x10 - 0x17 */
-	F6ALU(Lock, em_adc),
+	I6ALU(Lock, em_adc),
 	I(ImplicitOps | Stack | No64 | Src2SS, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2SS, em_pop_sreg),
 	/* 0x18 - 0x1F */
-	F6ALU(Lock, em_sbb),
+	I6ALU(Lock, em_sbb),
 	I(ImplicitOps | Stack | No64 | Src2DS, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2DS, em_pop_sreg),
 	/* 0x20 - 0x27 */
-	F6ALU(Lock | PageTable, em_and), N, N,
+	I6ALU(Lock | PageTable, em_and), N, N,
 	/* 0x28 - 0x2F */
-	F6ALU(Lock, em_sub), N, I(ByteOp | DstAcc | No64, em_das),
+	I6ALU(Lock, em_sub), N, I(ByteOp | DstAcc | No64, em_das),
 	/* 0x30 - 0x37 */
-	F6ALU(Lock, em_xor), N, N,
+	I6ALU(Lock, em_xor), N, N,
 	/* 0x38 - 0x3F */
-	F6ALU(NoWrite, em_cmp), N, N,
+	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
 	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
 	/* 0x50 - 0x57 */
@@ -4306,7 +4315,7 @@ static const struct opcode opcode_table[
 	G(DstMem | SrcImm, group1),
 	G(ByteOp | DstMem | SrcImm | No64, group1),
 	G(DstMem | SrcImmByte, group1),
-	F2bv(DstMem | SrcReg | ModRM | NoWrite, em_test),
+	I2bv(DstMem | SrcReg | ModRM | NoWrite, em_test),
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable, em_xchg),
 	/* 0x88 - 0x8F */
 	I2bv(DstMem | SrcReg | ModRM | Mov | PageTable, em_mov),
@@ -4329,7 +4338,7 @@ static const struct opcode opcode_table[
 	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
 	F2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
 	/* 0xA8 - 0xAF */
-	F2bv(DstAcc | SrcImm | NoWrite, em_test),
+	I2bv(DstAcc | SrcImm | NoWrite, em_test),
 	I2bv(SrcAcc | DstDI | Mov | String, em_mov),
 	I2bv(SrcSI | DstAcc | Mov | String, em_mov),
 	F2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
@@ -4467,7 +4476,7 @@ static const struct opcode twobyte_table
 	I(DstReg | SrcMem | ModRM, em_bsr_c),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),
 	/* 0xC0 - 0xC7 */
-	F2bv(DstMem | SrcReg | ModRM | SrcWrite | Lock, em_xadd),
+	I2bv(DstMem | SrcReg | ModRM | SrcWrite | Lock, em_xadd),
 	N, ID(0, &instr_dual_0f_c3),
 	N, N, N, GD(0, &group9),
 	/* 0xC8 - 0xCF */



