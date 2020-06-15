Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E931F941D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgFOJ64 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 05:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgFOJ64 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 05:58:56 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790602068E
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592215135;
        bh=FT3s2B5eOyvh+aASlH/slbTcpITWTnoP9JUAT91ISiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NrbwBq6cPs7VIfFBRWEgPX+QvzZqWMchuf8CzwVG0w+qDzcVGHTeMNifa+Wd9+J6J
         JcHBiuPElINuyinV6QJ4d877DYyKb2XWcrvr+QGGOJ+AvG/gZh0K5NU2JjttBmJyCs
         XfRnGp+inNccKklGYYqHWnPBTfxTVlytkbJ/WNp8=
Received: by mail-ot1-f53.google.com with SMTP id n70so12646247ota.5
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 02:58:55 -0700 (PDT)
X-Gm-Message-State: AOAM532dinLt6ugbOPNhsLx59OTfKk68lbHdufFl3pJdYn7HzvDLakn4
        XgRMcxXRerdJzAmUNsBaBQ+DaUTjazPoFQce81g=
X-Google-Smtp-Source: ABdhPJyZM+1CySjseKRDRrJYquI26bnjEeOwDZFO4EjxDj9IqiqKVk6e9CqaWQH/y27wGmvxuGurTGLWY3Cbgt3NBDg=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr20750650otc.108.1592215134802;
 Mon, 15 Jun 2020 02:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200526170226.2371024-1-nivedita@alum.mit.edu> <20200526170226.2371024-2-nivedita@alum.mit.edu>
In-Reply-To: <20200526170226.2371024-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 11:58:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
Message-ID: <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/x86: Use firmware stack for mixed-mode EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 26 May 2020 at 19:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The UEFI specification requires a 128KiB stack during boot services. On
> a native mode boot, the EFI stub executes on the firmware stack.
> However, on a mixed-mode boot, startup_32 switches to the kernel's boot
> stack, which is only 16KiB, and the EFI stub is executed with this
> stack.
>
> To avoid any potential problems with running out of stack space, save
> and restore the UEFI stack pointer in the mixed-mode entry, so that the
> EFI stub can use the firmware stack in this case as well.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

This does not apply onto v5.8-rc1, and I was going to take it as a fix.

However, are we sure this is safe? Do we have a ballpark figure of how
much stack we use in the stub?

This is one of those things I am reluctant to change, given that we
are not sure that firmware implementations conform to this, and IA32
firmware was not designed to boot a 64-bit image (which might use more
stack space?)


> ---
>  arch/x86/boot/compressed/head_64.S | 46 ++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 4b7ad1dfbea6..923e5c381804 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -237,21 +237,7 @@ SYM_FUNC_START(startup_32)
>          * used to perform that far jump.
>          */
>         pushl   $__KERNEL_CS
> -       leal    rva(startup_64)(%ebp), %eax
> -#ifdef CONFIG_EFI_MIXED
> -       movl    rva(efi32_boot_args)(%ebp), %edi
> -       cmp     $0, %edi
> -       jz      1f
> -       leal    rva(efi64_stub_entry)(%ebp), %eax
> -       movl    rva(efi32_boot_args+4)(%ebp), %esi
> -       movl    rva(efi32_boot_args+8)(%ebp), %edx      // saved bootparams pointer
> -       cmpl    $0, %edx
> -       jnz     1f
> -       leal    rva(efi_pe_entry)(%ebp), %eax
> -       movl    %edi, %ecx                      // MS calling convention
> -       movl    %esi, %edx
> -1:
> -#endif
> +       leal    rva(.L64bit)(%ebp), %eax
>         pushl   %eax
>
>         /* Enter paged protected Mode, activating Long Mode */
> @@ -260,6 +246,31 @@ SYM_FUNC_START(startup_32)
>
>         /* Jump from 32bit compatibility mode into 64bit mode. */
>         lret
> +
> +       .code64
> +SYM_INNER_LABEL(.L64bit, SYM_L_LOCAL)
> +#ifndef CONFIG_EFI_MIXED
> +       jmp     startup_64
> +#else
> +       movl    efi32_boot_args(%rip), %edi
> +       testl   %edi, %edi
> +       jz      startup_64
> +
> +       /* Restore firmware stack pointer */
> +       movl    efi32_boot_sp(%rip), %esp
> +       /* and align it to 8 mod 16 */
> +       andl    $~0xf, %esp
> +       subl    $8, %esp
> +
> +       movl    efi32_boot_args+4(%rip), %esi
> +       movl    efi32_boot_args+8(%rip), %edx   // saved bootparams pointer
> +       testl   %edx, %edx
> +       jnz     efi64_stub_entry
> +       movl    %edi, %ecx                      // MS calling convention
> +       movl    %esi, %edx
> +       jmp     efi_pe_entry
> +#endif
> +       .code32
>  SYM_FUNC_END(startup_32)
>
>  #ifdef CONFIG_EFI_MIXED
> @@ -285,6 +296,9 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>         movw    %cs, rva(efi32_boot_cs)(%ebp)
>         movw    %ds, rva(efi32_boot_ds)(%ebp)
>
> +       /* Save firmware stack pointer */
> +       movl    %esp, rva(efi32_boot_sp)(%ebp)
> +
>         /* Disable paging */
>         movl    %cr0, %eax
>         btrl    $X86_CR0_PG_BIT, %eax
> @@ -648,6 +662,7 @@ SYM_DATA(image_offset, .long 0)
>
>  #ifdef CONFIG_EFI_MIXED
>  SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
> +SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
>  SYM_DATA(efi_is64, .byte 1)
>
>  #define ST32_boottime          60 // offsetof(efi_system_table_32_t, boottime)
> @@ -710,6 +725,7 @@ SYM_FUNC_START(efi32_pe_entry)
>         movl    12(%ebp), %edx                  // sys_table
>         movl    -4(%ebp), %esi                  // loaded_image
>         movl    LI32_image_base(%esi), %esi     // loaded_image->image_base
> +       leave                                   // clear stack frame
>         movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
>         /*
>          * We need to set the image_offset variable here since startup_32() will
> --
> 2.26.2
>
