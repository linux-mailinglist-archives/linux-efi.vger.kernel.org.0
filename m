Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA35912DA6A
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaQvk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 11:51:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39816 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaQvk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 11:51:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so31891661qtm.6
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnAameZ6NR8kGQ+nny/sbC4hz+YrCvvZWFlCQ1+Lj2E=;
        b=JtSzdUa8opPM3wC6rkX4WYXcLxkfKQy6hxShVPPUqbLv4gfPGLxl8oizGPxWtVLCbs
         WEbEOkKx+BlMWEpaWK9DGMJ0hQ3PBaKToZulj3kyKg5f2HtyLef8FD9gKNmL5isalUgP
         KwkmZRe0ZK5JqG8kIbYalzBJ4YEjVKYjyJAW65XySWM8f43nIBs0AhjPlxW18KybHuEE
         9g0gA0TNVRkVTrw7tPqvOI2oeBuOSWUTSJdZjgaetZyiq2zJwXCj50Uq+ow5nIcqVli/
         fNXO91DhW1eGNqldnc8iazoeCd+8b41JSZjoWip1u0hPpC3aaLUUw2FMxNCdCyLir2SS
         XPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnAameZ6NR8kGQ+nny/sbC4hz+YrCvvZWFlCQ1+Lj2E=;
        b=BCwy1GIk/F/UbPAbRdtkepFTOdCLG4XIgdSP0bBkmsbMz5yM7MDlKCMKMoCNvbnvW+
         Lct9U9Pm8jKVLqCh6s97OWiw9BkU5c+tx9hhybi3hPLgGv+0SwA0VphJg9o/Oap2zi/L
         1mPQwo3Miu1cVCY3K4RlAXbiRA00OAKXBIGYp0JWmxaDhXcwe8/C3u4sP74W6MFdfJgw
         UOAiH33yDSKzjp0iMi80eheEubs1fYrRJyhnd/gD6hiLsTM3QliRSG1uvN+ktAbuG4rN
         1cnngH1gPT0239ihyj4JEUbiPjrV6bVjAkq8z2UsW5nXFGj/aibVlxOBnauXNB2QqZ0+
         +tNQ==
X-Gm-Message-State: APjAAAXBcvUdlsPQhIb2lhGJJKcVS8OZxhzit6DXNLDwZhaaB6OPO+eG
        GYJi+A6BNO4leJ94i8/vKP8=
X-Google-Smtp-Source: APXvYqwyKRQvG62KZMj4WSt89zv08IH0zLwYiaTbdlg1dCAQe5HwxONfTnBe/TzTpyDWZSlU0lfTeQ==
X-Received: by 2002:aed:2a12:: with SMTP id c18mr52889513qtd.200.1577811098998;
        Tue, 31 Dec 2019 08:51:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r44sm15292697qta.26.2019.12.31.08.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 08:51:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 31 Dec 2019 11:51:37 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 18/21] efi/libstub: use 'func' not 'f' as macro
 parameter
Message-ID: <20191231165136.GA3978784@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-19-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218170139.9468-19-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 18, 2019 at 07:01:36PM +0200, Ard Biesheuvel wrote:
> Use 'func' as the macro parameter name for the efi_call() macros
> which is less likely to collide and cause weird build errors.
> 

For my education, what are the possible collisions/build errors that might happen?

Thanks

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/efi.h |  4 ++--
>  arch/x86/include/asm/efi.h   | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 6f041ae446d2..d06305590ac5 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -93,8 +93,8 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
>  	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
>  }
>  
> -#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
> -#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
> +#define efi_call_early(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
> +#define efi_call_runtime(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
>  #define efi_is_native()			(true)
>  
>  #define efi_table_attr(inst, attr)	(inst->attr)
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 593a8cda8361..ba3f8a98e156 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -236,17 +236,17 @@ static inline bool efi_is_native(void)
>  		? inst->func(inst, ##__VA_ARGS__)			\
>  		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
>  
> -#define efi_call_early(f, ...)						\
> +#define efi_call_early(func, ...)					\
>  	(efi_is_native()						\
> -		? efi_system_table()->boottime->f(__VA_ARGS__)		\
> +		? efi_system_table()->boottime->func(__VA_ARGS__)	\
>  		: efi64_thunk(efi_table_attr(efi_system_table(),	\
> -				boottime)->mixed_mode.f, __VA_ARGS__))
> +				boottime)->mixed_mode.func, __VA_ARGS__))
>  
> -#define efi_call_runtime(f, ...)					\
> +#define efi_call_runtime(func, ...)					\
>  	(efi_is_native()						\
> -		? efi_system_table()->runtime->f(__VA_ARGS__)		\
> +		? efi_system_table()->runtime->func(__VA_ARGS__)	\
>  		: efi64_thunk(efi_table_attr(efi_system_table(),	\
> -				runtime)->mixed_mode.f, __VA_ARGS__))
> +				runtime)->mixed_mode.func, __VA_ARGS__))
>  
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);
> -- 
> 2.17.1
> 
