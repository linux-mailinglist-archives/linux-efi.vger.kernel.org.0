Return-Path: <linux-efi+bounces-4321-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35EB03C35
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45B87ADE95
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F4248869;
	Mon, 14 Jul 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVp/quoR"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BE149C51;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489908; cv=none; b=A8EcVpv4xFPSAPFXngICV3jqWVsF54enemcnQ8hRi3fGVMlJBntWSLp7TRc0RNOgaxFkLYAoppv5bZh4c9HgHLqzGWY8MPIxdW+DhNTFUXx3TG0zAEJy5ximTwBqHX/unbopGWsT8EhZpj68C9MtJLW41tIjXYdNenHrYqRtQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489908; c=relaxed/simple;
	bh=nOn0fX75ysPhTk8MlfTUlzFn+Ml7ySHuCtwKNQhCjKc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tLmOBBmaUJSMZA3jcBd3rWtT+lORSqBnjL0yle/7deqs8ZlYHCnZA3OQMcIdFM1Q29K2fc3wdMXeAKh7uupwlh9MvIncoLwVsuxA8a0qyC+stLlISAtaR4X1Q1ImCy43fcI6kWFQk07okYWeUv0fPMVLQEZ5MwJ9NlmknL8lwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QVp/quoR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=WEU+51TOfKmqbdqEWlsR9cikZMb6arGOO4YuD2naPts=; b=QVp/quoRgC71xk9rOmHRYf6Men
	hNU7YR+HBaU6PX68bohJ4aSazBnmfGyHGSLXfJmOaxpvXqn7hiCE0LSJE3UqBdGwe4ZTOCOHs8nza
	1TjCalZSW+T88HuIMTVzaS+5INRf0MlP46nUACUsBupKnLHwJiCOC8ZGOK0AmZZGUQfSVvuuUR4rc
	XU2Bm9b1BDCQxpbzKT1gspMoCGWStEwrUn9a000b4P6KVJWXDas2AUQ4Pgw8KwiwrSrcR4Di0sUMY
	NkeH/l6fA1O60rXAvklY4zvL19f1X0FilnziXVQKhjm1RvlSvanSHS0GY/6yKMShsOERB7XtspLuM
	vNKDuSCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000009kcl-0ksX;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F20BB302D64; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.751192860@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:21 +0200
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
Subject: [PATCH v3 10/16] x86/kvm/emulate: Remove fastops
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

No more FASTOPs, remove the remains.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |  172 -------------------------------------------------
 1 file changed, 1 insertion(+), 171 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -167,7 +167,6 @@
 #define Unaligned   ((u64)2 << 41)  /* Explicitly unaligned (e.g. MOVDQU) */
 #define Avx         ((u64)3 << 41)  /* Advanced Vector Extensions */
 #define Aligned16   ((u64)4 << 41)  /* Aligned to 16 byte boundary (e.g. FXSAVE) */
-#define Fastop      ((u64)1 << 44)  /* Use opcode::u.fastop */
 #define NoWrite     ((u64)1 << 45)  /* No writeback */
 #define SrcWrite    ((u64)1 << 46)  /* Write back src operand */
 #define NoMod	    ((u64)1 << 47)  /* Mod field is ignored */
