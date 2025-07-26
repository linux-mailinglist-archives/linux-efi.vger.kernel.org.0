Return-Path: <linux-efi+bounces-4485-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9192B1290A
	for <lists+linux-efi@lfdr.de>; Sat, 26 Jul 2025 06:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24E61C244A9
	for <lists+linux-efi@lfdr.de>; Sat, 26 Jul 2025 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5061F12E9;
	Sat, 26 Jul 2025 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ibk+Evbw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B41D88AC;
	Sat, 26 Jul 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753505723; cv=none; b=My0FK/GxJczw7PlgvuWZC21WrffIjZuYaUWmzes7ynoFLvc1ifYKvpeiFEo8Iv8x0fz+qwKas/UBxuzTDJ3cshlg+Xc6WC4JsA+wgq1WTMs4nCzMm07W10prbcyERjFfQO8KMrJWGAjNRDKvWB1Nhw+57gFc3S/6XRcXpRRPieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753505723; c=relaxed/simple;
	bh=WIKJAZbq8ZAJLEZT6znW//XtQXEdPdFm79jVWQWJcpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgcSKIqYOVy+VFay8XEr+NSvzNRnYkV+GEvV3IDgB5+Ed7x8AazkbeMHXJf6wBm3Hxr9WCfS1hzwDAaYEU3z+lHZ7Mh1esZW31eHPsomVfEriNswnVgE3BPbVAeHUN5lp3UYM0tkSG7CQiZXE8x+OrJR+zC/Bqpx0n+s8rN9fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Ibk+Evbw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56Q4sXQH2943787
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 25 Jul 2025 21:54:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56Q4sXQH2943787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753505677;
	bh=BBl0so23jHfY+QhvknFnZI0VosBEfLkfdwOBEoaWEbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ibk+EvbwHOgojh0tGX7l4bIpi0ESMCawJY3wF5jFKBklo3JdFibrVjGV0B8bv9FaQ
	 eLpIWFr8UXn+Y7urBwWVJwUAIyfUtJI4D+UBYgB/0rOtyHXXt60emaqIL8yYV/s87M
	 jxZvbK7ppTbcVeKj9Mwag9Zg+kOaz/KSmZeGMC0ZjIfedzO4afO7U0K3PW4xQLxCgG
	 UWSDok1HAtjqWF9uGDygksU6AbFQfBEe9rVYexOKeLV9IsBRitXvsp1xARoZ4PmdST
	 whmUq1ZS4sbmRWH7wkGcWjqilgU2DFj7I+ITt2zMa2GVci9b3EjRvBCkP2JmGwfith
	 SHHzNgZzwXvPg==
Message-ID: <f6925ee5-bbd7-42e3-9e3b-59d2e8ec2681@zytor.com>
Date: Fri, 25 Jul 2025 21:54:32 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] x86/fred: Play nice with invoking
 asm_fred_entry_from_kvm() on non-FRED hardware
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
        kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, jpoimboe@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-efi@vger.kernel.org,
        samitolvanen@google.com, ojeda@kernel.org
References: <20250714102011.758008629@infradead.org>
 <20250714103441.245417052@infradead.org>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <20250714103441.245417052@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/2025 3:20 AM, Peter Zijlstra wrote:
>   	call __fred_entry_from_kvm		/* Call the C entry point */
> -	POP_REGS
> -	ERETS
> -1:
> +
> +1:	/*

The symbol "1" is misplaced; it needs to be put after the ERETS
instruction.

> +	 * When FRED, use ERETS to potentially clear NMIs, otherwise simply
> +	 * restore the stack pointer.
> +	 */
> +	ALTERNATIVE "nop; nop; mov %rbp, %rsp", \

Why explicitly add two nops here?

ALTERNATIVE will still pad three-byte nop after the MOV instruction.

> +	            __stringify(add $C_PTREGS_SIZE, %rsp; ERETS), \
> +		    X86_FEATURE_FRED
> +
>   	/*
> -	 * Objtool doesn't understand what ERETS does, this hint tells it that
> -	 * yes, we'll reach here and with what stack state. A save/restore pair
> -	 * isn't strictly needed, but it's the simplest form.
> +	 * Objtool doesn't understand ERETS, and the cfi register state is
> +	 * different from initial_func_cfi due to PUSH_REGS. Tell it the state
> +	 * is similar to where UNWIND_HINT_SAVE is.
>   	 */
>   	UNWIND_HINT_RESTORE
> +
>   	pop %rbp
>   	RET
>   


