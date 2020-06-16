Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117F71FC16B
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFPWGx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 18:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgFPWGw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 18:06:52 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B116C2065F
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592345211;
        bh=JPnl8ZaA4oNgMVVkjlXKo1hbZS/MRgqPfqfSMFJmMp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jgcDmKJ9TWVqYhHsOJpljDhdinar5S9+yXCDeKtpWlQOcdMk68qSRuqOIq46yRzU+
         WnrbUDG6WyFQIB44qqWnDdROQHnUk+56qkdGTrlUsnuuV5q48jYZls3MH4npamexo+
         WwgyTSU6uU1jSv6ejxfed9cOm09XheZO90PPY5js=
Received: by mail-oi1-f170.google.com with SMTP id c194so20743562oig.5
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 15:06:51 -0700 (PDT)
X-Gm-Message-State: AOAM532nD82QiP08XLFsBSunozlEmCVV2WPd8+ArtY4tVTvJlI+7ItVQ
        f7D2DQPYJelsInaG6RFpHRlmF1T7aEBoYOul5mo=
X-Google-Smtp-Source: ABdhPJx2Mxv69xe6eB88z0Bn/kHS2TWtpuW9BXmtHCNk0OKahJVzDSqFgBbus6RqrZYyywNEtpSDPl+Pe5cHpVAlvhE=
X-Received: by 2002:aca:b241:: with SMTP id b62mr4941027oif.47.1592345211067;
 Tue, 16 Jun 2020 15:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
 <20200616194802.1718902-1-nivedita@alum.mit.edu>
In-Reply-To: <20200616194802.1718902-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 00:06:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-QA1oH_9BHP_PtESnXFS0em-7wJA5Nt+3SaB+e2H_MA@mail.gmail.com>
Message-ID: <CAMj1kXH-QA1oH_9BHP_PtESnXFS0em-7wJA5Nt+3SaB+e2H_MA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Setup stack correctly for efi_pe_entry
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Jun 2020 at 21:48, Arvind Sankar <nivedita@alum.mit.edu> wrote:
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
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Queued as a fix, thanks.


> ---
>  arch/x86/boot/compressed/head_64.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index e821a7d7d5c4..d073e3c919dd 100644
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
> --
> 2.26.2
>
