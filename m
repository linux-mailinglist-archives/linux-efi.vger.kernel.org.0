Return-Path: <linux-efi+bounces-4325-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD6B03C4C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CE3A85CE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B924A046;
	Mon, 14 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GTOfVI5d"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE5239570;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489909; cv=none; b=mlUlLOFesZbuZZV3f3vpCQ+2lFkuoUNavnKYS2nAD6LmiC1lEamfMOjIZrRj1CB3IntScnK8XCHzvfczzqQaw6afVpFety+DJGzQDnomw5Iq8iKDdz6k+O+YeJNiBeNsH3AzvM+cGgBiHmhbbwMS6mWeVE00+TM35fL+76RyG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489909; c=relaxed/simple;
	bh=aGkfmjELao9k1FgDXHVaajQR1EjDMMt8/GCiX0e70PI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kyYYSIvHnXp8ChZ9UT2qIW0MZpNrCm5w1pOdKlT5+54c88AFPro3/loyrvsjil/q2OVMTwNjrzSRv+PeGy3v2nvXv/dTInC9plM3VNuUG1h9ATcqpuyXCjg3gfeCxdhYWbpswwZuKvrJA+LHvCyW+n0SGIRaiJnVGrqd3OvqmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GTOfVI5d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=upWx64KkvtXvdkAHnKQ/kaQ2aUrWbLJGP5mR8fF7cdE=; b=GTOfVI5d/iVG/JrjZfks4uWkvv
	RZZ0SSg67o9t+w5RK0X08J58TaplwoKmdpklKLcbOYjhKxYDU/MRQbXC/CIvPYDwcNo7wAAoLa8gM
	KNtaLuU17i9pCrLyK6Vic9Qw92H9fMv8saUVsDtnpWQxuBPv4vyBTb8D0vSIJXRb8XBoStGx+sq2t
	QBYSo+e7Qaumoo+YAGYWsFyRLo19Y/I6UZP8Dh4ai1U8f+vFYXMqYNIrhlpooPth7fdV4+4y1YFoX
	oXyDWSFMClBQlEiOvve0FjqzQDltQG6xfoaTKgHS0I/OsP3BF21yIMNlKFxLvVpEl4+3ZNp70qqHO
	IvsTIcww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000009kcr-15I1;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 330EA302E2E; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103441.496787279@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:27 +0200
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
Subject: [PATCH v3 16/16] objtool: Validate kCFI calls
References: <20250714102011.758008629@infradead.org>
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

All the ANNOTATE_NOCFI_SYM sites are prime targets for attackers.

 - runtime EFI is especially henous because it also needs to disable
   IBT. Basically calling unknown code without CFI protection at
   runtime is a massice security issue.

 - Kexec image handover; if you can exploit this, you get to keep it :-)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/machine_kexec_64.c  |    4 +++
 arch/x86/kvm/vmx/vmenter.S          |    4 +++
 arch/x86/platform/efi/efi_stub_64.S |    4 +++
 drivers/misc/lkdtm/perms.c          |    5 ++++
 include/linux/objtool.h             |   10 ++++++++
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   42 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    1 
 9 files changed, 72 insertions(+)

--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -453,6 +453,10 @@ void __nocfi machine_kexec(struct kimage
 
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
+/*
+ * Handover to the next kernel, no CFI concern.
+ */
+ANNOTATE_NOCFI_SYM(machine_kexec);
 
 /* arch-dependent functionality related to kexec file-based syscall */
 
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
 
 .section .text, "ax"
 
+#ifndef CONFIG_X86_FRED
+
 SYM_FUNC_START(vmx_do_interrupt_irqoff)
 	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
 SYM_FUNC_END(vmx_do_interrupt_irqoff)
+
+#endif
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -11,6 +11,10 @@
 #include <asm/nospec-branch.h>
 
 SYM_FUNC_START(__efi_call)
+	/*
+	 * The EFI code doesn't have any CFI, annotate away the CFI violation.
+	 */
+	ANNOTATE_NOCFI_SYM
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
 
@@ -86,6 +87,10 @@ static noinline __nocfi void execute_loc
 	func();
 	pr_err("FAIL: func returned\n");
 }
+/*
+ * Explicitly doing the wrong thing for testing.
+ */
+ANNOTATE_NOCFI_SYM(execute_location);
 
 static void execute_user_location(void *dst)
 {
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -184,6 +184,15 @@
  * WARN using UD2.
  */
 #define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
+/*
+ * This should not be used; it annotates away CFI violations. There are a few
+ * valid use cases like kexec handover to the next kernel image, and there is
+ * no security concern there.
+ *
+ * There are also a few real issues annotated away, like EFI because we can't
+ * control the EFI code.
+ */
+#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
 
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
@@ -194,6 +203,7 @@
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
 #define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
+#define ANNOTATE_NOCFI_SYM		ANNOTATE type=ANNOTYPE_NOCFI
 #endif
 
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_NOCFI			9
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_NOCFI			9
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2390,6 +2390,8 @@ static int __annotate_ifc(struct objtool
 
 static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
+	struct symbol *sym;
+
 	switch (type) {
 	case ANNOTYPE_NOENDBR:
 		/* early */
@@ -2431,6 +2433,15 @@ static int __annotate_late(struct objtoo
 		insn->dead_end = false;
 		break;
 
+	case ANNOTYPE_NOCFI:
+		sym = insn->sym;
+		if (!sym) {
+			ERROR_INSN(insn, "dodgy NOCFI annotation");
+			return -1;
+		}
+		insn->sym->nocfi = 1;
+		break;
+
 	default:
 		ERROR_INSN(insn, "Unknown annotation type: %d", type);
 		return -1;
@@ -4000,6 +4011,37 @@ static int validate_retpoline(struct obj
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
+		if (sym && (sym->type == STT_NOTYPE ||
+			    sym->type == STT_FUNC) && !sym->nocfi) {
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
 	struct section *group_sec;



