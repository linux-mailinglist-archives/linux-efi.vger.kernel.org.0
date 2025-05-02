Return-Path: <linux-efi+bounces-3527-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE1AA6A50
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 07:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AC4466B34
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 05:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A31A5B87;
	Fri,  2 May 2025 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R4OZ87Vt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1EBA3F;
	Fri,  2 May 2025 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164858; cv=none; b=dq6+nKnO1k/ON5frBE0WZ+2ob9d6nUxFB2OayTzWBEuUXUuxT5F9SjZW06RPDKz15eUzg8p18bi2NFOxP4fu6IhWJYXMfs7ybDldQuTtWjBnuV8oxNbhnsm87EZZY3ToTjOwM8A5bk7SrWfL1qk/v+FMGRWY3p4f1TrCZaOGwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164858; c=relaxed/simple;
	bh=CRlm8DglgsjDBM3aRfMpTQ7akikLGNAa4uzuEFyxihU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhreWaRz97+Utjfse6yzwNrIqv72g9T1M3gvU15ZDibMGGjrTa28SULnO3r/n/7m2M8YmBtbrWAC+KFZ22b3Xz88mu/bsIaniVy9vFYfJdupLSn60xRURoKidTcQ5StnkmFmkngzntHcuy1avT83y1QLIqd1G4RlKWI2Vz/w0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=R4OZ87Vt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5425kkje1780668
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 1 May 2025 22:46:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5425kkje1780668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746164809;
	bh=MGfso3qvTctMT+qsQxGakZO6pbzlMRbsUmiKDI86FZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R4OZ87Vtppt5v9J2EdCzFLGVKWqP9EyshJYqWkW/qTgZnPrKpAhmgz8UT6Lojiu5l
	 3QxrJYjGaM6aeq1eXQl6//Q5LykfWO5JlHATefd0jJ3v3VKCPJg+MIR68f3r6FpFxK
	 8EIKOQe66SNOYTTakLEaSq1FAWyDFKx+7iRJKmpNvkKCckyVnN9JkgFVdRZaBePpUX
	 G3GLZWcf3mlcEh3Jo/PBnU7abFTYXnU6q9bRCny3G16L20vDzM7u5tQ2mA/xjHPwXP
	 t6yVIaio1jQGUu4AErWBVEVJjIujrXCOMnr4hHudfxLoqaUxld7T63lIdgwLtHTD7s
	 IKsiUxtRR1dXQ==
Message-ID: <5e9bfa4b-4440-4d7b-895c-03a3358d4ae6@zytor.com>
Date: Thu, 1 May 2025 22:46:45 -0700
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

>> Something like so... except this is broken. Its reporting spurious
>> interrupts on vector 0x00, so something is buggered passing that vector
>> along.

I'm a bit late to the party :)

Peter kind of got what I had in the FRED patch set v8 or earlier:

https://lore.kernel.org/lkml/20230410081438.1750-34-xin3.li@intel.com/


> Uh, aren't you making this way more complex than it needs to be?  IIUC, KVM never
> uses the FRED hardware entry points, i.e. the FRED entry tables don't need to be
> in place because they'll never be used.  The only bits of code KVM needs is the
> __fred_entry_from_kvm() glue.

+1

> 
> Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardware.
> 
> --
>  From 664468143109ab7c525c0babeba62195fa4c657e Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <seanjc@google.com>
> Date: Thu, 1 May 2025 11:20:29 -0700
> Subject: [PATCH 1/2] x86/fred: Play nice with invoking
>   asm_fred_entry_from_kvm() on non-FRED hardware
> 
> Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
> when FRED isn't fully enabled, e.g. when running with CONFIG_X86_FRED=y
> on non-FRED hardware.  This will allow forcing KVM to always use the FRED
> entry points for 64-bit kernels, which in turn will eliminate a rather
> gross non-CFI indirect call that KVM uses to trampoline IRQs by doing IDT
> lookups.
> 
> When FRED isn't enabled, simply skip ERETS and restore RBP and RSP from
> the stack frame prior to doing a "regular" RET back to KVM (in quotes
> because of all the RET mitigation horrors).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/entry/entry_64_fred.S | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index 29c5c32c16c3..7aff2f0a285f 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>   	movq %rsp, %rdi				/* %rdi -> pt_regs */
>   	call __fred_entry_from_kvm		/* Call the C entry point */
>   	POP_REGS
> -	ERETS
> +
> +	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED

Neat!

I ever had a plan to do this with "sub $0x8,%rsp; iret;" for non-FRED
case.  But obviously doing nothing here is the best.

>   1:
>   	/*
>   	 * Objtool doesn't understand what ERETS does, this hint tells it that
> @@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>   	 * isn't strictly needed, but it's the simplest form.
>   	 */
>   	UNWIND_HINT_RESTORE
> -	pop %rbp
> +	leave

This is a smart change.

When !X86_FEATURE_FRED, the FRED stack frame set up for ERETS is
implicitly skipped by leave.  Maybe add a comment to explain LEAVE works
for both cases?

