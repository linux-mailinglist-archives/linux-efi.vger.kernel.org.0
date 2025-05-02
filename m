Return-Path: <linux-efi+bounces-3544-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB878AA7A6A
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5610E1C00698
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C53A1F2B8E;
	Fri,  2 May 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfmxOTB7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EA1EB189
	for <linux-efi@vger.kernel.org>; Fri,  2 May 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215620; cv=none; b=jp83keiv2j0rDDxo9kWBDbCKX0+m83Hbh8ceoVzpdVlRl6z0twqghTQ7bs1bCWIDIuIwqKGmYK97qFLWzHbZRczsbvk3QU+ca3JK7f5i/tqnjXsaUrc+vISxjpxbxA8rlQYyRuEl/byRkUuJYXCpY7CxCkv8oX6sON8/ehxf+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215620; c=relaxed/simple;
	bh=pNLofVHa/xZypRTnit0/KCNmtvKYZMxd9/3LLgH8w1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4NgO7wi1W/x+/GN9fnM96/9vbZvwKjxWlHdiWcJWZTtp8u+ow8MzvIU7XHv3Xg+nbOARWoQ3GRXz7lNQ+rLEggyN4g40KG3ZcOpdLp1YI3GAqs3E9ib89nIBsndkPr9jjHTh6iodMkPQV2K8C/OWRQAoYkdq/TZHDDTnntYzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfmxOTB7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3082946f829so3513411a91.0
        for <linux-efi@vger.kernel.org>; Fri, 02 May 2025 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746215618; x=1746820418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QY24jX2mcRpHEguXZSrHOslq7VyE8AT/RUOOvInkGcU=;
        b=BfmxOTB72WEgW+st84aqH3NO0VA9+0V/XE8YgWxT278TLrJWRMER6pB7ftAnsOrJzU
         i8VEeeVkZtWlqvtYYgiCoUJbNVosWbK5ajVDWlFXpP3gU3fgCnq/Hq0aVz8EkiwXgtdP
         ELm4BNZK+Bn0+drYVFmr5ZlMLFcFN/+AmPY0memE/JSQ9kCcQ6yUGwb1AHda4d1/BV/D
         qgqvdqh8opPPAbxRMdKky4xq241a7uhipNbntOEwM9kGQZBBg56X6iHuGh+BN5kIrq44
         Zj4rhqgVwIzLTSfuO+G0bYOrUkq+r8vkvdPk6q9o7A+IhxuRmJsKrJJpCdlion2Bsio6
         dcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746215618; x=1746820418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY24jX2mcRpHEguXZSrHOslq7VyE8AT/RUOOvInkGcU=;
        b=G/5aRqT4aaqVncaxAqHbKd1Htzjxo1/rstLCqgeEEPsqQneNKRzFkrUZ413V7TiDHs
         s60XUiNTp8YqAoUHUvddMbKScucxA/SmvIALAgf/aGpUNOMs/8G6BQenYLGIhw7+ZxCl
         L2zr99WKPxZ6vsuG93OKgVc5QUWF7KplYfvlZZtohLUAZOF+VOed18af/oofXA2KSuLz
         GvnVI7NIiIIyi5O7c/ezcI/kYBAcwADiN8XxmTz/itRqSBh/MkiV8AOe4vW6LPjWAmq1
         5cAbcd1Jjj4HL37CbD8leIjYwyQRVsIHxox/fDjzL63A7xDoMBe/m2tZkjR6y+AT3Gc1
         cc1g==
X-Forwarded-Encrypted: i=1; AJvYcCUtP/WyAgJzyZPOU9qrrBpgp8RhXFrlyFAxjfoGRgzoJK+rwkLZVxcmqyAgFCCWn8NmpDjjtxCGsoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtamAl8jwA47awEuKXZ0RnA/gHE4zyGnwoMbmFM4Q/k4ltnra
	nR3d6ky57aMag2t0Sq5+/KY2bTa+B/tRIE4KhZF8qXF+QOqxHP8jnJvZgZMctitpYPECJozyBnQ
	jIQ==
