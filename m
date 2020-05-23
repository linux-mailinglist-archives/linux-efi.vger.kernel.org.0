Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4791DFB63
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgEWWke (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 18:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgEWWke (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 23 May 2020 18:40:34 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5286120727
        for <linux-efi@vger.kernel.org>; Sat, 23 May 2020 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590273633;
        bh=3qFSmgBy7WUYUXpsz11QJksNe70M2ykH+i+ZZ2dtm+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R4P8pSf5Tljc70bXW0VSALVqwtmZkP19ra6z7AuxHz85wLL6rYTzaWahIrqkVzzlV
         faQVqf2ZkawE+UIIbEnhHm1Vb/1f9/c1eZlMwgcpHFoi316pqY1j7ls2iegDQiye26
         ts99W777bAw42LEBcNKV7SvFQBjGiQl/MNIm2XHQ=
Received: by mail-io1-f53.google.com with SMTP id o5so15289215iow.8
        for <linux-efi@vger.kernel.org>; Sat, 23 May 2020 15:40:33 -0700 (PDT)
X-Gm-Message-State: AOAM532LeSYH9eQTxtIHdHb9sDCsKJYIHRIyE92LT4kbJwa21D9ON1gi
        sOUqsO/u6N3Mc5Z7YihU7IgaVH7GwC6cnFtAvOY=
X-Google-Smtp-Source: ABdhPJwaVe3Tp15ckz2YhC/KQa1X7pc2ASIOA8hfj1M4in97KKwnQ/p2tpB81jIJy+2dg2hmTPZymRjguLFN9hgtkD0=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr8207893ior.16.1590273632759;
 Sat, 23 May 2020 15:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200523221513.1642948-1-nivedita@alum.mit.edu>
In-Reply-To: <20200523221513.1642948-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 May 2020 00:40:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHukWAayiYQX3WKAaBbeV3L_ZXsjms+SKsb4xp2q1XeSg@mail.gmail.com>
Message-ID: <CAMj1kXHukWAayiYQX3WKAaBbeV3L_ZXsjms+SKsb4xp2q1XeSg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Drop the special GDT for the EFI thunk
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 24 May 2020 at 00:15, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Instead of using efi_gdt64 to switch back to 64-bit mode and then
> switching to the real boot-time GDT, just switch to the boot-time GDT
> directly. The two GDT's are identical other than efi_gdt64 not including
> the 32-bit code segment.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Queued, thanks.

> ---
>  arch/x86/boot/compressed/efi_thunk_64.S | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
> index 2b2049259619..c4bb0f9363f5 100644
> --- a/arch/x86/boot/compressed/efi_thunk_64.S
> +++ b/arch/x86/boot/compressed/efi_thunk_64.S
> @@ -28,8 +28,6 @@ SYM_FUNC_START(__efi64_thunk)
>         push    %rbx
>
>         leaq    1f(%rip), %rbp
> -       leaq    efi_gdt64(%rip), %rbx
> -       movl    %ebx, 2(%rbx)           /* Fixup the gdt base address */
>
>         movl    %ds, %eax
>         push    %rax
> @@ -48,7 +46,8 @@ SYM_FUNC_START(__efi64_thunk)
>         movl    %r8d, 0xc(%rsp)
>         movl    %r9d, 0x10(%rsp)
>
> -       sgdt    0x14(%rsp)
> +       leaq    0x14(%rsp), %rbx
> +       sgdt    (%rbx)
>
>         /*
>          * Switch to gdt with 32-bit segments. This is the firmware GDT
> @@ -68,8 +67,7 @@ SYM_FUNC_START(__efi64_thunk)
>         pushq   %rax
>         lretq
>
> -1:     lgdt    0x14(%rsp)
> -       addq    $32, %rsp
> +1:     addq    $32, %rsp
>         movq    %rdi, %rax
>
>         pop     %rbx
> @@ -175,14 +173,3 @@ SYM_DATA_END(efi32_boot_cs)
>  SYM_DATA_START(efi32_boot_ds)
>         .word   0
>  SYM_DATA_END(efi32_boot_ds)
> -
> -SYM_DATA_START(efi_gdt64)
> -       .word   efi_gdt64_end - efi_gdt64
> -       .long   0                       /* Filled out by user */
> -       .word   0
> -       .quad   0x0000000000000000      /* NULL descriptor */
> -       .quad   0x00af9a000000ffff      /* __KERNEL_CS */
> -       .quad   0x00cf92000000ffff      /* __KERNEL_DS */
> -       .quad   0x0080890000000000      /* TS descriptor */
> -       .quad   0x0000000000000000      /* TS continued */
> -SYM_DATA_END_LABEL(efi_gdt64, SYM_L_LOCAL, efi_gdt64_end)
> --
> 2.26.2
>
