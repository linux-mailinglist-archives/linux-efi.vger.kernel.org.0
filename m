Return-Path: <linux-efi+bounces-3503-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D3AA49E5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55691C02402
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FC25B1CB;
	Wed, 30 Apr 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UGv+MF41"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0C24A047;
	Wed, 30 Apr 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012410; cv=none; b=W5a2POJOxFksXQgFUVwcWFSK4bAJHag0fH/MDlbTwVqPiZSUJ69lI8Kylg4xSt7YzGY8QEMaDoY+AynyJyg9v5mPi5XSkDuAvVZjvzs3pTPJI6s5103fyOA+UUxcwDbGFB7KV/wuEF5GTpy9d3JKkEwW1RIbSjGeez1T5JPYgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012410; c=relaxed/simple;
	bh=tskvLx3A/90lRbxLNLzK9gXJCjHC1JDHK9WLIR2sVAU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SEgps30htVP9wIgPc0K0Q+w3AZAzS4snD7E6+PYePkrBCHNawT5JwIiHYXWEzWyDZpiMNpZM9T+ZLldOPC+SJ+V24GjV9RjhuYpebICQAycrFfQV9e1H8p1RdWQ9UPJT3VAX9iCxsEqElGZzvZ6ZLJc874bJrx6fXK0jKla3Zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UGv+MF41; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=pyZj6ujzhsAiSHKF9sTlt+P1SIFUzJGpqnjLwaUJEus=; b=UGv+MF41Qujbmmxih7/US5QKm3
	VG7vkHZGv645tqxzqe7JYiKFt/5RENUJk2MvUDORStSekA4chgETWKfQkHthTOs0T1eB+4NP+R3qK
	TOfIIKxI6vHTroJW2xJGBq/0OUXYTlx9YZyRA46TUgDdDX3REEjjqBxdpUHiPw21YOeqe8jayX9J7
	RovE71uTeIHoJmfWs8bgtQBHczeQSXR+g7ODesw76HbLxoSYBpCB0m3J/TIrnk0OhIrWJUH5S/Ull
	sZPt/uPSWTzEGDJjhOQkZKtRxcxmlR/doy2404MliFSrjrmaztNk2Uf3GORUoIcLXEUySYQFAIswh
	syiF6Leg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA5aH-0000000Dm7w-01wx;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D96703014B0; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.531091551@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:39 +0200
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
Subject: [PATCH v2 05/13] x86/kvm/emulate: Introduce COP2W
References: <20250430110734.392235199@infradead.org>
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
 	ON64(case 8: COP_ASM2(op##q, rdx, rax); break;) \
 	COP_END
 
+/* 2-operand, word only (no byte op) */
+#define COP2W(op) \
+	COP_START(op) \
+	case 1: break; \
+	case 2: COP_ASM2(op##w, ax, dx); break; \
+	case 4: COP_ASM2(op##l, eax, edx); break; \
+	ON64(case 8: COP_ASM2(op##q, rax, rdx); break;) \
+	COP_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1064,7 +1073,7 @@ FASTOP1SRC2EX(idiv, idiv_ex);
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
 
-FASTOP2W(imul);
+COP2W(imul);
 
 COP1(not);
 COP1(neg);
@@ -1079,12 +1088,12 @@ FASTOP2CL(shl);
 FASTOP2CL(shr);
 FASTOP2CL(sar);
 
-FASTOP2W(bsf);
-FASTOP2W(bsr);
-FASTOP2W(bt);
-FASTOP2W(bts);
-FASTOP2W(btr);
-FASTOP2W(btc);
+COP2W(bsf);
+COP2W(bsr);
+COP2W(bt);
+COP2W(bts);
+COP2W(btr);
+COP2W(btc);
 
 COP2R(cmp, cmp_r);
 
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