X-Google-Smtp-Source: AGHT+IHB5jen2h1kH8jYNrKitBcw6yMKWSJoP3Wt43EQJQwGMArxvgTwE+Bg4d0pCoXL5tpLZIu1ygKo++o=
X-Received: from pjbpd15.prod.google.com ([2002:a17:90b:1dcf:b0:30a:2020:e2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4983:b0:2ee:ee77:2263
 with SMTP id 98e67ed59e1d1-30a5adf4b43mr905164a91.7.1746215617757; Fri, 02
 May 2025 12:53:37 -0700 (PDT)
Date: Fri, 2 May 2025 12:53:36 -0700
In-Reply-To: <20250502084007.GS4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430110734.392235199@infradead.org> <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net> <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net> <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
Message-ID: <aBUiwLV4ZY2HdRbz@google.com>
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in
 __nocfi functions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org, 
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Content-Type: multipart/mixed; charset="UTF-8"; boundary="lefFiOsVgwoJmfzZ"


--lefFiOsVgwoJmfzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2025, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 11:30:18AM -0700, Sean Christopherson wrote:
> 
> > Uh, aren't you making this way more complex than it needs to be? 
> 
> Possibly :-)
> 
> > IIUC, KVM never
> > uses the FRED hardware entry points, i.e. the FRED entry tables don't need to be
> > in place because they'll never be used.  The only bits of code KVM needs is the
> > __fred_entry_from_kvm() glue.
> 
> But __fred_entry_from_kvm() calls into fred_extint(), which then
> directly uses the fred sysvec_table[] for dispatch. How would we not
> have to set up that table?

I missed that the first time around.  From my self-reply:

 : Hrm, and now I see that fred_extint() relies on fred_install_sysvec(), which makes
 : me quite curious as to why IRQs didn't go sideways.  Oh, because sysvec_table[]
 : is statically defined at compile time except for PV crud.
 : 
 : So yeah, I think my the patches are correct, they just the need a small bit of
 : prep work to support dynamic setup of sysvec_table.

> > Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardware.
> 
> So the FRED NMI code is significantly different from the IDT NMI code
> and I really didn't want to go mixing those.
> 
> If we get a nested NMI I don't think it'll behave well.

Ah, because FRED hardwware doesn't have the crazy NMI unblocking behavior, and
the FRED NMI entry code relies on that.

But I don't see why we need to care about NMIs from KVM, while they do bounce
through assembly to create a stack frame, the actual CALL is direct to
asm_exc_nmi_kvm_vmx().  If it's just the unwind hint that's needed, that

The attached patches handle the IRQ case and are passing my testing.

--lefFiOsVgwoJmfzZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-x86-fred-Install-system-vector-handlers-even-if-FRED.patch"

From e605366a5ff6dfcfb45084828585e5fcfc5d3bcc Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 2 May 2025 07:24:01 -0700
Subject: [PATCH 1/3] x86/fred: Install system vector handlers even if FRED
 isn't fully enabled

Install the system vector IRQ handlers for FRED even if FRED isn't fully
enabled in hardware.  This will allow KVM to use the FRED IRQ path even
on non-FRED hardware, which in turn will eliminate a non-CFI indirect CALL
(KVM currently invokes the IRQ handler via an IDT lookup on the vector).

Not-yet-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[sean: extract from diff, drop stub, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/idtentry.h | 9 ++-------
 arch/x86/kernel/irqinit.c       | 6 ++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a4ec27c67988..abd637e54e94 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -460,17 +460,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #endif
 
 void idt_install_sysvec(unsigned int n, const void *function);
-
-#ifdef CONFIG_X86_FRED
 void fred_install_sysvec(unsigned int vector, const idtentry_t function);
-#else
-static inline void fred_install_sysvec(unsigned int vector, const idtentry_t function) { }
-#endif
 
 #define sysvec_install(vector, function) {				\
-	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+	if (IS_ENABLED(CONFIG_X86_FRED))				\
 		fred_install_sysvec(vector, function);			\
-	else								\
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))			\
 		idt_install_sysvec(vector, asm_##function);		\
 }
 
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index f79c5edc0b89..6ab9eac64670 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -97,9 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	/* FRED's IRQ path may be used even if FRED isn't fully enabled. */
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_complete_exception_setup();
-	else
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_setup_apic_and_irq_gates();
 
 	lapic_assign_system_vectors();

