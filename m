Return-Path: <linux-efi+bounces-3520-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF1AA60D3
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DE41BA6FBF
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D21F1931;
	Thu,  1 May 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipiUoQjm"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A551F4C90;
	Thu,  1 May 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113941; cv=none; b=jobyw1auyOyTTBlqgUaSXlF5Wgf6apz5X8T0OGk3wOv/XLAwOP2CHd372IevbIY/v7TxbSUco3bgdF1KkFlHGf9H3XlVMfc/2HuifuDPYTPZEd+e013cSD98aKeK/boBYHdEqJEdAuE7pmdX6EvjPOzQRw43R7NMMCN4GiVKjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113941; c=relaxed/simple;
	bh=jtxtzWzUX3o7smTUWXZXgZlzi7dIw9hzz2Nn9mrHZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRbJ62QGmIEOmOW9caaHEBgefGvlj0ownOWrZC+f0GV4t5YozTmVmfOVdPN1ReBFBSwGHFjmI8dcFEV2Qe4s7EkjzjKtYjtyhVTfSN9nQHd67hpAVE8taoh2wUpuiiwrG9Difkt0dmh1z9UWV4SvlaT/50PweNvP2yuebozyDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipiUoQjm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pQl9bEGa+lYvio1NIdbmBUDuKaBoP1PLCxNPchDxt7c=; b=ipiUoQjmFOgPwWZjO/5f5ZR571
	FlWcAXQYNxBywFbFKk5ONwhCvzZF6tT3oNepsjAERr4EwYUb3K9mADfCZCyf4YTotjQXID3SVkw/d
	KP9WO+wo8m8L4TdRTqWPoPCnmw2XemlI/PyGH/sw9r30keQSlRGgBJk6oq9QyZucyuSReGYK2Vakv
	ZXsJeeDR9ZC8SqjT6U63g5fyzY84X1eSOyaWWm4zQEIB3t7eaHuj8n/q2ixltCu9JMoBV42u85lQd
	fl9PpMyuX5hnJZm0US+qcoohUVJCte2WI1scRbOuUq801R5wQigyG1Ak1fCXeyUhxQEfaBcQ/RqsO
	sNRw6m6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAVzo-00000000tv0-3P68;
	Thu, 01 May 2025 15:38:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3366B300642; Thu,  1 May 2025 17:38:44 +0200 (CEST)
Date: Thu, 1 May 2025 17:38:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250501153844.GD4356@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501103038.GB4356@noisy.programming.kicks-ass.net>

On Thu, May 01, 2025 at 12:30:38PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 30, 2025 at 09:06:00PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 30, 2025 at 07:24:15AM -0700, H. Peter Anvin wrote:
> > 
> > > >KVM has another; the VMX interrupt injection stuff calls the IDT handler
> > > >directly.  Is there an alternative? Can we keep a table of Linux functions
> > > >slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
> > 
> > > We do have a table of handlers higher up in the stack in the form of
> > > the dispatch tables for FRED. They don't in general even need the
> > > assembly entry stubs, either.
> > 
> > Oh, right. I'll go have a look at those.
> 
> Right, so perhaps the easiest way around this is to setup the FRED entry
> tables unconditionally, have VMX mandate CONFIG_FRED and then have it
> always use the FRED entry points.
> 
> Let me see how ugly that gets.

Something like so... except this is broken. Its reporting spurious
interrupts on vector 0x00, so something is buggered passing that vector
along.

I'll stare more at it more another time.

---

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..d2322e3723f5 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -156,9 +156,8 @@ void __init fred_complete_exception_setup(void)
 	fred_setup_done = true;
 }
 
-static noinstr void fred_extint(struct pt_regs *regs)
+noinstr void fred_extint(struct pt_regs *regs, unsigned int vector)
 {
-	unsigned int vector = regs->fred_ss.vector;
 	unsigned int index = array_index_nospec(vector - FIRST_SYSTEM_VECTOR,
 						NR_SYSTEM_VECTORS);
 
@@ -230,7 +229,7 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
 
 	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_EXTINT:
-		return fred_extint(regs);
+		return fred_extint(regs, regs->fred_ss.vector);
 	case EVENT_TYPE_NMI:
 		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
 			return fred_exc_nmi(regs);
@@ -262,7 +261,7 @@ __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
 
 	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_EXTINT:
-		return fred_extint(regs);
+		return fred_extint(regs, regs->fred_ss.vector);
 	case EVENT_TYPE_NMI:
 		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
 			return fred_exc_nmi(regs);
@@ -286,7 +285,7 @@ __visible noinstr void __fred_entry_from_kvm(struct pt_regs *regs)
 {
 	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_EXTINT:
-		return fred_extint(regs);
+		return fred_extint(regs, regs->fred_ss.vector);
 	case EVENT_TYPE_NMI:
 		return fred_exc_nmi(regs);
 	default:
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2a29e5216881..e6ec5e1a0f54 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -66,6 +66,8 @@ void asm_fred_entrypoint_user(void);
 void asm_fred_entrypoint_kernel(void);
 void asm_fred_entry_from_kvm(struct fred_ss);
 
+void fred_extint(struct pt_regs *regs, unsigned int vector);
+
 __visible void fred_entry_from_user(struct pt_regs *regs);
 __visible void fred_entry_from_kernel(struct pt_regs *regs);
 __visible void __fred_entry_from_kvm(struct pt_regs *regs);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a4ec27c67988..1de8c8b6d4c6 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -468,9 +468,9 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 #endif
 
 #define sysvec_install(vector, function) {				\
-	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+	if (IS_ENABLED(CONFIG_X86_FRED))				\
 		fred_install_sysvec(vector, function);			\
-	else								\
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))			\
 		idt_install_sysvec(vector, asm_##function);		\
 }
 
