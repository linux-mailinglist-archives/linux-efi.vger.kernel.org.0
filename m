Return-Path: <linux-efi+bounces-4320-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FEB03C31
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8021E7ADE1A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F68D248166;
	Mon, 14 Jul 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q2oXozo+"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A1246348;
	Mon, 14 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489908; cv=none; b=jDdMmFJJDxvHHUUhqGWuyKev8AXlfgcwaU9Wd2lY8DH4MBIZFdE5RdzE16OwLw8/sWab0fJME7RNJ0FYRDv1Z9cxkc47M1LGQ7CeR5KULnOOrtdBtuPp3ZkavdVYZubH0qLH5LCvnJmp+vDvQpgvDXzVlz9Mng18g/p/MMO8Vzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489908; c=relaxed/simple;
	bh=PdAeXVf6Vqp6oyKtuCeP7lKnTP97pY4tt8hC+7YL5Y8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MP86hnMvQtAIFpOsKkiq/wG6UvIee38VER058bYlMgkBa3jUEKtBmrl0pRn4VTQMhQT4QjV7191eoWLLDYSZTVybX8admDPPN9DLWZmDBrcRaV2DKFq856hYODafnBKjcCWe17v8cxIufo1OsbpKJYb5sGZfTwz3zVLB39VzUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q2oXozo+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=uP3uw2B1ls5qkdz2Wl3msyHx5+mDer9y8QVhMyZ1gnc=; b=q2oXozo+F0MPpsnTwUJOz6e2Fc
	5FyXmhE9A0S891VO0Jw8CZvzEz7Lp5OlCO01zEmRJ+ICU04kKQEGz9COkm++85lh6rEZ+XcnI8+VK
	AKc7nDnnHzUqgTHMKUpB6zhH2USYyi6gAXDfdwkVIr64Ro1tf/vlb3MOqYp6izn/9to/WeG9HCsX3
	99qUmINyk6wf6uaVv+lSH11qvoANZHk358h21f0JUWa9Bl6U9wMUtaLmjgdSxfeFmsz9tNC2k/5uV
	e+R6yG97H5MrICXgCysnpe0/BYj32PtDAJ98ZLrUyZiuCfG9QjyjQYvLPhJk7psqRcuV1b6nbzlvp
	G8myFu+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000009kcg-268u;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DE4E5300F1D; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.142923581@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:16 +0200
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
Subject: [PATCH v3 05/16] x86/kvm/emulate: Introduce EM_ASM_2W
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP2W instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -335,6 +335,15 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_2(op##q, rdx, rax); break;) \
 	EM_ASM_END
 
+/* 2-operand, word only (no byte op) */
+#define EM_ASM_2W(op) \
+	EM_ASM_START(op) \
+	case 1: break; \
+	case 2: __EM_ASM_2(op##w, ax, dx); break; \
+	case 4: __EM_ASM_2(op##l, eax, edx); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1064,7 +1073,7 @@ FASTOP1SRC2EX(idiv, idiv_ex);
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
 
-FASTOP2W(imul);
+EM_ASM_2W(imul);
 
 EM_ASM_1(not);
 EM_ASM_1(neg);
@@ -1079,12 +1088,12 @@ FASTOP2CL(shl);
 FASTOP2CL(shr);
 FASTOP2CL(sar);
 
-FASTOP2W(bsf);
-FASTOP2W(bsr);
-FASTOP2W(bt);
-FASTOP2W(bts);
-FASTOP2W(btr);
-FASTOP2W(btc);
+EM_ASM_2W(bsf);
+EM_ASM_2W(bsr);
+EM_ASM_2W(bt);
+EM_ASM_2W(bts);
+EM_ASM_2W(btr);
+EM_ASM_2W(btc);
 
 EM_ASM_2R(cmp, cmp_r);
 
@@ -1093,7 +1102,7 @@ static int em_bsf_c(struct x86_emulate_c
 	/* If src is zero, do not writeback, but update flags */
 	if (ctxt->src.val == 0)
 		ctxt->dst.type = OP_NONE;
-	return fastop(ctxt, em_bsf);
+	return em_bsf(ctxt);
 }
 
 static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
@@ -1101,7 +1110,7 @@ static int em_bsr_c(struct x86_emulate_c
 	/* If src is zero, do not writeback, but update flags */
 	if (ctxt->src.val == 0)
 		ctxt->dst.type = OP_NONE;
-	return fastop(ctxt, em_bsr);
+	return em_bsr(ctxt);
 }
 
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
@@ -3221,7 +3230,7 @@ static int em_xchg(struct x86_emulate_ct
 static int em_imul_3op(struct x86_emulate_ctxt *ctxt)
 {
 	ctxt->dst.val = ctxt->src2.val;
-	return fastop(ctxt, em_imul);
+	return em_imul(ctxt);
 }
 
 static int em_cwd(struct x86_emulate_ctxt *ctxt)
@@ -4135,10 +4144,10 @@ static const struct group_dual group7 =
 
 static const struct opcode group8[] = {
 	N, N, N, N,
-	F(DstMem | SrcImmByte | NoWrite,		em_bt),
-	F(DstMem | SrcImmByte | Lock | PageTable,	em_bts),
-	F(DstMem | SrcImmByte | Lock,			em_btr),
-	F(DstMem | SrcImmByte | Lock | PageTable,	em_btc),
+	I(DstMem | SrcImmByte | NoWrite,		em_bt),
+	I(DstMem | SrcImmByte | Lock | PageTable,	em_bts),
+	I(DstMem | SrcImmByte | Lock,			em_btr),
+	I(DstMem | SrcImmByte | Lock | PageTable,	em_btc),
 };
 
 /*
@@ -4459,27 +4468,27 @@ static const struct opcode twobyte_table
 	/* 0xA0 - 0xA7 */
 	I(Stack | Src2FS, em_push_sreg), I(Stack | Src2FS, em_pop_sreg),
 	II(ImplicitOps, em_cpuid, cpuid),
-	F(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
+	I(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
 	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
 	F(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
 	/* 0xA8 - 0xAF */
 	I(Stack | Src2GS, em_push_sreg), I(Stack | Src2GS, em_pop_sreg),
 	II(EmulateOnUD | ImplicitOps, em_rsm, rsm),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
 	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
 	F(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
-	GD(0, &group15), F(DstReg | SrcMem | ModRM, em_imul),
+	GD(0, &group15), I(DstReg | SrcMem | ModRM, em_imul),
 	/* 0xB0 - 0xB7 */
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable | SrcWrite, em_cmpxchg),
 	I(DstReg | SrcMemFAddr | ModRM | Src2SS, em_lseg),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock, em_btr),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock, em_btr),
 	I(DstReg | SrcMemFAddr | ModRM | Src2FS, em_lseg),
 	I(DstReg | SrcMemFAddr | ModRM | Src2GS, em_lseg),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),
 	/* 0xB8 - 0xBF */
 	N, N,
 	G(BitOp, group8),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_btc),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_btc),
 	I(DstReg | SrcMem | ModRM, em_bsf_c),
 	I(DstReg | SrcMem | ModRM, em_bsr_c),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),



