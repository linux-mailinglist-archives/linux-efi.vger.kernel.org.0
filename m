Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5712F14FEB1
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBRzE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:55:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBBRzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:55:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so14409089wma.1
        for <linux-efi@vger.kernel.org>; Sun, 02 Feb 2020 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l16/jWBg5TdkuLQMSLdNnEO2hLRau3tU8l2zd5isbi4=;
        b=TbPtfQQyQotPasF9Z3NIeqbz+pg3LRy9qOf3r/F8o0SAuMeEGwyaj1diE1wJHCSiit
         DjSQ4VJQcEbXLhFs7iAoizPsguYDlcmG7czPm8igOCw8aeRZgNK+n72FnMNYa5iCIXMy
         5qxme+/q37VpO36jGjOzrGwmzj+EFr3oKrsBK4n+2+kEes5I2k7cPAoey128xlr1C8/M
         kj/2QOUZYuuPI/6QlZQAiwnwFVCMsCr83XLwF2BpqILBEWWNZxsg4eLePxR8Y5agiGNj
         iJpR3uHd+TlnPvTwWTkP6fw7nycKk+/xL6tCnYknnYA8N+DEY6w/4hrk7Eg1N4BZhE6r
         3EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l16/jWBg5TdkuLQMSLdNnEO2hLRau3tU8l2zd5isbi4=;
        b=PMO5fUzyUjPu2YgGkpBPEkr3zKrSvEK0ejUanT0l5pppveGqEXpopFnvRJXiGvLITl
         IvGdKHaMj2hckgoANChYP0LWe4SLUVoavTMgDwo7LwOyG53hvkblzdx5xGc9iowUJQ92
         P8TgayoMtDu2+X1grsPKm5UPWY0eFRTkNayhbkOEfZC5Fn28Bvuf9YOe62BR7uBPl8JC
         zY8AueC5Inaa5ozH/6/pfxsUFuGkgoVno9H2LOa8IgXJZRYsRasdqbHLfRgTNilCUcWw
         IM9uaLxyUs4bvBr7UsLXBlSmRkuQyD2vfZ/au98lb1gssy7HSOQ/ynUj2o+LCqFYSlPh
         WLoA==
X-Gm-Message-State: APjAAAXeI6YKnaViQZ6OkoFGNOfQIiXr6EZdDFRZNO7dc8yCBJTEy89x
        T121D7kz+3ctJKc5B2mexUl0eBMcLlrntbxQwiQx9A==
X-Google-Smtp-Source: APXvYqzd+spEUZojR0Pta6mmrqcc+UjO+w2JlWfu6GM0fkKNdW6/l6Q/Tl8cMlgwoxSBGrzoFniwdsxwOCEAVzy/U+I=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr26387310wmk.68.1580666101359;
 Sun, 02 Feb 2020 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu> <20200202171353.3736319-3-nivedita@alum.mit.edu>
In-Reply-To: <20200202171353.3736319-3-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 2 Feb 2020 18:54:48 +0100
Message-ID: <CAKv+Gu9_bXmRMqs3Es7XXFjRafAm0HjyM6EasuKP1nka-dLdVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] efi/x86: Don't depend on firmware GDT layout
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Feb 2020 at 18:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> At handover entry in efi32_stub_entry, the firmware's GDT is still
> installed. We save the GDTR for later use in __efi64_thunk but we are
> assuming that descriptor 2 (__KERNEL_CS) is a valid 32-bit code segment
> descriptor and that descriptor 3 (__KERNEL_DS/__BOOT_DS) is a valid data
> segment descriptor.
>
> This happens to be true for OVMF (it actually uses descriptor 1 for data
> segments, but descriptor 3 is also setup as data), but we shouldn't
> depend on this being the case.
>
> Fix this by saving the code and data selectors in addition to the GDTR
> in efi32_stub_entry, and restoring them in __efi64_thunk before calling
> the firmware. The UEFI specification guarantees that selectors will be
> flat, so using the DS selector for all the segment registers should be
> enough.
>
> We also need to install our own GDT before initializing segment
> registers in startup_32, so move the GDT load up to the beginning of the
> function.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

It might be useful to mention /somewhere/ in the commit log that this
applies to mixed mode

