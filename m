Return-Path: <linux-efi+bounces-4329-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305BB03C52
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE2F17D3E5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48124EA85;
	Mon, 14 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFuWY4AE"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F782475C2;
	Mon, 14 Jul 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489910; cv=none; b=b8dCiB36PUj6bZndvGC2hkY5XUMhc5go6Z00nCqubwfr5oEn0H8dSxMY3HUxbywwQ7ZauvPFsR04RTkc4beFVAlifJ1WtFRjI+qaj4O+uENTIB2psGdz/v2qXSeAeTCiT7GGuPFUdFwWDWQOWtlipSP+BiJVIBnfKlc/GJfLuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489910; c=relaxed/simple;
	bh=HTdqaT+oNcjQwtUabrIRrG0MBwoQaXbobzT0+Yi/Nqs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b1uwHc0OIo4Mufk4+5pEHRct54Fd2+svpKuDvm/ZnybhZOX+IXpBiUxixFjd1rg9sLduXC+rQ3sfbXZAhmkVjkwwpx4em3hGauaruT/+jKljnoSugC8C0Ls+yxaePF2zHiGRcFp6m/9yd+whulo4EJTun0ErGOBFGJS9iwotzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uFuWY4AE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=8jYQtoRPpor4h8Zc2IcsTcKFBlClEZNWIyaWDZfA3xw=; b=uFuWY4AEv6rVu3xZqnPvflBX5U
	wJ+lT0ed3wOgfcWv+4kUXI426E2p3ud2ayqqunahvxTeEw5C+QrRRv+G6QasIy/NKqGEOPjSBVhaf
	xKKsrOxzS0c6UaNqt6qbEx+G2Z8O/G+yDPbXJBMM5VkeKQ252k3nC/nGWlV3y1YU1Q/dKDePr543N
	dqlCs6xL5jzIKUQlkgUaqTTTX8mUSTYJfyylUYwdmz+rnVLM4TtU45EGhmlQFiXdNa1evalr7fAmr
	IczUlhqZ2Ir8ahc2+QbnUcFg5H71sKSQpAhMnaQ/nliGiwcCq9PcWXIz8WBkxvm401QUqhQwoawF/
	uXOSKrQw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000006uK4-00bn;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D20773007A0; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103439.773781574@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:13 +0200
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
Subject: [PATCH v3 02/16] x86/kvm/emulate: Introduce EM_ASM_1
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace fastops with C based stubs. There are a bunch of problems with
the current fastop infrastructure, most all related to their special
calling convention, which bypasses the normal C-ABI.

There are two immediate problems with this at present:

 - it relies on RET preserving EFLAGS; whereas C-ABI does not.

 - it circumvents compiler based control-flow-integrity checking
   because its all asm magic.

The first is a problem for some mitigations where the
x86_indirect_return_thunk needs to include non-trivial work that
clobbers EFLAGS (eg. the Skylake call depth tracking thing).

The second is a problem because it presents a 'naked' indirect call on
kCFI builds, making it a prime target for control flow hijacking.

Additionally, given that a large chunk of virtual machine performance
relies on absolutely avoiding vmexit these days, this emulation stuff
just isn't that critical for performance anymore.

As such, replace the fastop calls with normal C functions using the
'execute' member.

As noted by Paolo: this code was performance critical for pre-Westmere
(2010) and only when running big real mode code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   71 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -267,11 +267,56 @@ static void invalidate_registers(struct
 		     X86_EFLAGS_PF|X86_EFLAGS_CF)
 
 #ifdef CONFIG_X86_64
-#define ON64(x) x
+#define ON64(x...) x
 #else
-#define ON64(x)
+#define ON64(x...)
 #endif
 