base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
-- 
2.49.0.906.g1f30a19c02-goog


--lefFiOsVgwoJmfzZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-x86-fred-Play-nice-with-invoking-asm_fred_entry_from.patch"

From 12dc39eeb3d5ed1950a9bbaf4ac68c46943d0e9d Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 1 May 2025 11:20:29 -0700
Subject: [PATCH 2/3] x86/fred: Play nice with invoking
 asm_fred_entry_from_kvm() on non-FRED hardware

Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
when FRED isn't fully enabled, e.g. when running with CONFIG_X86_FRED=y
on non-FRED hardware.  This will allow forcing KVM to always use the FRED
entry points for 64-bit kernels, which in turn will eliminate a rather
gross non-CFI indirect call that KVM uses to trampoline IRQs by doing IDT
lookups.

When FRED isn't enabled, simply skip ERETS and restore RBP and RSP from
the stack frame prior to doing a "regular" RET back to KVM (in quotes
because of all the RET mitigation horrors).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/entry/entry_64_fred.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..7aff2f0a285f 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	movq %rsp, %rdi				/* %rdi -> pt_regs */
 	call __fred_entry_from_kvm		/* Call the C entry point */
 	POP_REGS
-	ERETS
+
+	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
 1:
 	/*
 	 * Objtool doesn't understand what ERETS does, this hint tells it that
@@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	 * isn't strictly needed, but it's the simplest form.
 	 */
 	UNWIND_HINT_RESTORE
-	pop %rbp
+	leave
 	RET
 
 SYM_FUNC_END(asm_fred_entry_from_kvm)
-- 
2.49.0.906.g1f30a19c02-goog


--lefFiOsVgwoJmfzZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-x86-fred-KVM-VMX-Always-use-FRED-for-IRQs-when-CONFI.patch"

From 047137843838e48af8ec9cfd36e62e605b43cacd Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 1 May 2025 11:10:39 -0700
Subject: [PATCH 3/3] x86/fred: KVM: VMX: Always use FRED for IRQs when
 CONFIG_X86_FRED=y

Now that FRED provides C-code entry points for handling IRQs, use the FRED
infrastructure for forwarding IRQs even if FRED fully enabled, e.g. isn't
supported in hardware.  Avoiding the non-FRED assembly trampolines into
the IDT handlers for IRQs eliminates the associated non-CFI indirect call
(KVM performs a CALL by doing a lookup on the IDT using the IRQ vector).

Keep NMIs on the legacy IDT path, as the FRED NMI entry code relies on
FRED's architectural behavior with respect to NMI blocking, i.e. doesn't
jump through the myriad hoops needed to deal with IRET "unexpectedly"
unmasking NMIs.  KVM's NMI path already makes a direct CALL to C-code,
i.e. isn't problematic for CFI.  KVM does make a short detour through
assembly code to build the stack frame, but the "FRED entry from KVM"
path does the same.

Force FRED for 64-bit kernels if KVM_INTEL is enabled, as the benefits of
eliminating the IRQ trampoline usage far outwieghts the code overhead for
FRED.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig   | 1 +
 arch/x86/kvm/vmx/vmx.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2eeffcec5382..712a2ff28ce4 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -95,6 +95,7 @@ config KVM_SW_PROTECTED_VM
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
+	select X86_FRED if X86_64
 	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
 	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
 	help
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef2d7208dd20..3139658de9ed 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6994,8 +6994,14 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
 
+	/*
+	 * Invoke the kernel's IRQ handler for the vector.  Use the FRED path
+	 * when it's available even if FRED isn't fully enabled, e.g. even if
+	 * FRED isn't supported in hardware, in order to avoid the indirect
+	 * CALL in the non-FRED path.
+	 */
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
-- 
2.49.0.906.g1f30a19c02-goog


--lefFiOsVgwoJmfzZ--

