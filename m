Return-Path: <linux-efi+bounces-3543-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10836AA7A5E
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773104C7840
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C51F30DD;
	Fri,  2 May 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hXlnQTzu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A251F2BAD;
	Fri,  2 May 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215070; cv=none; b=rEVsmKRRRCQBQHU8Z9j2my0/cSZfcdfmxXDEvIxso0ujbzaMW8iRD6tKWCkcw+2sv1jYswVEqcru8lDYpbBmTatboVnQTrwvGT5hAOen0KvsjTMXR/f/MDa/Lho1qA8PrGlLF+POh7P5kxe5wDXqKzOnspfK3wrQKXVKdU1qzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215070; c=relaxed/simple;
	bh=n+L5wdWKfMSnWgjpxdKD9mYdVp2ikqZ5Yl7stiWg6xg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B+HZFWySXfWWe/SNufWuTFI4yGlbqcP0Ej7eN53shWf6ArYMKybUAO540HZsk+rNtYAKcG23TYhp/QbM0LwcTO60KRT3VAW+0kAs2H/KbaRtdt3fyD2BU+7jjVbsd9ArwNQxoJuSNUPGr/QwPhr48Pyd8cTG6O1sTrZNOS1OxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hXlnQTzu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 542JhQjh2150495
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 2 May 2025 12:43:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 542JhQjh2150495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746215008;
	bh=ZqLXxzNJv0IHqSG9SsLfGERgXXTrSiEhUW5FOYYelTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hXlnQTzulXtKiJv1Lq04GAWzGF/0q4TfVKQJTch09TMCik6jf/8YdVqA77Ps8sd25
	 QX5VLVzqgNsl8Q7tJ/7P4VMTaU4KPlYk/zktKDIoM1I9Fyau9p1HZQZcY2pbEW/q+I
	 Hrxb+YOhhwHl49hLEBYFb9Y+caY17+IRSFyp2ZARE6p8jGafT8Gm2CCQb367j+1uaK
	 o2hyqIBGWTUzPdeWKhV0Hy8YOmYk5Zqio4UbkvzM/zuTwf7JNTt3fwtQcqarSo1jrX
	 +pBune/c9bJzdacTU00rRG5QZkwPze2HEkF2Vy037KbBFp54+9MCfbfhNp6N9c87Qu
	 Qq3ksCCBwRmaA==
Date: Fri, 02 May 2025 12:43:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        jpoimboe@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/13=5D_objtool=3A_Detect_and_wa?=
 =?US-ASCII?Q?rn_about_indirect_calls_in_=5F=5Fnocfi_functions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9b112e40-d281-422c-b862-3c073b3c7239@zytor.com>
References: <20250430110734.392235199@infradead.org> <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com> <20250430190600.GQ4439@noisy.programming.kicks-ass.net> <20250501103038.GB4356@noisy.programming.kicks-ass.net> <20250501153844.GD4356@noisy.programming.kicks-ass.net> <aBO9uoLnxCSD0UwT@google.com> <9b112e40-d281-422c-b862-3c073b3c7239@zytor.com>
Message-ID: <80783990-FEF8-4F40-810E-5B89D9801E84@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 1, 2025 10:48:42 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 5/1/2025 11:30 AM, Sean Christopherson wrote:
>>  From c50fb5a8a46058bbcfdcac0a100c2aa0f7f68f1c Mon Sep 17 00:00:00 2001
>> From: Sean Christopherson<seanjc@google=2Ecom>
>> Date: Thu, 1 May 2025 11:10:39 -0700
>> Subject: [PATCH 2/2] x86/fred: KVM: VMX: Always use FRED for IRQ+NMI wh=
en
>>   CONFIG_X86_FRED=3Dy
>>=20
>> Now that FRED provides C-code entry points for handling IRQ and NMI exi=
ts,
>> use the FRED infrastructure for forwarding all such events even if FRED
>> isn't supported in hardware=2E  Avoiding the non-FRED assembly trampoli=
nes
>> into the IDT handlers for IRQs eliminates the associated non-CFI indire=
ct
>> call (KVM performs a CALL by doing a lookup on the IDT using the IRQ
>> vector)=2E
>>=20
>> Force FRED for 64-bit kernels if KVM_INTEL is enabled, as the benefits =
of
>> eliminating the IRQ trampoline usage far outwieghts the code overhead f=
or
>> FRED=2E
>>=20
>> Suggested-by: Peter Zijlstra<peterz@infradead=2Eorg>
>> Signed-off-by: Sean Christopherson<seanjc@google=2Ecom>
>> ---
>>   arch/x86/kvm/Kconfig   | 1 +
>>   arch/x86/kvm/vmx/vmx=2Ec | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index 2eeffcec5382=2E=2E712a2ff28ce4 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -95,6 +95,7 @@ config KVM_SW_PROTECTED_VM
>>   config KVM_INTEL
>>   	tristate "KVM for Intel (and compatible) processors support"
>>   	depends on KVM && IA32_FEAT_CTL
>> +	select X86_FRED if X86_64
>
>I LOVE this change, but not sure if everyone is happy with it=2E
>
>>   	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
>>   	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
>>   	help
>> diff --git a/arch/x86/kvm/vmx/vmx=2Ec b/arch/x86/kvm/vmx/vmx=2Ec
>> index ef2d7208dd20=2E=2E2ea89985107d 100644
>> --- a/arch/x86/kvm/vmx/vmx=2Ec
>> +++ b/arch/x86/kvm/vmx/vmx=2Ec
>> @@ -6995,7 +6995,7 @@ static void handle_external_interrupt_irqoff(stru=
ct kvm_vcpu *vcpu,
>>   		return;
>>     	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
>> -	if (cpu_feature_enabled(X86_FEATURE_FRED))
>> +	if (IS_ENABLED(CONFIG_X86_FRED))
>
>"if (IS_ENABLED(CONFIG_X86_64))"?
>
>>   		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
>>   	else
>>   		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + ve=
ctor));
>> @@ -7268,7 +7268,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu=
)
>>   		return;
>>     	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
>> -	if (cpu_feature_enabled(X86_FEATURE_FRED))
>> +	if (IS_ENABLED(CONFIG_X86_FRED))
>
>Ditto=2E

I don't think anyone will have a problem with compiling it in=2E=2E=2E it =
is such a small amount of code=2E

