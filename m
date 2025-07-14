Return-Path: <linux-efi+bounces-4328-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E9B03C4A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DB07AE176
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A724C07F;
	Mon, 14 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKNMgt0N"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4E23B63C;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489910; cv=none; b=L/2NHtUp3YPemxZw9Gr33wtutcId2g+eVs0KEp0BDKjIwQXCPqqtBa2YFFsIh4qeADWmzfZuIj0KfS1RYAgXZDqoNu5Mw/tGB7M0W/FT5Hf7qxZ5k6rs5fq2r5HbHc3GjrX33qE9vDhkgwp8zmMTKJgpV5gOKNKwWM+OUEMz7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489910; c=relaxed/simple;
	bh=H5YBZf0fNnVsYlv27L5Q/Ob03FWPbKXTKA4uMtscfig=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=avwtI4SnIo4UrGGX/a2BwC+adhhocfEyFnunE9zk0s2MinV1bQpa2fqodlSnpfZjCHYXCQ2+aCw3OOCaPuSbfZf5OrX8YGvh6ju6iPIHFqYSVCBADfL+xaG4yJ+fSuFN9nhHyx/inbV1M9P9hdPMVHr71EireJLFqPM+fgdiEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JKNMgt0N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=eNidn6T/kDeqMRXxeY6Z3Dw7McLh++ZG+chmKF2+4y4=; b=JKNMgt0Nzkt7+k2O9fjju3DVYL
	Rl4HloztCaLyxT2XugEncc9CSUmPd2MsGNwHSWXVuIbmelVcGC0v/ML0UPvF9TXqBPMoymdyO5GxF
	1RuoWckKCHXPL2W84AiPHCybiaOTv3a3HPt4qgjLg866Z6NIQzyNEoWBFULqLyyaRxStYZRdFBMIT
	w99I+X1Uw+XI+hw44KI0jWQiSKfG6CezLKtclNVprvDC1zj6wcAaNSHB3ccU6pQ6akEmX1mloHcKJ
	uyesqNzU70O5DFHj2YFy/rThy9RuBg7MFF7eoh6DNcgnLPxH4FioyW9BGOwgflTCWDxQN282K3iuA
	yPrxUEsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000006uKY-21wd;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EA0F9302D42; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.513865075@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:19 +0200
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
Subject: [PATCH v3 08/16] x86/kvm/emulate: Introduce EM_ASM_3WCL
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP3WCL instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -302,6 +302,9 @@ static int em_##op(struct x86_emulate_ct
 #define __EM_ASM_2(op, dst, src) \
 		__EM_ASM(#op " %%" #src ", %%" #dst " \n\t")
 
+#define __EM_ASM_3(op, dst, src, src2) \
+		__EM_ASM(#op " %%" #src2 ", %%" #src ", %%" #dst " \n\t")
+
 #define EM_ASM_END \
 	} \
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK); \
@@ -371,6 +374,16 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_2(op##q, rax, cl); break;) \
 	EM_ASM_END
 
+/* 3-operand, using "a" (dst), "d" (src) and CL (src2) */
+#define EM_ASM_3WCL(op) \
+	EM_ASM_START(op) \
+	case 1: break; \
+	case 2: __EM_ASM_3(op##w, ax, dx, cl); break; \
+	case 4: __EM_ASM_3(op##l, eax, edx, cl); break; \
+	ON64(case 8: __EM_ASM_3(op##q, rax, rdx, cl); break;) \
+	EM_ASM_END
+
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1097,8 +1110,8 @@ EM_ASM_1SRC2(imul, imul_ex);
 EM_ASM_1SRC2EX(div, div_ex);
 EM_ASM_1SRC2EX(idiv, idiv_ex);
 
-FASTOP3WCL(shld);
-FASTOP3WCL(shrd);
+EM_ASM_3WCL(shld);
+EM_ASM_3WCL(shrd);
 
 EM_ASM_2W(imul);
 
@@ -4496,14 +4509,14 @@ static const struct opcode twobyte_table
 	I(Stack | Src2FS, em_push_sreg), I(Stack | Src2FS, em_pop_sreg),
 	II(ImplicitOps, em_cpuid, cpuid),
 	I(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
-	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
-	F(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
+	I(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
+	I(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
 	/* 0xA8 - 0xAF */
 	I(Stack | Src2GS, em_push_sreg), I(Stack | Src2GS, em_pop_sreg),
 	II(EmulateOnUD | ImplicitOps, em_rsm, rsm),
 	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
-	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
-	F(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
+	I(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
+	I(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
 	GD(0, &group15), I(DstReg | SrcMem | ModRM, em_imul),
 	/* 0xB0 - 0xB7 */
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable | SrcWrite, em_cmpxchg),



