Return-Path: <linux-efi+bounces-3501-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B4AA49D5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46147AFF50
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775925A2D4;
	Wed, 30 Apr 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NRChl+xy"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E6246795;
	Wed, 30 Apr 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012410; cv=none; b=K4uvLOI+GDICxAS51UrBDFfPxaT+lyXS6tn7/0/923eDgHv50ixiyssCy1RrTjw1CiYGQifIGKZmwrw22PwfUS4lH8Eul1DC6gjRSl1NyyYvUFrWeNCCyVX+2iEfvK7XGm9P0BGhvLgga4XjZHN+KkYVncDpgfotOwwDN27vS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012410; c=relaxed/simple;
	bh=mg8jKvSmgfVVHoZ7hw5hkCmvXf95pqqRq6UeCwgAa34=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YbRVvgFADiLOJ/4v1LcRSPFPzelb947s2+8kLeQiTkDlHbkjYCDdBhfaAfcun3aHFo1rHehJcn3e3Ro+fHapvXqwrwi46/L/imESXhI03bKDAcBBSjMA3/Ph4dr5gGEY9H/MilbnwbLeYLRsqS9LdLG4nREpMjBfGKGTDUgEx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NRChl+xy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=a3oTVFV42BAnlcjOkQsl89vvtKHMlPa0kSRiVt7oMbc=; b=NRChl+xyv1Fb8q6cvEUds9mj+r
	XKE1uCDILG+/gdVWShdljUZ6z4/vQHLeKrkQJPptSDFFdHsc+JMtyj2mK+kbFcQfcE5NfSZ5ykNCe
	5i1B8N5S3/PhRQS5e3kNfBbTq89pyhz7AQwLZyjUNleAmlCWurTepxvEByCqAfb8p/x7VagcYeuJL
	4TOG3Cm5GMF5DewNfQiasHh6aN94LGcEQZwG2cV32yRNfo8i7xI909lgl+k7pLkSTVv+zoDL6ZRCw
	cxQUF+NbK/MoEQ/bq6zzimTrFkHUYnfP1xvmxv/khd9cd+R9nA5r8QZIM+nBWrarLN6LPoxXQu25r
	eP4/EiWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA5aH-0000000Dm7y-06eH;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E478F307FAE; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.855046292@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:42 +0200
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
Subject: [PATCH v2 08/13] x86/kvm/emulate: Introduce COP3WCL
References: <20250430110734.392235199@infradead.org>
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
 #define COP_ASM2(op, dst, src) \
 		COP_ASM(#op " %%" #src ", %%" #dst " \n\t")
 
+#define COP_ASM3(op, dst, src, src2) \
+		COP_ASM(#op " %%" #src2 ", %%" #src ", %%" #dst " \n\t")
+
 #define COP_END \
 	} \
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK); \
@@ -371,6 +374,16 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: COP_ASM2(op##q, rax, cl); break;) \
 	COP_END
 
+/* 3-operand, using "a" (dst), "d" (src) and CL (src2) */
+#define COP3WCL(op) \
+	COP_START(op) \
+	case 1: break; \
+	case 2: COP_ASM3(op##w, ax, dx, cl); break; \
+	case 4: COP_ASM3(op##l, eax, edx, cl); break; \
+	ON64(case 8: COP_ASM3(op##q, rax, rdx, cl); break;) \
+	COP_END
+
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1097,8 +1110,8 @@ COP1SRC2(imul, imul_ex);
 COP1SRC2EX(div, div_ex);
 COP1SRC2EX(idiv, idiv_ex);
 
-FASTOP3WCL(shld);
-FASTOP3WCL(shrd);
+COP3WCL(shld);
+COP3WCL(shrd);
 
 COP2W(imul);
 
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



