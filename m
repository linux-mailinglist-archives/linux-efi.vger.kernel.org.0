Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9001754D8
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 08:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCBHtc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 02:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBHtb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 02:49:31 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C0B246B6
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135370;
        bh=F7Y2CSH9Vo747TuphhHP7GKkij3BinbARb2kByPkBGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jR6RNQXg06aaNBNURh/fYG5Q6Wz7Kb4sTf8GlFCbDd4NjmqBaMAqBiEJjeK/5uTFX
         q5xG4eTBEIfUYmpjntrp7N7Si1huGRhvadIzEIvO46cFxTvr7TUBwFPe47Ai5ak0Lp
         MG/NZwSEEcxyjwZLfi4RQoPZiNf7OkDgSnrVHsQg=
Received: by mail-wr1-f54.google.com with SMTP id z11so2443850wro.9
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 23:49:29 -0800 (PST)
X-Gm-Message-State: APjAAAVJNXOsKsL9R+xpavfXCV+f+nukXYQzK9tQ9l6Vp91jGtPKpkFt
        wLwPqXW0BvgSS5EOvx1xPVpiOPp2JnGTwrivP9ga6g==
X-Google-Smtp-Source: APXvYqx/9ZnowcmE3GP8PGqMzClr8fWOKRtWHduBTkfyOxrQ5OXiHjTjSmDuZkUFF8ZWkDZA9c84jyg1A2v4CflAeWM=
X-Received: by 2002:adf:a411:: with SMTP id d17mr20534370wra.126.1583135368426;
 Sun, 01 Mar 2020 23:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20200301230436.2246909-1-nivedita@alum.mit.edu> <20200301230436.2246909-4-nivedita@alum.mit.edu>
In-Reply-To: <20200301230436.2246909-4-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 08:49:17 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
Message-ID: <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi/x86: Make efi32_pe_entry more readable
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Setup a proper frame pointer in efi32_pe_entry so that it's easier to
> calculate offsets for arguments.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/head_64.S | 57 +++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 920daf62dac2..fabbd4c2e9f2 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -658,42 +658,65 @@ SYM_DATA(efi_is64, .byte 1)
>         .text
>         .code32
>  SYM_FUNC_START(efi32_pe_entry)
> +/*
> + * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
> + *                            efi_system_table_32_t *sys_table)
> + */
> +
>         pushl   %ebp
> +       movl    %esp, %ebp
> +       pushl   %eax                            // dummy push to allocate loaded_image
>
> -       pushl   %ebx
> +       pushl   %ebx                            // save callee-save registers
>         pushl   %edi
> +
>         call    verify_cpu                      // check for long mode support
> -       popl    %edi
> -       popl    %ebx
>         testl   %eax, %eax
>         movl    $0x80000003, %eax               // EFI_UNSUPPORTED
> -       jnz     3f
> +       jnz     2f
>
>         call    1f
> -1:     pop     %ebp
> -       subl    $1b, %ebp
> +1:     pop     %ebx
> +       subl    $1b, %ebx
>
>         /* Get the loaded image protocol pointer from the image handle */
> -       subl    $12, %esp                       // space for the loaded image pointer
> -       pushl   %esp                            // pass its address
> -       leal    loaded_image_proto(%ebp), %eax
> +       leal    -4(%ebp), %eax
> +       pushl   %eax                            // &loaded_image
> +       leal    loaded_image_proto(%ebx), %eax
>         pushl   %eax                            // pass the GUID address
> -       pushl   28(%esp)                        // pass the image handle
> +       pushl   8(%ebp)                         // pass the image handle
>
> -       movl    36(%esp), %eax                  // sys_table
> +       /*
> +        * Note the alignment of the stack frame.
> +        *   sys_table
> +        *   handle             <-- 16-byte aligned on entry by ABI
> +        *   return address
> +        *   frame pointer
> +        *   loaded_image       <-- local variable
> +        *   saved %ebx         <-- 16-byte aligned here
> +        *   saved %edi
> +        *   &loaded_image
> +        *   &loaded_image_proto
> +        *   handle             <-- 16-byte aligned for call to handle_protocol
> +        */
> +
> +       movl    12(%ebp), %eax                  // sys_table
>         movl    ST32_boottime(%eax), %eax       // sys_table->boottime
>         call    *BS32_handle_protocol(%eax)     // sys_table->boottime->handle_protocol
> -       cmp     $0, %eax
> +       addl    $12, %esp                       // restore argument space
> +       testl   %eax, %eax
>         jnz     2f
>
> -       movl    32(%esp), %ecx                  // image_handle
> -       movl    36(%esp), %edx                  // sys_table
> -       movl    12(%esp), %esi                  // loaded_image
> +       movl    8(%ebp), %ecx                   // image_handle
> +       movl    12(%ebp), %edx                  // sys_table
> +       movl    -4(%ebp), %esi                  // loaded_image
>         movl    LI32_image_base(%esi), %esi     // loaded_image->image_base
> +       movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry

The code that follows efi32_pe_stub_entry still expects the runtime
displacement in %ebp, so we'll need to pass that in another way here.

>         jmp     efi32_pe_stub_entry
>
> -2:     addl    $24, %esp
> -3:     popl    %ebp
> +2:     popl    %edi                            // restore callee-save registers
> +       popl    %ebx
> +       leave
>         ret
>  SYM_FUNC_END(efi32_pe_entry)
>
> --
> 2.24.1
>
