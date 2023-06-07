Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8D726A65
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFGUHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjFGUHo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 16:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DD18F;
        Wed,  7 Jun 2023 13:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025B864361;
        Wed,  7 Jun 2023 20:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DFAC433B0;
        Wed,  7 Jun 2023 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686168462;
        bh=HVYj9nLtynT8eZYNg1z6laWf7RmFoquRHr6FcRt+EJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qa48z7toqQEBc+tDRkRYrWIz7YEPg2bY778KsiZJ9gf5dc6rBe+jlth/trQpDWNeR
         VDbk7ZIoFH02AukciQISol2OwN//5Hj+dzzqxTSWDJcKLTkSW9orxqchWQY9HpKG6Y
         RuE9LOEyrHqCTC6N8djQC0/6jIi7qXWkDMhZVJbjauUTBV66sS2qpluByKwD9vYIvN
         oVbYV0heESnj1lqH+WLDEp6K78pm/emWmj4OU3ucj6YGmFRzfKecP7zUzv1ykiVQJq
         JdNH74oS1EHg5SiGnqDeq8p/UbiUpd28jiR0KWZmkAYssW6eLqaLnDTtM7qh3yyS5d
         J8D0eXlHgSfgQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so1084846e87.3;
        Wed, 07 Jun 2023 13:07:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDyEvw5HZVhs9F0kJHaE64/SPftLQpqvKtwys2MwxEKpm+k9OMYW
        ZKQvqbnGRpg96KDpBE+3aADs7UN9F0sgCq/UtBI=
X-Google-Smtp-Source: ACHHUZ4h/6mefSmajBHqQe49kuqJCgEirWhK4M5q5ww0spLgVE/Y6WF6vnil51Su+nIeQ4zr7uNLpPUWNfRAp5LP2IM=
X-Received: by 2002:a2e:b0db:0:b0:2b1:b7a1:fee with SMTP id
 g27-20020a2eb0db000000b002b1b7a10feemr2519296ljl.14.1686168460309; Wed, 07
 Jun 2023 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-9-ardb@kernel.org>
 <20230607193834.GC3110@yjiang5-mobl.amr.corp.intel.com>
In-Reply-To: <20230607193834.GC3110@yjiang5-mobl.amr.corp.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Jun 2023 22:07:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHBYhM80cuRizhwFBUnGH9XR7EBZBQfZ0g=4mk+nX8D+Q@mail.gmail.com>
Message-ID: <CAMj1kXHBYhM80cuRizhwFBUnGH9XR7EBZBQfZ0g=4mk+nX8D+Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] x86/decompressor: Use standard calling
 convention for trampoline
To:     Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Jun 2023 at 21:38, Yunhong Jiang
<yunhong.jiang@linux.intel.com> wrote:
>
> On Wed, Jun 07, 2023 at 09:23:30AM +0200, Ard Biesheuvel wrote:
> > Update the trampoline code so its arguments are passed via RDI and RSI,
> > which matches the ordinary SysV calling convention for x86_64. This will
> > allow this code to be called directly from C.
> >
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 30 +++++++++-----------
> >  arch/x86/boot/compressed/pgtable.h |  2 +-
> >  2 files changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index af45ddd8297a4a07..a387cd80964e1a1e 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -443,9 +443,9 @@ SYM_CODE_START(startup_64)
> >       movq    %r15, %rdi              /* pass struct boot_params pointer */
> >       call    paging_prepare
> >
> > -     /* Save the trampoline address in RCX */
> > -     movq    %rax, %rcx
> > -
> > +     /* Pass the trampoline address and boolean flag as args #1 and #2 */
> > +     movq    %rax, %rdi
> > +     movq    %rdx, %rsi
> >       leaq    TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
> >       call    *%rax
> >
> > @@ -534,11 +534,11 @@ SYM_FUNC_END(.Lrelocated)
> >  /*
> >   * This is the 32-bit trampoline that will be copied over to low memory.
> >   *
> > - * ECX contains the base address of the trampoline memory.
> > - * Non zero RDX means trampoline needs to enable 5-level paging.
> > + * EDI contains the base address of the trampoline memory.
> > + * Non-zero ESI means trampoline needs to enable 5-level paging.
> >   */
> >  SYM_CODE_START(trampoline_32bit_src)
>
> After the whole patchset, this function now only switch the paging level, is my
> understanding correct? After all, it's converted to toggle_la57 directly in the
> followed patches. If that's the case, would it makes sense to rename it
> correspondingly?
>

This is template code that is copied to a 32-bit addressable buffer
and called there.

> Also, to align with the toggle_la57, would we make the first parameter as just
> page table, instead of trampoline memory address?
>

Sure, but instead of rewriting this code from scratch, I decided to
make incremental changes to it, for easier review and bisect.

Of course, we could change the name, change the prototype, and another
thing we might do is drop the second argument, which is redundant now
that we always toggle and never preserve the existing value of LA57.

However, this was not necessary for making the code reusable from the
EFI stub, so I left it for further cleanup.

> > -     popq    %rdi
> > +     popq    %r8
> >       /* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
> >       pushq   $__KERNEL32_CS
> >       leaq    0f(%rip), %rax
> > @@ -552,7 +552,7 @@ SYM_CODE_START(trampoline_32bit_src)
> >       movl    %eax, %ss
> >
> >       /* Set up new stack */
> > -     leal    TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
> > +     leal    TRAMPOLINE_32BIT_STACK_END(%edi), %esp
> >
> >       /* Disable paging */
> >       movl    %cr0, %eax
> > @@ -560,7 +560,7 @@ SYM_CODE_START(trampoline_32bit_src)
> >       movl    %eax, %cr0
> >
> >       /* Check what paging mode we want to be in after the trampoline */
> > -     testl   %edx, %edx
> > +     testl   %esi, %esi
> >       jz      1f
> >
> >       /* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
> > @@ -575,21 +575,17 @@ SYM_CODE_START(trampoline_32bit_src)
> >       jz      3f
> >  2:
> >       /* Point CR3 to the trampoline's new top level page table */
> > -     leal    TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
> > +     leal    TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
> >       movl    %eax, %cr3
> >  3:
> >       /* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
> > -     pushl   %ecx
> > -     pushl   %edx
> >       movl    $MSR_EFER, %ecx
> >       rdmsr
> >       btsl    $_EFER_LME, %eax
> >       /* Avoid writing EFER if no change was made (for TDX guest) */
> >       jc      1f
> >       wrmsr
> > -1:   popl    %edx
> > -     popl    %ecx
> > -
> > +1:
> >  #ifdef CONFIG_X86_MCE
> >       /*
> >        * Preserve CR4.MCE if the kernel will enable #MC support.
> > @@ -606,14 +602,14 @@ SYM_CODE_START(trampoline_32bit_src)
> >
> >       /* Enable PAE and LA57 (if required) paging modes */
> >       orl     $X86_CR4_PAE, %eax
> > -     testl   %edx, %edx
> > +     testl   %esi, %esi
> >       jz      1f
> >       orl     $X86_CR4_LA57, %eax
> >  1:
> >       movl    %eax, %cr4
> >
> >       /* Calculate address of paging_enabled() once we are executing in the trampoline */
> > -     leal    .Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
> > +     leal    .Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
> >
> >       /* Prepare the stack for far return to Long Mode */
> >       pushl   $__KERNEL_CS
> > @@ -630,7 +626,7 @@ SYM_CODE_END(trampoline_32bit_src)
> >       .code64
> >  SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
> >       /* Return from the trampoline */
> > -     jmp     *%rdi
> > +     jmp     *%r8
> >  SYM_FUNC_END(.Lpaging_enabled)
> >
> >       /*
> > diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> > index 91dbb99203fbce2d..4e8cef135226bcbb 100644
> > --- a/arch/x86/boot/compressed/pgtable.h
> > +++ b/arch/x86/boot/compressed/pgtable.h
> > @@ -14,7 +14,7 @@
> >
> >  extern unsigned long *trampoline_32bit;
> >
> > -extern void trampoline_32bit_src(void *return_ptr);
> > +extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
> >
> >  #endif /* __ASSEMBLER__ */
> >  #endif /* BOOT_COMPRESSED_PAGETABLE_H */
> > --
> > 2.39.2
> >
