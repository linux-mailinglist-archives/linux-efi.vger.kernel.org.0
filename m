Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2591FCAF0
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQKdc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 06:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQKdc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Jun 2020 06:33:32 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4109E208B3
        for <linux-efi@vger.kernel.org>; Wed, 17 Jun 2020 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592390011;
        bh=X+CHsqSbVzTIE4t2FwIV8ECxOg7oyy78fJD979mqG5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jFQvt3IcvfsRnX/LmTCcEHq1qyTzd98np7hyNRW6z5UQecvzxdqWu1CkKuIIeHVFw
         7+PygrNkP6DuzWX6e0FIcR5vapz0CdkWobwxmtwEl6rTrZisAfgr0HnYI8EDDwEXRc
         0IjqzozB+W6qCKYBbJ+i/wiinvcSBcLDgJb6jraM=
Received: by mail-ot1-f48.google.com with SMTP id m2so1186559otr.12
        for <linux-efi@vger.kernel.org>; Wed, 17 Jun 2020 03:33:31 -0700 (PDT)
X-Gm-Message-State: AOAM531RCUfS1NuqjNmqIfKn9QzXYlDmKZf2PMHlY8+sDahwQ0UcWfRl
        +ubeFL/eJ7prZrfpW3RAzYbYRAIZrU+D2rtJEBE=
X-Google-Smtp-Source: ABdhPJyqXfnUY+wY8jbxp3yguyvHhC7yTgLhrSwvg9I5FD8nJFdAyBoCea48yw1rT3XkLgK1oHCOIR3FJ387NDXSj/k=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr5960527oth.90.1592390010613;
 Wed, 17 Jun 2020 03:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
 <20200616194802.1718902-1-nivedita@alum.mit.edu> <CAMj1kXH-QA1oH_9BHP_PtESnXFS0em-7wJA5Nt+3SaB+e2H_MA@mail.gmail.com>
In-Reply-To: <CAMj1kXH-QA1oH_9BHP_PtESnXFS0em-7wJA5Nt+3SaB+e2H_MA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 12:33:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGovNeVTm3sSwpk6Lqk=JkBq_gV0t3WKd1=kJ11+C2e5g@mail.gmail.com>
Message-ID: <CAMj1kXGovNeVTm3sSwpk6Lqk=JkBq_gV0t3WKd1=kJ11+C2e5g@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Setup stack correctly for efi_pe_entry
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 Jun 2020 at 00:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 16 Jun 2020 at 21:48, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit
> >   17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")
> > introduced a new entry point for the EFI stub to be booted in mixed mode
> > on 32-bit firmware.
> >
> > When entered via efi32_pe_entry, control is first transferred to
> > startup_32 to setup for the switch to long mode, and then the EFI stub
> > proper is entered via efi_pe_entry. efi_pe_entry is an MS ABI function,
> > and the ABI requires 32 bytes of shadow stack space to be allocated by
> > the caller, as well as the stack being aligned to 8 mod 16 on entry.
> >
> > Allocate 40 bytes on the stack before switching to 64-bit mode when
> > calling efi_pe_entry to account for this.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>
> Queued as a fix, thanks.
>

Shouldn't boot_stack_end be 16 byte aligned for this to work reliably?
This seems to work out in practice, as .bss is cacheline aligned, and
the heap and stack happen to be emitted first. but it would be better
to make this explicit.


>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index e821a7d7d5c4..d073e3c919dd 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
> >          * We place all of the values on our mini stack so lret can
> >          * used to perform that far jump.
> >          */
> > -       pushl   $__KERNEL_CS
> >         leal    startup_64(%ebp), %eax
> >  #ifdef CONFIG_EFI_MIXED
> >         movl    efi32_boot_args(%ebp), %edi
> > @@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
> >         movl    efi32_boot_args+8(%ebp), %edx   // saved bootparams pointer
> >         cmpl    $0, %edx
> >         jnz     1f
> > +       /*
> > +        * efi_pe_entry uses MS calling convention, which requires 32 bytes of
> > +        * shadow space on the stack even if all arguments are passed in
> > +        * registers. We also need an additional 8 bytes for the space that
> > +        * would be occupied by the return address, and this also results in
> > +        * the correct stack alignment for entry.
> > +        */
> > +       subl    $40, %esp
> >         leal    efi_pe_entry(%ebp), %eax
> >         movl    %edi, %ecx                      // MS calling convention
> >         movl    %esi, %edx
> >  1:
> >  #endif
> > +       pushl   $__KERNEL_CS
> >         pushl   %eax
> >
> >         /* Enter paged protected Mode, activating Long Mode */
> > --
> > 2.26.2
> >
