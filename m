Return-Path: <linux-efi+bounces-3528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD2AA6A59
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840F11BA3777
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221331A5B87;
	Fri,  2 May 2025 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QNHgla/6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CDBA3F;
	Fri,  2 May 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164959; cv=none; b=sNh7tRf05/t0YssUX2d1zNp7dL7u6mlT2O0Kt58GyzZtBu7Py70Jyz9/AXtuBnlvUorvxnyxSomnTPAXOxM/k7F4nwrvTg7cFb/Nma46vHg7I/BHYXBMaXHQ6/rmdl7s+zGe4fu846UBXCGC88eYT0pGBB1dVgYs7CdpaSO1yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164959; c=relaxed/simple;
	bh=xHuDiwaHi25BWrOdJavtW7Xs+O7UjhjxqydntQpALqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPcf9CVhF9UmDFI0mp4MZYQ0Dso0CDGKm2NQ4y+QcwYBX6AaiJL0MZrCaAc6kEHonB1oOwaz3M90ju1qoPwmNQ+//unNkvAwZ/nU/1noSz6SAHiHhLoKksOcPj5Ai4/jjOD4Mi9+VHdEcMCcx/oLAvWQ2NDcUbUE8eaOu7JT0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QNHgla/6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5425mgEN1781141
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 1 May 2025 22:48:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5425mgEN1781141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746164924;
	bh=UPrgXeeHDSbppfXKlFI7+ZZbVFJc1sBHvqfJ3YIqx60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QNHgla/6mBMJgp4DmEzvjI9pcvfVN1AMs4cpGZJq2JBUfGbHcB9acot2g/bgQGktc
	 18qpb94Jy2r+RT5E9zUkpFLLsrV3Z3/i70nJ+Dh+WTpdCsZ+bEy40c+lxFidRpCSKD
	 RcNA8Yg9dvgJ978NzgkgtdYqjKvXlHNKEHrVnYOa67p79PEEX6vGALYMxlIAEfKghW
	 DM/OlDNVra5aggOOi76AhTcuZIvUMePIFwDClF/1v0o7EYk0G9wmAHQxo6AnUG/EYb
	 N2BN2I0wrrK0Y3lw9W0AkaAWkLlIQJsN4PZ7YC6a5LaCim78ZaBem0nJZCSNIaQFsC
	 CJOJPI+IHLuOQ==
Message-ID: <9b112e40-d281-422c-b862-3c073b3c7239@zytor.com>
Date: Thu, 1 May 2025 22:48:42 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in
 __nocfi functions
To: Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
        kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, jpoimboe@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-efi@vger.kernel.org,
        samitolvanen@google.com, ojeda@kernel.org
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <aBO9uoLnxCSD0UwT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/2025 11:30 AM, Sean Christopherson wrote:
>  From c50fb5a8a46058bbcfdcac0a100c2aa0f7f68f1c Mon Sep 17 00:00:00 2001
> From: Sean Christopherson<seanjc@google.com>
> Date: Thu, 1 May 2025 11:10:39 -0700
> Subject: [PATCH 2/2] x86/fred: KVM: VMX: Always use FRED for IRQ+NMI when
>   CONFIG_X86_FRED=y
> 
> Now that FRED provides C-code entry points for handling IRQ and NMI exits,
> use the FRED infrastructure for forwarding all such events even if FRED
> isn't supported in hardware.  Avoiding the non-FRED assembly trampolines
> into the IDT handlers for IRQs eliminates the associated non-CFI indirect
> call (KVM performs a CALL by doing a lookup on the IDT using the IRQ
> vector).
> 
> Force FRED for 64-bit kernels if KVM_INTEL is enabled, as the benefits of
> eliminating the IRQ trampoline usage far outwieghts the code overhead for
> FRED.
> 
> Suggested-by: Peter Zijlstra<peterz@infradead.org>
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> ---
>   arch/x86/kvm/Kconfig   | 1 +
>   arch/x86/kvm/vmx/vmx.c | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 2eeffcec5382..712a2ff28ce4 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -95,6 +95,7 @@ config KVM_SW_PROTECTED_VM
>   config KVM_INTEL
>   	tristate "KVM for Intel (and compatible) processors support"
>   	depends on KVM && IA32_FEAT_CTL
> +	select X86_FRED if X86_64

I LOVE this change, but not sure if everyone is happy with it.

>   	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
>   	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
>   	help
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ef2d7208dd20..2ea89985107d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6995,7 +6995,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
>   		return;
>   
>   	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
> -	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +	if (IS_ENABLED(CONFIG_X86_FRED))

"if (IS_ENABLED(CONFIG_X86_64))"?

>   		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
>   	else
>   		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
> @@ -7268,7 +7268,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
>   		return;
>   
>   	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +	if (IS_ENABLED(CONFIG_X86_FRED))

Ditto.