+#define EM_ASM_START(op) \
+static int em_##op(struct x86_emulate_ctxt *ctxt) \
+{ \
+	unsigned long flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF; \
+	int bytes = 1, ok = 1; \
+	if (!(ctxt->d & ByteOp)) \
+		bytes = ctxt->dst.bytes; \
+	switch (bytes) {
+
+#define __EM_ASM(str) \
+		asm("push %[flags]; popf \n\t" \
+		    "10: " str \
+		    "pushf; pop %[flags] \n\t" \
+		    "11: \n\t" \
+		    : "+a" (ctxt->dst.val), \
+		      "+d" (ctxt->src.val), \
+		      [flags] "+D" (flags), \
+		      "+S" (ok) \
+		    : "c" (ctxt->src2.val))
+
+#define __EM_ASM_1(op, dst) \
+		__EM_ASM(#op " %%" #dst " \n\t")
+
+#define __EM_ASM_1_EX(op, dst) \
+		__EM_ASM(#op " %%" #dst " \n\t" \
+			 _ASM_EXTABLE_TYPE_REG(10b, 11f, EX_TYPE_ZERO_REG, %%esi))
+
+#define __EM_ASM_2(op, dst, src) \
+		__EM_ASM(#op " %%" #src ", %%" #dst " \n\t")
+
+#define EM_ASM_END \
+	} \
+	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK); \
+	return !ok ? emulate_de(ctxt) : X86EMUL_CONTINUE; \
+}
+
+/* 1-operand, using "a" (dst) */
+#define EM_ASM_1(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_1(op##b, al); break; \
+	case 2: __EM_ASM_1(op##w, ax); break; \
+	case 4: __EM_ASM_1(op##l, eax); break; \
+	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1002,10 +1047,10 @@ FASTOP3WCL(shrd);
 
 FASTOP2W(imul);
 
-FASTOP1(not);
-FASTOP1(neg);
-FASTOP1(inc);
-FASTOP1(dec);
+EM_ASM_1(not);
+EM_ASM_1(neg);
+EM_ASM_1(inc);
+EM_ASM_1(dec);
 
 FASTOP2CL(rol);
 FASTOP2CL(ror);
@@ -4021,8 +4066,8 @@ static const struct opcode group2[] = {
 static const struct opcode group3[] = {
 	F(DstMem | SrcImm | NoWrite, em_test),
 	F(DstMem | SrcImm | NoWrite, em_test),
-	F(DstMem | SrcNone | Lock, em_not),
-	F(DstMem | SrcNone | Lock, em_neg),
+	I(DstMem | SrcNone | Lock, em_not),
+	I(DstMem | SrcNone | Lock, em_neg),
 	F(DstXacc | Src2Mem, em_mul_ex),
 	F(DstXacc | Src2Mem, em_imul_ex),
 	F(DstXacc | Src2Mem, em_div_ex),
@@ -4030,14 +4075,14 @@ static const struct opcode group3[] = {
 };
 
 static const struct opcode group4[] = {
-	F(ByteOp | DstMem | SrcNone | Lock, em_inc),
-	F(ByteOp | DstMem | SrcNone | Lock, em_dec),
+	I(ByteOp | DstMem | SrcNone | Lock, em_inc),
+	I(ByteOp | DstMem | SrcNone | Lock, em_dec),
 	N, N, N, N, N, N,
 };
 
 static const struct opcode group5[] = {
-	F(DstMem | SrcNone | Lock,		em_inc),
-	F(DstMem | SrcNone | Lock,		em_dec),
+	I(DstMem | SrcNone | Lock,		em_inc),
+	I(DstMem | SrcNone | Lock,		em_dec),
 	I(SrcMem | NearBranch | IsBranch,       em_call_near_abs),
 	I(SrcMemFAddr | ImplicitOps | IsBranch, em_call_far),
 	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
@@ -4237,7 +4282,7 @@ static const struct opcode opcode_table[
 	/* 0x38 - 0x3F */
 	F6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(F(DstReg, em_inc)), X8(F(DstReg, em_dec)),
+	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */



