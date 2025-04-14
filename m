Return-Path: <linux-efi+bounces-3329-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE054A8852D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948E5189741B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB162DFA23;
	Mon, 14 Apr 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD3zl81e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1882DFA21;
	Mon, 14 Apr 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639606; cv=none; b=EAxGtU2lc83LxDg8pmilPTxlooTnqoCGD6wUqaEU/kkygmvH/VSDWI6DnavzBJEvAQ+hsumKk03qKbUbZtLBEL/ISlTImmbUMfxwCSN477fZMESdl+ITA6THTtCB79i94L6jjtnhZ7BytH0xrZq2yXbh8JhLdje4WbhDVUOeyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639606; c=relaxed/simple;
	bh=sq85iaZePSBodnWG8dw4mchGLQuXkq+ro1j3ch5BREc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBVn4RjittJqxIaEhb+4wC1jg6piKiC6QjmPC16VriW22QtBiyjHIkMNCFy5S5CEqTrE7F9NCSnsLc4bj6lNtBzCncS9BapjPUVARb/+O99qZi/aZh2ahjugCxF8DXq5xWw1o5vVRxZu3zGU03TK0kzwtuXvVbzEnoEQYChwbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD3zl81e; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac297cbe017so978466166b.0;
        Mon, 14 Apr 2025 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639603; x=1745244403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqJHataDJN13GWdlaeETKdRNTar6wX0Omb0Dui9smng=;
        b=mD3zl81emCLRpvfHaC5XjAZpfh7XkJirP0y4izQZnpi8SnCKqfdP+d7UkR9+kBXuiN
         8+kxRUGepxEKAsH1VkuiGf8sakNH5KFYAwHpg0loNCwFm1YJYmiaZEFz8/8fMI7YEXNi
         I2jGIQlDX3njmTpuHlMXaik/WLHWjX1QENHHtFBGa2G3wZrMYYwJLVxHo7IH3NT+4kC0
         8ydOdiPotVZO/1LEv6w4zBXTieshVg8lwZSFzRE1KmZr8fjoJ56iw8Xqos+ZvRrgcPpU
         KpqPNDccjn3IXNBk4Q8GRTkF1WH3BmOvTKHvwRAFp/8l6oUeZhSIzCvFkjAc8bcTtQGS
         vBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639603; x=1745244403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqJHataDJN13GWdlaeETKdRNTar6wX0Omb0Dui9smng=;
        b=DYtMCvfnamlZXhLHBrdYVuJFHAqhQVbgCCJlSyeoQJziMbXafXrr7q7RwzL4yVMtMh
         bGxpDtv+AbOVLClR0xw/irgznY0u27xYAOfSn/I3Eusrmp/rufJd7vmT2HKfnA6L3ZMH
         BXrbOKkLGGcX18B0J7Q7p7jabIGbDpkLHz1o9kd6G8xbhPpd7iRV9TO8eZJp/612w1w2
         krgC2eL1trJRQJeRZ/H5oQhNVtm1ay5ZX9DtGoaVPHqRu5rqVGeN7kH11jdxwXFkn6sr
         J4XAPNx989lRXI5skGd4FB8i8FeBzBNlovpcxkeMvbd8Ig7kFq37l1LDH0nrWuCrEEg+
         AOjA==
X-Forwarded-Encrypted: i=1; AJvYcCU7MY0ut8U7Ksr8ZMcaJMp6qfeO0Ad60eCEIV9x2tZOkTsP0aLggW6wh3Ep9zFE9/F7RzLM5bs7Te9i4AIM@vger.kernel.org, AJvYcCVpq+hbkvOYyt1d0JByREbpKDmvxrbbSkbQbRdqNlzbXrn/komBDroeHPgJ3fDYGRStLkA=@vger.kernel.org, AJvYcCWm5h+qqtNJ1NZid4jq3Ro0hzH5cFxIOqhn5Po3ZZ8cjiP0CT6PvcqR7bMsc6XGBbemzlUVj86aZ5zf/dwf@vger.kernel.org, AJvYcCXYQFJvfS3hg+Dw5hMFOWEGJm5JDlcY3SZbAzI2broQ8mkxQmQ7HW9rNpl67DFKp00a8lCKbGKGsWrQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AecL3RbXkTFk52E/Ft+cgVVALFW07mKUNPKLP5A+lTR+mw0m
	Ekj4+zH37m4XDSVf15FsY4DsK4Avnuf9FXVh9WHV7t3gI3tIKrb8
