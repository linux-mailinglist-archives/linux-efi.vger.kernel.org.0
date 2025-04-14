Return-Path: <linux-efi+bounces-3322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29486A87F4B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3C33B7921
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98429C33A;
	Mon, 14 Apr 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5G/BKsd"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445D293B4D;
	Mon, 14 Apr 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630780; cv=none; b=eCWM5mYiKgBrMbsEDPpsQclrwl56hjOOJRwIjIYQzrbMyljLaXoGW6hxkSrIQSsmD1u2UybcoSLrncLmk4yGRmDF2JNDaXGX83O2We4kIELDCe6DxXLNZAwYXS1tYmEwZxsjd2twgec38xNdvp8ZV0fOFb25mSqpz1R7sp4lURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630780; c=relaxed/simple;
	bh=p/Y84bBNhhNyI/fMooDzHs4hcoxAN/Gk2IldqfwkQH8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tJSctaguiLOg+tqYTfG+Dwm5ZnGEVK0sHI0tBnRxahHco0DZBcseeIRdMUG7VQ27gcmp60NwkhUUrP7uWKSr4WzPcrH9Va2N/T5ow4fn1J3Eq8WNUEu7NjU6V1anEW9eFngHR7APkinXvEw84FuG96fEx+b3L2wSH7zRH5Jt11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n5G/BKsd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=giIf0y3F3Tm6yHGVfgBN4P6bvuQNR4i30PNgCAncNzs=; b=n5G/BKsdfWJ9WLNUxR/0EOZLse
	mqFKJGkT8oRE8p98iK99m5eCN3hBmjWy5Aj49NqMoXx4Qs8jT+gWeIdSIhxkHqUZCbE/+OEvAHOkc
	SQliEqqKrPVeO8XoQFHdFqp7bp+vcxVWCiWrQWAVghFB9NwKz67/T2bFdwCK+zgX5fYEj+FJSse2Y
	NRnYbjP03jiT3LVnLQ6Q6MymyGreLpSyh7oTlrJIbZmgIo9Ce5m5mtuN68GQnoWeazyhAi9JzNpK5
	zrBhcgkNo4imSv/0TQw+pNWUW5L33KmTb8eh8UpYujRMsulM+t9TJeIsI2tzYHPHEmG0W8iKLpM2d
	zjr1/w8g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I9u-000000084Gr-0oXW;
	Mon, 14 Apr 2025 11:39:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2DD5D300B40; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414113754.172767741@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:43 +0200
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
Subject: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
References: <20250414111140.586315004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since there is only a single fastop() function, convert the FASTOP
stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
thunks and all that jazz.

Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
which not all of them can trivially do (call depth tracing suffers
here).

Objtool strenuously complains about things, therefore fix up the
various problems:

 - indirect call without a .rodata, fails to determine JUMP_TABLE,
   add an annotation for this.
 - fastop functions fall through, create an exception for this case
 - unreachable instruction after fastop_return, save/restore

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c              |   20 +++++++++++++++-----
 include/linux/objtool_types.h       |    1 +
 tools/include/linux/objtool_types.h |    1 +
 tools/objtool/check.c               |   11 ++++++++++-
 4 files changed, 27 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -285,8 +285,8 @@ static void invalidate_registers(struct
  * different operand sizes can be reached by calculation, rather than a jump
  * table (which would be bigger than the code).
  *
- * The 16 byte alignment, considering 5 bytes for the RET thunk, 3 for ENDBR
- * and 1 for the straight line speculation INT3, leaves 7 bytes for the
+ * The 16 byte alignment, considering 5 bytes for the JMP, 4 for ENDBR
+ * and 1 for the straight line speculation INT3, leaves 6 bytes for the
  * body of the function.  Currently none is larger than 4.
  */
 static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
@@ -304,7 +304,7 @@ static int fastop(struct x86_emulate_ctx
 	__FOP_FUNC(#name)
 
 #define __FOP_RET(name) \
-	"11: " ASM_RET \
+	"11: jmp fastop_return; int3 \n\t" \
 	".size " name ", .-" name "\n\t"
 
 #define FOP_RET(name) \
@@ -5044,14 +5044,24 @@ static void fetch_possible_mmx_operand(s
 		kvm_read_mmx_reg(op->addr.mm, &op->mm_val);
 }
 
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
+/*
+ * All the FASTOP magic above relies on there being *one* instance of this
+ * so it can JMP back, avoiding RET and it's various thunks.
+ */
+static noinline int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 {
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf \n\t"
+	    UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+	    ASM_ANNOTATE(ANNOTYPE_JUMP_TABLE)
+	    JMP_NOSPEC
+	    "fastop_return: \n\t"
+	    UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+	    "pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
 	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_JUMP_TABLE		9
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_JUMP_TABLE		9
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2428,6 +2428,14 @@ static int __annotate_late(struct objtoo
 		insn->dead_end = false;
 		break;
 
+	/*
+	 * Must be after add_jump_table(); for it doesn't set a sane
+	 * _jump_table value.
+	 */
+	case ANNOTYPE_JUMP_TABLE:
+		insn->_jump_table = (void *)1;
+		break;
+
 	default:
 		ERROR_INSN(insn, "Unknown annotation type: %d", type);
 		return -1;
@@ -3559,7 +3567,8 @@ static int validate_branch(struct objtoo
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strcmp(insn_func(insn)->name, "fastop"))
 				return 0;
 
 			if (file->ignore_unreachables)



