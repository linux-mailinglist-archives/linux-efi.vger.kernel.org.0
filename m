Return-Path: <linux-efi+bounces-3523-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A9AA62CE
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C889A64FE
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A5223316;
	Thu,  1 May 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+yQ/pA9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E721C198
	for <linux-efi@vger.kernel.org>; Thu,  1 May 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124222; cv=none; b=MaA7ziiSVcTP1sug7G3RWOK48XFbWHdHkwku6nolysszi/0FmkYGoS9rPFPoopnRaQ2czdyZ/L8sF8JaOUM37R4kXDzR1kRAP6LGtq/IpIgLHnGMF+r2Goe74jADLhv6tbJWLhbjIQSS6Gr6P3Rc19+B0pibzWuWq8m3y9CDE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124222; c=relaxed/simple;
	bh=Y4tGBMBLGc/YKCq/GVPyHhKavhO0yq27W/ghOX4mpvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7RaHvuQCVcN+h6QvZiRU+7oFyXtiSjWYnOHNgr/jskZbv1CupyBf7gNSNrbdExcK+z0wcqn5029vTpgbqXRhb6ZO26rCyCdBVz6dbgh39CUVNQK4EfRE07s6NTuA/6iNxbwpz9ml8m+9Kic+hMOCrY2b5H08D+kfgJe87ixpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+yQ/pA9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cb72efd5so1156957b3a.3
        for <linux-efi@vger.kernel.org>; Thu, 01 May 2025 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746124219; x=1746729019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb2qgdFL1uGhH3LnsFjHt03Akcbc42TOdjKut1BadxU=;
        b=k+yQ/pA9DoUR668FfbsxZTszZj/lmIG5WDw5R2RkQqUG5afv6Tgllfl5LkUSB13x70
         tGin2B/Aa6Y0mY0nVwLUYF5If8q9i3lMXPTeteMV3XbLEtBdw00fiQwDY60nhN2os5ff
         yOKY2v9J4Za1QenEAUZdh5eVOR9RIPQWbyxBNblUOaP8T2XtGlUsIF8zEP+SNPldS1j8
         GzDwoRCtQJdYxouF8TVtJ9HuLsr8slrGy8SixfgTR9uizwfNp+zloCE7ZXoH8ne7mdkl
         Jov1wphLgOZ4LAulWljkvl44FNqFKeQ8i7kqc4fnIyOQxday9hQnUXNgONFWeFgfpini
         U8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124219; x=1746729019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb2qgdFL1uGhH3LnsFjHt03Akcbc42TOdjKut1BadxU=;
        b=UP1wdN0AxFifZsy06XrHIY9TfIEqukZu6JzntRVmm0mTFGyZ2Y/MYIrpyfBTEooq3Y
         8YSzN3eaBRtkfJMWvRpTwb5bAGQB6iqvDS5BVOhIvB2dOikjuCayJ9evhp8oqG4vpWdV
         45D2vOE9J9mkuWnR9njK5WH9uGvZcszOjji5mBiQYKSOpYb1jjmYERH5fIqB7hUijGwx
         Ss7MmcyV7+uURn8ZwYTJUztW/1NMPhvTq230yF1/Tw8rfJ9OE2VblUHV2TFKYAkF6Ipd
         UcsDt3yqsjOsw6mOhf+ysYg3yhYEE5ws8wpSPZkYex+ycyjFgZfKXgAFtR2kjFptto9b
         pHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGbZpTkA0XCQRDxq6CH9SJQnZO/aJqA2ocjrJHjTIEULWfQSp9U/ANt1TY6MNPRogcdEtxLb1TIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCad3zz22cOIrOeRv4BbV5ixS90faQWyZ65NRhir/4AFSccyU
	l6TivxTsNFBjDXUOuYrCDAU8ByrNzcfRbdCpMNhCSiRY5TvUykerggXs0TLrWklF2n5dM6Snong
	NgA==
X-Google-Smtp-Source: AGHT+IE+acSB6pP/XFrGYreSGEpMxcpIN4zf03F9AG6mxlsdNLC5ZdXiyh+Le4rdLnsVm76Q4eWXdPS7fMA=
X-Received: from pfbdu11.prod.google.com ([2002:a05:6a00:2b4b:b0:730:90b2:dab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fd1:b0:736:32d2:aa82
 with SMTP id d2e1a72fcca58-7404927067fmr4682617b3a.23.1746124219442; Thu, 01
 May 2025 11:30:19 -0700 (PDT)
Date: Thu, 1 May 2025 11:30:18 -0700
In-Reply-To: <20250501153844.GD4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430110734.392235199@infradead.org> <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net> <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
Message-ID: <aBO9uoLnxCSD0UwT@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Thu, May 01, 2025, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 12:30:38PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 30, 2025 at 09:06:00PM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 30, 2025 at 07:24:15AM -0700, H. Peter Anvin wrote:
> > > 
> > > > >KVM has another; the VMX interrupt injection stuff calls the IDT handler
> > > > >directly.  Is there an alternative? Can we keep a table of Linux functions
> > > > >slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
> > > 
> > > > We do have a table of handlers higher up in the stack in the form of
> > > > the dispatch tables for FRED. They don't in general even need the
> > > > assembly entry stubs, either.
> > > 
> > > Oh, right. I'll go have a look at those.
> > 
> > Right, so perhaps the easiest way around this is to setup the FRED entry
> > tables unconditionally, have VMX mandate CONFIG_FRED and then have it
> > always use the FRED entry points.
> > 
> > Let me see how ugly that gets.
> 
> Something like so... except this is broken. Its reporting spurious
> interrupts on vector 0x00, so something is buggered passing that vector
> along.

Uh, aren't you making this way more complex than it needs to be?  IIUC, KVM never
uses the FRED hardware entry points, i.e. the FRED entry tables don't need to be
in place because they'll never be used.  The only bits of code KVM needs is the
__fred_entry_from_kvm() glue.

Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardware.

--
From 664468143109ab7c525c0babeba62195fa4c657e Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 1 May 2025 11:20:29 -0700
Subject: [PATCH 1/2] x86/fred: Play nice with invoking
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

base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
-- 
2.49.0.906.g1f30a19c02-goog

From c50fb5a8a46058bbcfdcac0a100c2aa0f7f68f1c Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 1 May 2025 11:10:39 -0700
Subject: [PATCH 2/2] x86/fred: KVM: VMX: Always use FRED for IRQ+NMI when
 CONFIG_X86_FRED=y

Now that FRED provides C-code entry points for handling IRQ and NMI exits,
use the FRED infrastructure for forwarding all such events even if FRED
isn't supported in hardware.  Avoiding the non-FRED assembly trampolines
into the IDT handlers for IRQs eliminates the associated non-CFI indirect
call (KVM performs a CALL by doing a lookup on the IDT using the IRQ
vector).

Force FRED for 64-bit kernels if KVM_INTEL is enabled, as the benefits of
eliminating the IRQ trampoline usage far outwieghts the code overhead for
FRED.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig   | 1 +
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index ef2d7208dd20..2ea89985107d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6995,7 +6995,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
@@ -7268,7 +7268,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
 	else
 		vmx_do_nmi_irqoff();
-- 
2.49.0.906.g1f30a19c02-goog