@@ -647,6 +647,9 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	xenpv_exc_machine_check);
  * to avoid more ifdeffery.
  */
 DECLARE_IDTENTRY(X86_TRAP_NMI,		exc_nmi_kvm_vmx);
+#ifdef CONFIG_X86_FRED
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NMI, exc_fred_kvm_vmx);
+#endif
 #endif
 
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index f79c5edc0b89..654f8e835417 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -97,9 +97,9 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_complete_exception_setup();
-	else
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_setup_apic_and_irq_gates();
 
 	lapic_assign_system_vectors();
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 9a95d00f1423..4690787bdd13 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -613,8 +613,17 @@ DEFINE_IDTENTRY_RAW(exc_nmi_kvm_vmx)
 {
 	exc_nmi(regs);
 }
+#ifdef CONFIG_X86_FRED
+DEFINE_IDTENTRY_RAW_ERRORCODE(exc_fred_kvm_vmx)
+{
+	fred_extint(regs, error_code);
+}
+#endif
 #if IS_MODULE(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(asm_exc_nmi_kvm_vmx);
+#ifdef CONFIG_X86_FRED
+EXPORT_SYMBOL_GPL(asm_exc_fred_kvm_vmx);
+#endif
 #endif
 #endif
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fe8ea8c097de..9db38ae3450e 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -95,6 +95,7 @@ config KVM_SW_PROTECTED_VM
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
+	select X86_FRED if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 090393bf829d..3aaacbbedf5c 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -31,7 +31,7 @@
 #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
 #endif
 
-.macro VMX_DO_EVENT_IRQOFF call_insn call_target
+.macro VMX_DO_EVENT_IRQOFF call_insn call_target has_error=0
 	/*
 	 * Unconditionally create a stack frame, getting the correct RSP on the
 	 * stack (for x86-64) would take two instructions anyways, and RBP can
@@ -40,6 +40,8 @@
 	push %_ASM_BP
 	mov %_ASM_SP, %_ASM_BP
 
+	UNWIND_HINT_SAVE
+
 #ifdef CONFIG_X86_64
 	/*
 	 * Align RSP to a 16-byte boundary (to emulate CPU behavior) before
@@ -51,7 +53,17 @@
 #endif
 	pushf
 	push $__KERNEL_CS
+
+	.if \has_error
+	lea 1f(%rip), %rax
+	push %rax
+	UNWIND_HINT_IRET_REGS
+	push %_ASM_ARG1
+	.endif
+
 	\call_insn \call_target
+1:
+	UNWIND_HINT_RESTORE
 
 	/*
 	 * "Restore" RSP from RBP, even though IRET has already unwound RSP to
@@ -363,10 +375,9 @@ SYM_FUNC_END(vmread_error_trampoline)
 .section .text, "ax"
 
 SYM_FUNC_START(vmx_do_interrupt_irqoff)
-	/*
-	 * Calling an IDT gate directly; annotate away the CFI concern for now.
-	 * Should be fixed if possible.
-	 */
-	ANNOTATE_NOCFI_SYM
+#ifdef CONFIG_X86_FRED
+	VMX_DO_EVENT_IRQOFF jmp asm_exc_fred_kvm_vmx has_error=1
+#else
 	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
+#endif
 SYM_FUNC_END(vmx_do_interrupt_irqoff)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c5766467a61..7ccd2f66d55d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7034,6 +7034,7 @@ void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu)
 }
 
 void vmx_do_interrupt_irqoff(unsigned long entry);
+
 void vmx_do_nmi_irqoff(void);
 
 static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
@@ -7080,6 +7081,8 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
 	if (cpu_feature_enabled(X86_FEATURE_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+	else if (IS_ENABLED(CONFIG_FRED))
+		vmx_do_interrupt_irqoff(vector);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
 	kvm_after_interrupt(vcpu);

