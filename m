Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9021FCE5A
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFQN0q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 09:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQN0q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Jun 2020 09:26:46 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EFF21532
        for <linux-efi@vger.kernel.org>; Wed, 17 Jun 2020 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592400405;
        bh=SKniCMflRhalTaCXWNmSfHB7YiT4uqGUNa2ieDIogUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwP7uoPb9No48WRQH348/ITdvIhKV7MscO10DEMeUnWrJiFZSBMc61oC0SsYR/8O0
         UFGM7XrV0YOmrcgeq3sMZ3sET5H27KJwbsWQH0Gaf3pTHebBn7L6rOv7RMJx84I2nd
         Av+a6OcDocRx/rUOWb8G0bkmqWXH7PAKXD5WTfJc=
Received: by mail-ot1-f54.google.com with SMTP id n5so1602299otj.1
        for <linux-efi@vger.kernel.org>; Wed, 17 Jun 2020 06:26:45 -0700 (PDT)
X-Gm-Message-State: AOAM530/RAsejRDbrSpjuAmjTksRByFWF9AKT1dnLV4wJV/bSi9EIU/V
        68eqDF0tzgMFuoUjD8bfTFIN6YYmBvQaa51ny1A=
X-Google-Smtp-Source: ABdhPJwPxUgMHR48huFgk1QJ5ABzqtKipAJiMGDYtNm9W47COpeh4wYl61hP+LONL7exW9O5SiiILxfBX7ti/zbW4us=
X-Received: by 2002:a9d:476:: with SMTP id 109mr7188623otc.77.1592400405126;
 Wed, 17 Jun 2020 06:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGovNeVTm3sSwpk6Lqk=JkBq_gV0t3WKd1=kJ11+C2e5g@mail.gmail.com>
 <20200617131957.2507632-1-nivedita@alum.mit.edu>
In-Reply-To: <20200617131957.2507632-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 15:26:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGfSKmWhq=bbcgBTSY29Z8EA3yL1vDmgoHBUeG8Vej0mA@mail.gmail.com>
Message-ID: <CAMj1kXGfSKmWhq=bbcgBTSY29Z8EA3yL1vDmgoHBUeG8Vej0mA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/x86: Setup stack correctly for efi_pe_entry
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 Jun 2020 at 15:20, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")
> introduced a new entry point for the EFI stub to be booted in mixed mode
> on 32-bit firmware.
>
> When entered via efi32_pe_entry, control is first transferred to
> startup_32 to setup for the switch to long mode, and then the EFI stub
> proper is entered via efi_pe_entry. efi_pe_entry is an MS ABI function,
> and the ABI requires 32 bytes of shadow stack space to be allocated by
> the caller, as well as the stack being aligned to 8 mod 16 on entry.
>
> Allocate 40 bytes on the stack before switching to 64-bit mode when
> calling efi_pe_entry to account for this.
>
> For robustness, explicitly align boot_stack_end to 16 bytes. It is
> currently implicitly aligned since .bss is cacheline-size aligned,
> head_64.o is the first object file with a .bss section, and the heap and
> boot sizes are aligned.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Cheers

> ---
>  arch/x86/boot/compressed/head_64.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index e821a7d7d5c4..97d37f0a34f5 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
>          * We place all of the values on our mini stack so lret can
>          * used to perform that far jump.
>          */
> -       pushl   $__KERNEL_CS
>         leal    startup_64(%ebp), %eax
>  #ifdef CONFIG_EFI_MIXED
>         movl    efi32_boot_args(%ebp), %edi
> @@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
>         movl    efi32_boot_args+8(%ebp), %edx   // saved bootparams pointer
>         cmpl    $0, %edx
>         jnz     1f
> +       /*
> +        * efi_pe_entry uses MS calling convention, which requires 32 bytes of
> +        * shadow space on the stack even if all arguments are passed in
> +        * registers. We also need an additional 8 bytes for the space that
> +        * would be occupied by the return address, and this also results in
> +        * the correct stack alignment for entry.
> +        */
> +       subl    $40, %esp
>         leal    efi_pe_entry(%ebp), %eax
>         movl    %edi, %ecx                      // MS calling convention
>         movl    %esi, %edx
>  1:
>  #endif
> +       pushl   $__KERNEL_CS
>         pushl   %eax
>
>         /* Enter paged protected Mode, activating Long Mode */
> @@ -784,6 +792,7 @@ SYM_DATA_LOCAL(boot_heap,   .fill BOOT_HEAP_SIZE, 1, 0)
>
>  SYM_DATA_START_LOCAL(boot_stack)
>         .fill BOOT_STACK_SIZE, 1, 0
> +       .balign 16
>  SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
>
>  /*
> --
> 2.26.2
>