X-Gm-Gg: ASbGncstJ70KHtG8nmq56t/DLh/fMjt/BMNjgdoG3wvHtJCkx6BDrnqfrIArbdW1Vl/
	DJRfSfMIWJL/LQXcHquWpHcNp8Q1ho8fxmaoRffjuX+J7qZGPlOnxQ1fav2lhzt0olt9xG+gW/e
	AlbWAnsbitEF2hY1eC7wx6qWW5hq48IQw02QQEyZQrlsYqtoRNa56GodhG+HLjjVICa6OfIvE4E
	+uvY4ETekCgAzwFxvVy7CkgRfelOyKx0sUGRiY85o1m40R9Lv8rSldsK6+bRjmrTS6iZapebRkT
	j1zEHZ6BtqBvYnJ5OXd5+OV1kOjiCOeUhOk3Zg+Xig==
X-Google-Smtp-Source: AGHT+IGv7I7mfcP3SkB2yL+BqA/SYvY6RgaRIDLCbA6d3KCPxX8mr0qnv7srH/JCsek7/hDZZbZ5NA==
X-Received: by 2002:a17:907:1b10:b0:ac2:7ce7:cd2b with SMTP id a640c23a62f3a-acad1622b9emr958079466b.2.1744639603046;
        Mon, 14 Apr 2025 07:06:43 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1cfsm916454566b.138.2025.04.14.07.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 07:06:42 -0700 (PDT)
Message-ID: <01c65464-8535-28d8-a9b5-eb4f90114e2d@gmail.com>
Date: Mon, 14 Apr 2025 16:06:41 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
References: <20250414111140.586315004@infradead.org>
 <20250414113754.285564821@infradead.org>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20250414113754.285564821@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14. 04. 25 13:11, Peter Zijlstra wrote:
> What used to be a simple few instructions has turned into a giant mess
> (for x86_64). Not only does it use static_branch wrong, it mixes it
> with dynamic branches for no apparent reason.
> 
> Notably it uses static_branch through an out-of-line function call,
> which completely defeats the purpose, since instead of a simple
> JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> absolutely idiotic.
> 
> Add to that a dynamic test of hyperv_paravisor_present, something
> which is set once and never changed.
> 
> Replace all this idiocy with a single direct function call to the
> right hypercall variant.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/hyperv/hv_init.c       |   21 ++++++
>   arch/x86/hyperv/ivm.c           |   14 ++++
>   arch/x86/include/asm/mshyperv.h |  137 +++++++++++-----------------------------
>   arch/x86/kernel/cpu/mshyperv.c  |   18 +++--
>   4 files changed, 88 insertions(+), 102 deletions(-)
> 
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -35,7 +35,28 @@
>   #include <linux/highmem.h>
>   
>   void *hv_hypercall_pg;
> +
> +#ifdef CONFIG_X86_64
> +u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	if (!hv_hypercall_pg)
> +		return U64_MAX;
> +
> +	register u64 __r8 asm("r8") = param2;
> +	asm volatile (CALL_NOSPEC
> +		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +		        "+c" (control), "+d" (param1)
> +		      : "r" (__r8),

r8 is call-clobbered register, so you should use "+r" (__r8) to properly 
clobber it:

		        "+c" (control), "+d" (param1), "+r" (__r8)
		      : THUNK_TARGET(hv_hypercall_pg)

> +		      : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}
> +#else
>   EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> +#endif
>   
>   union hv_ghcb * __percpu *hv_ghcb_pg;
>   
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -376,6 +376,20 @@ int hv_snp_boot_ap(u32 cpu, unsigned lon
>   	return ret;
>   }
>   
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	register u64 __r8 asm("r8") = param2;
> +	asm volatile("vmmcall"
> +		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +		       "+c" (control), "+d" (param1)
> +		     : "r" (__r8)

Also here:
		        "+c" (control), "+d" (param1), "+r" (__r8)
		      :

> +		     : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}

Uros.