> ---
>  arch/x86/boot/compressed/efi_thunk_64.S | 29 +++++++++++++++++++-----
>  arch/x86/boot/compressed/head_64.S      | 30 +++++++++++++++----------
>  2 files changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
> index 8fb7f6799c52..2b2049259619 100644
> --- a/arch/x86/boot/compressed/efi_thunk_64.S
> +++ b/arch/x86/boot/compressed/efi_thunk_64.S
> @@ -54,11 +54,16 @@ SYM_FUNC_START(__efi64_thunk)
>          * Switch to gdt with 32-bit segments. This is the firmware GDT
>          * that was installed when the kernel started executing. This
>          * pointer was saved at the EFI stub entry point in head_64.S.
> +        *
> +        * Pass the saved DS selector to the 32-bit code, and use far return to
> +        * restore the saved CS selector.
>          */
>         leaq    efi32_boot_gdt(%rip), %rax
>         lgdt    (%rax)
>
> -       pushq   $__KERNEL_CS
> +       movzwl  efi32_boot_ds(%rip), %edx
> +       movzwq  efi32_boot_cs(%rip), %rax
> +       pushq   %rax
>         leaq    efi_enter32(%rip), %rax
>         pushq   %rax
>         lretq
> @@ -73,6 +78,10 @@ SYM_FUNC_START(__efi64_thunk)
>         movl    %ebx, %es
>         pop     %rbx
>         movl    %ebx, %ds
> +       /* Clear out 32-bit selector from FS and GS */
> +       xorl    %ebx, %ebx
> +       movl    %ebx, %fs
> +       movl    %ebx, %gs
>
>         /*
>          * Convert 32-bit status code into 64-bit.
> @@ -92,10 +101,12 @@ SYM_FUNC_END(__efi64_thunk)
>   * The stack should represent the 32-bit calling convention.
>   */
>  SYM_FUNC_START_LOCAL(efi_enter32)
> -       movl    $__KERNEL_DS, %eax
> -       movl    %eax, %ds
> -       movl    %eax, %es
> -       movl    %eax, %ss
> +       /* Load firmware selector into data and stack segment registers */
> +       movl    %edx, %ds
> +       movl    %edx, %es
> +       movl    %edx, %fs
> +       movl    %edx, %gs
> +       movl    %edx, %ss
>
>         /* Reload pgtables */
>         movl    %cr3, %eax
> @@ -157,6 +168,14 @@ SYM_DATA_START(efi32_boot_gdt)
>         .quad   0
>  SYM_DATA_END(efi32_boot_gdt)
>
> +SYM_DATA_START(efi32_boot_cs)
> +       .word   0
> +SYM_DATA_END(efi32_boot_cs)
> +
> +SYM_DATA_START(efi32_boot_ds)
> +       .word   0
> +SYM_DATA_END(efi32_boot_ds)
> +
>  SYM_DATA_START(efi_gdt64)
>         .word   efi_gdt64_end - efi_gdt64
>         .long   0                       /* Filled out by user */
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bd44d89540d3..c56b30bd9c7b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -54,10 +54,6 @@ SYM_FUNC_START(startup_32)
>          */
>         cld
>         cli
> -       movl    $(__BOOT_DS), %eax
> -       movl    %eax, %ds
> -       movl    %eax, %es
> -       movl    %eax, %ss
>
>  /*
>   * Calculate the delta between where we were compiled to run
> @@ -72,10 +68,20 @@ SYM_FUNC_START(startup_32)
>  1:     popl    %ebp
>         subl    $1b, %ebp
>
> +       /* Load new GDT with the 64bit segments using 32bit descriptor */
> +       addl    %ebp, gdt+2(%ebp)
> +       lgdt    gdt(%ebp)
> +
> +       /* Load segment registers with our descriptors */
> +       movl    $__BOOT_DS, %eax
> +       movl    %eax, %ds
> +       movl    %eax, %es
> +       movl    %eax, %fs
> +       movl    %eax, %gs
> +       movl    %eax, %ss
> +
>  /* setup a stack and make sure cpu supports long mode. */
> -       movl    $boot_stack_end, %eax
> -       addl    %ebp, %eax
> -       movl    %eax, %esp
> +       leal    boot_stack_end(%ebp), %esp
>
>         call    verify_cpu
>         testl   %eax, %eax
> @@ -112,10 +118,6 @@ SYM_FUNC_START(startup_32)
>   * Prepare for entering 64 bit mode
>   */
>
> -       /* Load new GDT with the 64bit segments using 32bit descriptor */
> -       addl    %ebp, gdt+2(%ebp)
> -       lgdt    gdt(%ebp)
> -
>         /* Enable PAE mode */
>         movl    %cr4, %eax
>         orl     $X86_CR4_PAE, %eax
> @@ -232,9 +234,13 @@ SYM_FUNC_START(efi32_stub_entry)
>
>         movl    %ecx, efi32_boot_args(%ebp)
>         movl    %edx, efi32_boot_args+4(%ebp)
> -       sgdtl   efi32_boot_gdt(%ebp)
>         movb    $0, efi_is64(%ebp)
>
> +       /* Save firmware GDTR and code/data selectors */
> +       sgdtl   efi32_boot_gdt(%ebp)
> +       movw    %cs, efi32_boot_cs(%ebp)
> +       movw    %ds, efi32_boot_ds(%ebp)
> +
>         /* Disable paging */
>         movl    %cr0, %eax
>         btrl    $X86_CR0_PG_BIT, %eax
> --
> 2.24.1
>
