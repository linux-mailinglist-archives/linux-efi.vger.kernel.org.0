Return-Path: <linux-efi+bounces-4317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB83B03C29
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E74E189D55C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A4242D98;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3ByvgNl"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813E1FDA94;
	Mon, 14 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489907; cv=none; b=ekIyuIJK+CpSxuVJQL50Q6IiMcG9B5MgDObz0lRbCsgMY7Ejgwe2ljIgpVJop+jV0mMC24h80pJ8buNMGFbld6uvHAT8rMFWP2/NHK3D7YaAA/Z1FQ1Ewo3CnU7Jy/C5Np5+Rv9lO646Q1jdhznI9Mj64iyFHkPx2KwLA99sxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489907; c=relaxed/simple;
	bh=laH8zvY2NdqgddV1uxCUdzQgi9ZK8xvb1p3SXlHj50A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ii7Q7Q8aXUIOClMhppq/bJUX2hE45XM86TkXt8UXxteSdnlvwnF7+ur81HsH8aByvrPrhetl/b1+LPLmdTJzGIFIiPGJoQLxb4EDWZ/h5PX1AbpcjBpTVE9ubuxPjmNwNvxANw8qI/3kBlpWv26BesblrdRnPUbggbVMKhBU/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3ByvgNl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ewom6iS5EFylqeechOg2mSSAJjmRRMGPDBC4yQb3ICA=; b=I3ByvgNlQB8b9X1OcxuTh/ldip
	iqAFgQ1nHpABs/r9QProbboIHdgRWlAmk7uEyA6ZaV465SWovxk+vJhs/+6ZykwDm3C3WL4rEdEdE
	rXiR7exX0XoRUqL5WyRPS58q64mC37SssiuJ5gqYSur2ISIMDzo2hlYDVjc+pikxRpDJSUf3GX/Cs
	KtdRB5uhH10lNtDc2Y3puNdkh1DI/9jPwIrwn10GevDi2WhMAjMQxzZlecpsvNNW/kIZ7kM2OPV39
	G5UXw1uSS3s22EMpcPbe5L09ryZkBH5Jqhi6IB3i2vmqtgF1CeKIeah/apYAAue5aCII6wJJuS92i
	UBl+PKCw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000009kcq-15Ba;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2D485302DA9; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103441.381946911@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:26 +0200
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
Subject: [PATCH v3 15/16] x86/fred: KVM: VMX: Always use FRED for IRQs when CONFIG_X86_FRED=y
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sean Christopherson <seanjc@google.com>

Now that FRED provides C-code entry points for handling IRQs, use the
FRED infrastructure for forwarding IRQs even if FRED is fully
disabled, e.g. isn't supported in hardware. Avoiding the non-FRED
assembly trampolines into the IDT handlers for IRQs eliminates the
associated non-CFI indirect call (KVM performs a CALL by doing a
lookup on the IDT using the IRQ vector).

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/Kconfig   |    1 +
 arch/x86/kvm/vmx/vmx.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -97,6 +97,7 @@ config KVM_INTEL
 	depends on KVM && IA32_FEAT_CTL
 	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
 	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
+	select X86_FRED if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6989,8 +6989,14 @@ static void handle_external_interrupt_ir
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



