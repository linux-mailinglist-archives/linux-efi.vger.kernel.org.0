Return-Path: <linux-efi+bounces-3320-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E7A87F44
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E65F1750DC
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873B2989AE;
	Mon, 14 Apr 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dqtW97mt"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189229617A;
	Mon, 14 Apr 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630778; cv=none; b=qwuGcuS/DithplOVFrFflDi8XFg80+np3+DAn/cYZY6kFO0zwwyOnm8J16V9DqRHg+0FCCumcGeEsFp5mH6wYzq6Vc01Hw6kDmIz9Vz/xMLsEcOEk89izkrYHb3CVB7BqLKmQxB8/VQpO9J5FdeyuWNVHV+5VCYKU+mpO9haLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630778; c=relaxed/simple;
	bh=Ts6M3uwmEcf0nxVZByaZFCjJeVdYaGTB4wLygRG7khM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rpBJep/UqymQFU6SnqHHjzYwmpWXOzwSwtrw1LNC2Y90nGIFCUL32WenqWoB4M+65tuvG6G+cUQQgRel6LnHp/o315pLa38reUnWnnLnvLLj092hIo92PBy8x0uYRbO/L7esvRksuI/wLBE2maHZOhbO0oJAdt39AZ/0o1caqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dqtW97mt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=NERy+dpirG5HXq/uyAPT5n83ufEh61Nz/XhqyMRTQq8=; b=dqtW97mtT/lmt6C1tXpzMlETw/
	kos6YrHRd2KrTgLrTVZ5SPLkxhYKrjcWkWPg+FA65gI3f2+naEbc+tr2cE0eNRfxrLoOI3RjENr75
	NkqDwCajFKFMsbwUUWvSo8SdK31vNvE+evayPoZLpwcecT1zb0HnouolDsyPveD+bNd9EhiHYHZyC
	lL9RqZzkW41w621SQXZqxeGpm9FimJ4/Mif1k76tU9YYM/ku35qrMc4ZMPJ+7CZcOfVG3b7FrxfMO
	pBNUxlCreyu3dbIBOYGJxUniyBOaEx2Fw/U4ITiuh8u40hFRoRiCydZw/mrypKDVmVucL5wzB5ENP
	X1TH9zAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4I9v-00000009fKj-2kkF;
	Mon, 14 Apr 2025 11:39:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 37BC330119C; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414113754.540779611@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:46 +0200
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
Subject: [PATCH 6/6] objtool: Validate kCFI calls
References: <20250414111140.586315004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Validate that all indirect calls adhere to kCFI rules. Notably doing
nocfi indirect call to a cfi function is broken.

Apparently some Rust 'core' code violates this and explodes when ran
with FineIBT.

All the ANNOTATE_NOCFI sites are prime targets for attackers.

 - runtime EFI is especially henous because it also needs to disable
   IBT. Basically calling unknown code without CFI protection at
   runtime is a massice security issue.

 - Kexec image handover; if you can exploit this, you get to keep it :-)

 - KVM, once for the interrupt injection calling IDT gates directly.

 - KVM, once for the FASTOP emulation stuff.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/machine_kexec_64.c  |    1 
 arch/x86/kvm/emulate.c              |    4 +++
 arch/x86/kvm/vmx/vmenter.S          |    4 +++
 arch/x86/platform/efi/efi_stub_64.S |    4 +++
 drivers/misc/lkdtm/perms.c          |    2 +
 include/linux/objtool.h             |    3 ++
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   41 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    1 
 10 files changed, 62 insertions(+)

--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -442,6 +442,7 @@ void __nocfi machine_kexec(struct kimage
 
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
+ANNOTATE_NOCFI_SYM(machine_kexec);
 
 /* arch-dependent functionality related to kexec file-based syscall */
 
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5071,6 +5071,10 @@ static noinline int fastop(struct x86_em
 		return emulate_de(ctxt);
 	return X86EMUL_CONTINUE;
 }
+/*
+ * The ASM stubs don't have CFI on.
+ */
+ANNOTATE_NOCFI_SYM(fastop);
 
 void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 {
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -363,5 +363,9 @@ SYM_FUNC_END(vmread_error_trampoline)
 .section .text, "ax"
 
 SYM_FUNC_START(vmx_do_interrupt_irqoff)
+	/*
+	 * Calling an IDT gate directly.
+	 */
+	ANNOTATE_NOCFI
 	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
 SYM_FUNC_END(vmx_do_interrupt_irqoff)
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -11,6 +11,10 @@
 #include <asm/nospec-branch.h>
 
 SYM_FUNC_START(__efi_call)
+	/*
+	 * The EFI code doesn't have any CFI :-(
+	 */
+	ANNOTATE_NOCFI
 	pushq %rbp
 	movq %rsp, %rbp
 	and $~0xf, %rsp
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
 #include <linux/uaccess.h>
+#include <linux/objtool.h>
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
 
@@ -86,6 +87,7 @@ static noinline __nocfi void execute_loc
 	func();
 	pr_err("FAIL: func returned\n");
 }
+ANNOTATE_NOCFI_SYM(execute_location);
 
 static void execute_user_location(void *dst)
 {
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -185,6 +185,8 @@
  */
 #define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
 
+#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
+
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
 #define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
@@ -194,6 +196,7 @@
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
 #define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
+#define ANNOTATE_NOCFI			ANNOTATE type=ANNOTYPE_NOCFI
 #endif
 
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -66,5 +66,6 @@ struct unwind_hint {
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
 #define ANNOTYPE_JUMP_TABLE		9
+#define ANNOTYPE_NOCFI			10
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -66,5 +66,6 @@ struct unwind_hint {
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
 #define ANNOTYPE_JUMP_TABLE		9
+#define ANNOTYPE_NOCFI			10
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2387,6 +2387,8 @@ static int __annotate_ifc(struct objtool
 
 static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
+	struct symbol *sym;
+
 	switch (type) {
 	case ANNOTYPE_NOENDBR:
 		/* early */
@@ -2436,6 +2438,15 @@ static int __annotate_late(struct objtoo
 		insn->_jump_table = (void *)1;
 		break;
 
+	case ANNOTYPE_NOCFI:
+		sym = insn->sym;
+		if (!sym) {
+			WARN_INSN(insn, "dodgy NOCFI annotation");
+			break;
+		}
+		insn->sym->nocfi = 1;
+		break;
+
 	default:
 		ERROR_INSN(insn, "Unknown annotation type: %d", type);
 		return -1;
@@ -4006,6 +4017,36 @@ static int validate_retpoline(struct obj
 		warnings++;
 	}
 
+	if (!opts.cfi)
+		return warnings;
+
+	/*
+	 * kCFI call sites look like:
+	 *
+	 *     movl $(-0x12345678), %r10d
+	 *     addl -4(%r11), %r10d
+	 *     jz 1f
+	 *     ud2
+	 *  1: cs call __x86_indirect_thunk_r11
+	 *
+	 * Verify all indirect calls are kCFI adorned by checking for the
+	 * UD2. Notably, doing __nocfi calls to regular (cfi) functions is
+	 * broken.
+	 */
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+		struct symbol *sym = insn->sym;
+
+		if (sym && sym->type == STT_FUNC && !sym->nocfi) {
+			struct instruction *prev =
+				prev_insn_same_sym(file, insn);
+
+			if (!prev || prev->type != INSN_BUG) {
+				WARN_INSN(insn, "no-cfi indirect call!");
+				warnings++;
+			}
+		}
+	}
+
 	return warnings;
 }
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -70,6 +70,7 @@ struct symbol {
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
+	u8 nocfi             : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };



