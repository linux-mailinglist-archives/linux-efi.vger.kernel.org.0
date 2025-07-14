Return-Path: <linux-efi+bounces-4318-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61511B03C2E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539DB3BF336
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC59246783;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SC/GCyQG"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E853246332;
	Mon, 14 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489907; cv=none; b=WS5JCpt2IMaoex0ypeFfYO5WsiNK+ZYNc08XycW53TXxgWvXePoyxnSnzqyoNOsy9tBn+7Ab+46hNzjFck6Is3T+Oke6pbyKIOjjHjKPVLhXa/ufmPH5A0AFsyosuREJxazUUgPqRQ4/99yBzk5/GmWDVA6HI/NDx5HcjhuOQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489907; c=relaxed/simple;
	bh=Lm1PsQZFxdoWNTI1Q+RNhnY7JtPtzUkiyH/xNwDExCs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dU5twFUkBys3wfmb8cfN6Lu6Bb/t49QL/QoU8BK9kKoRaUV5IwkgzOelU7dHVz6q9oUtvE1CfJ4QNuthesIcUxzNp4/Nd4OGNUw5oM8DDGLJVuKVWrL2PI38mO2TzvTuIEGK4kB9YX0IRrRbeUknbS/fiepPe5DcnjyOZPBCaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SC/GCyQG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=jotUtNQIA7oK1p4O3nX4QCvhhLgXNFqkMI8Hz+9cSMI=; b=SC/GCyQG0qK7KE5IvGLrynl9+3
	utORzdyH2kgzEngucxQgV/d99JsjzqxS4cYYtI++lcN4FjPwAVxBF8ukjS20zTIgA3K1I9EXVIO7e
	03CtxqKK+mJktahq0cpVCcfWALBFzVtaGvokkjeHfgAoRQMgDeri3dQMsCsyhK8IwDbbOl69Ef/by
	Gt21kvqNv32miMf2+0Wyl9N+OvQDtlbfrL3Hcqv+CwJQPxhBdBy3270pbWkbFVDvXJXUvILdSIk/A
	5Lu/MXqPzp8fEHgW+/q7GgmfyJ/Li1nK2zRa7Im/41upaKNWhD+G4S1Rgn1I088zgGZoW07QL23+g
	Ri84vr5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000009kch-29AW;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E2076301142; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.251039692@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:17 +0200
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
Subject: [PATCH v3 06/16] x86/kvm/emulate: Introduce EM_ASM_2CL
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP2CL instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -344,6 +344,15 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
 	EM_ASM_END
 
+/* 2-operand, using "a" (dst) and CL (src2) */
+#define EM_ASM_2CL(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_2(op##b, al, cl); break; \
+	case 2: __EM_ASM_2(op##w, ax, cl); break; \
+	case 4: __EM_ASM_2(op##l, eax, cl); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, cl); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1080,13 +1089,13 @@ EM_ASM_1(neg);
 EM_ASM_1(inc);
 EM_ASM_1(dec);
 
-FASTOP2CL(rol);
-FASTOP2CL(ror);
-FASTOP2CL(rcl);
-FASTOP2CL(rcr);
-FASTOP2CL(shl);
-FASTOP2CL(shr);
-FASTOP2CL(sar);
+EM_ASM_2CL(rol);
+EM_ASM_2CL(ror);
+EM_ASM_2CL(rcl);
+EM_ASM_2CL(rcr);
+EM_ASM_2CL(shl);
+EM_ASM_2CL(shr);
+EM_ASM_2CL(sar);
 
 EM_ASM_2W(bsf);
 EM_ASM_2W(bsr);
@@ -4079,14 +4088,14 @@ static const struct opcode group1A[] = {
 };
 
 static const struct opcode group2[] = {
-	F(DstMem | ModRM, em_rol),
-	F(DstMem | ModRM, em_ror),
-	F(DstMem | ModRM, em_rcl),
-	F(DstMem | ModRM, em_rcr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_shr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_sar),
+	I(DstMem | ModRM, em_rol),
+	I(DstMem | ModRM, em_ror),
+	I(DstMem | ModRM, em_rcl),
+	I(DstMem | ModRM, em_rcr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_shr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_sar),
 };
 
 static const struct opcode group3[] = {