@@ -203,7 +202,6 @@ struct opcode {
 		const struct escape *esc;
 		const struct instr_dual *idual;
 		const struct mode_dual *mdual;
-		void (*fastop)(struct fastop *fake);
 	} u;
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 };
@@ -383,152 +381,6 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_3(op##q, rax, rdx, cl); break;) \
 	EM_ASM_END
 
-
-/*
- * fastop functions have a special calling convention:
- *
- * dst:    rax        (in/out)
- * src:    rdx        (in/out)
- * src2:   rcx        (in)
- * flags:  rflags     (in/out)
- * ex:     rsi        (in:fastop pointer, out:zero if exception)
- *
- * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
- * different operand sizes can be reached by calculation, rather than a jump
- * table (which would be bigger than the code).
- *
- * The 16 byte alignment, considering 5 bytes for the RET thunk, 3 for ENDBR
- * and 1 for the straight line speculation INT3, leaves 7 bytes for the
- * body of the function.  Currently none is larger than 4.
- */
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
-
-#define FASTOP_SIZE	16
-
-#define __FOP_FUNC(name) \
-	".align " __stringify(FASTOP_SIZE) " \n\t" \
-	".type " name ", @function \n\t" \
-	name ":\n\t" \
-	ASM_ENDBR \
-	IBT_NOSEAL(name)
-
-#define FOP_FUNC(name) \
-	__FOP_FUNC(#name)
-
-#define __FOP_RET(name) \
-	"11: " ASM_RET \
-	".size " name ", .-" name "\n\t"
-
-#define FOP_RET(name) \
-	__FOP_RET(#name)
-
-#define __FOP_START(op, align) \
-	extern void em_##op(struct fastop *fake); \
-	asm(".pushsection .text, \"ax\" \n\t" \
-	    ".global em_" #op " \n\t" \
-	    ".align " __stringify(align) " \n\t" \
-	    "em_" #op ":\n\t"
-
-#define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
-
-#define FOP_END \
-	    ".popsection")
-
-#define __FOPNOP(name) \
-	__FOP_FUNC(name) \
-	__FOP_RET(name)
-
-#define FOPNOP() \
-	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
-
-#define FOP1E(op,  dst) \
-	__FOP_FUNC(#op "_" #dst) \
-	"10: " #op " %" #dst " \n\t" \
-	__FOP_RET(#op "_" #dst)
-
-#define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %%esi)
-
-#define FASTOP1(op) \
-	FOP_START(op) \
-	FOP1E(op##b, al) \
-	FOP1E(op##w, ax) \
-	FOP1E(op##l, eax) \
-	ON64(FOP1E(op##q, rax))	\
-	FOP_END
-
-/* 1-operand, using src2 (for MUL/DIV r/m) */
-#define FASTOP1SRC2(op, name) \
-	FOP_START(name) \
-	FOP1E(op, cl) \
-	FOP1E(op, cx) \
-	FOP1E(op, ecx) \
-	ON64(FOP1E(op, rcx)) \
-	FOP_END
-
-/* 1-operand, using src2 (for MUL/DIV r/m), with exceptions */
-#define FASTOP1SRC2EX(op, name) \
-	FOP_START(name) \
-	FOP1EEX(op, cl) \
-	FOP1EEX(op, cx) \
-	FOP1EEX(op, ecx) \
-	ON64(FOP1EEX(op, rcx)) \
-	FOP_END
-
-#define FOP2E(op,  dst, src)	   \
-	__FOP_FUNC(#op "_" #dst "_" #src) \
-	#op " %" #src ", %" #dst " \n\t" \
-	__FOP_RET(#op "_" #dst "_" #src)
-
-#define FASTOP2(op) \
-	FOP_START(op) \
-	FOP2E(op##b, al, dl) \
-	FOP2E(op##w, ax, dx) \
-	FOP2E(op##l, eax, edx) \
-	ON64(FOP2E(op##q, rax, rdx)) \
-	FOP_END
-
-/* 2 operand, word only */
-#define FASTOP2W(op) \
-	FOP_START(op) \
-	FOPNOP() \
-	FOP2E(op##w, ax, dx) \
-	FOP2E(op##l, eax, edx) \
-	ON64(FOP2E(op##q, rax, rdx)) \
-	FOP_END
-
-/* 2 operand, src is CL */
-#define FASTOP2CL(op) \
-	FOP_START(op) \
-	FOP2E(op##b, al, cl) \
-	FOP2E(op##w, ax, cl) \
-	FOP2E(op##l, eax, cl) \
-	ON64(FOP2E(op##q, rax, cl)) \
-	FOP_END
-
-/* 2 operand, src and dest are reversed */
-#define FASTOP2R(op, name) \
-	FOP_START(name) \
-	FOP2E(op##b, dl, al) \
-	FOP2E(op##w, dx, ax) \
-	FOP2E(op##l, edx, eax) \
-	ON64(FOP2E(op##q, rdx, rax)) \
-	FOP_END
-
-#define FOP3E(op,  dst, src, src2) \
-	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
-	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
-	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
-
-/* 3-operand, word-only, src2=cl */
-#define FASTOP3WCL(op) \
-	FOP_START(op) \
-	FOPNOP() \
-	FOP3E(op##w, ax, dx, cl) \
-	FOP3E(op##l, eax, edx, cl) \
-	ON64(FOP3E(op##q, rax, rdx, cl)) \
-	FOP_END
-
 static int em_salc(struct x86_emulate_ctxt *ctxt)
 {
 	/*
@@ -4052,7 +3904,6 @@ static int check_perm_out(struct x86_emu
 #define MD(_f, _m) { .flags = ((_f) | ModeDual), .u.mdual = (_m) }
 #define E(_f, _e) { .flags = ((_f) | Escape | ModRM), .u.esc = (_e) }
 #define I(_f, _e) { .flags = (_f), .u.execute = (_e) }
-#define F(_f, _e) { .flags = (_f) | Fastop, .u.fastop = (_e) }
 #define II(_f, _e, _i) \
 	{ .flags = (_f)|Intercept, .u.execute = (_e), .intercept = x86_intercept_##_i }
 #define IIP(_f, _e, _i, _p) \
@@ -5158,24 +5009,6 @@ static void fetch_possible_mmx_operand(s
 		kvm_read_mmx_reg(op->addr.mm, &op->mm_val);
 }
 
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
-{
-	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
-
-	if (!(ctxt->d & ByteOp))
-		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
-
-	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
-	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
-	    : "c"(ctxt->src2.val));
-
-	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
-	if (!fop) /* exception is returned in fop variable */
-		return emulate_de(ctxt);
-	return X86EMUL_CONTINUE;
-}
-
 void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 {
 	/* Clear fields that are set conditionally but read without a guard. */
@@ -5340,10 +5173,7 @@ int x86_emulate_insn(struct x86_emulate_
 		ctxt->eflags &= ~X86_EFLAGS_RF;
 
 	if (ctxt->execute) {
-		if (ctxt->d & Fastop)
-			rc = fastop(ctxt, ctxt->fop);
-		else
-			rc = ctxt->execute(ctxt);
+		rc = ctxt->execute(ctxt);
 		if (rc != X86EMUL_CONTINUE)
 			goto done;
 		goto writeback;



