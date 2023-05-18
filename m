Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82028708462
	for <lists+linux-efi@lfdr.de>; Thu, 18 May 2023 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjERO51 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 May 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjERO4z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 May 2023 10:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E91FE6;
        Thu, 18 May 2023 07:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6721165001;
        Thu, 18 May 2023 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5DC433EF;
        Thu, 18 May 2023 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421768;
        bh=yC1q2lmvQjUSReD7N0Uo4kMc1+QDGL5VVCy7s1obnkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Piyb3MXkTWiyfdtcgxnfoOV3tTtXBdkcFE3OSX6Eu47XmD/Z6Z60UTPbaNHH0exOm
         0JIFfaa656yPYz/DBBp+24wqQD/k5THt2uJsV3JgDrMpEjNv6akZmF7MwXVY8Rgfzx
         Zhj+jVardbBUTGygkqKwiEU9AMYrzW94OgltjwmwiTgWaIzTajdaoTvMOZ2uyGcUVa
         +I0i2bQfHyY3oIfsL5NvcIemq1sT2eEareQBH/eLrxPw2XR2RdMiRMF3WMl0Xbxx8N
         d1H1Z3nwVwd+3uC1kh0pkpmzMkHXwOcQz5UYgcUMH+ViRUtnohdptEoLoxgCOpcot2
         jeCUfjhWSED9A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f24ceae142so2407662e87.3;
        Thu, 18 May 2023 07:56:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDxL7R30XtLmVW+SM7VgBiJBYjDkQj3aEHLxwzCC+mnT1gSkuLj+
        G0igIM9ysI1Febq31DsOVITmRSo0K/wkSs55Xdw=
X-Google-Smtp-Source: ACHHUZ7stjYfkb0GNkJmX/kWbfG3nyxAT6BIIbgmqhwZQn6FEW6jnX63A3+4Nf/egutzo/3170vVk0EV5GR+emFAM+8=
X-Received: by 2002:a19:f80e:0:b0:4f1:4ed6:4a6e with SMTP id
 a14-20020a19f80e000000b004f14ed64a6emr1562627lff.28.1684421766869; Thu, 18
 May 2023 07:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-6-ardb@kernel.org>
 <6f858998-bb56-689b-76a7-0952d73f5ab8@amd.com>
In-Reply-To: <6f858998-bb56-689b-76a7-0952d73f5ab8@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 May 2023 16:55:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjgrTs8m5XeCm0JqBfkk0pytQpNx0SFd=878onEAbxeQ@mail.gmail.com>
Message-ID: <CAMj1kXHjgrTs8m5XeCm0JqBfkk0pytQpNx0SFd=878onEAbxeQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] x86: decompressor: Avoid the need for a stack in
 the 32-bit trampoline
To:     Tom Lendacky <thomas.lendacky@amd.com>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, 18 May 2023 at 00:40, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/8/23 02:03, Ard Biesheuvel wrote:
> > The 32-bit trampoline no longer uses the stack for anything except
> > performing a long return back to long mode. Currently, this stack is
> > allocated in the same page that carries the trampoline code, which means
> > this page must be mapped writable and executable, and the stack is
> > therefore executable as well.
> >
> > So let's do a long jump instead: that way, we can pre-calculate the
> > return address and poke it into the code before we call it. In a later
> > patch, we will take advantage of this by removing writable permissions
> > (and adding executable ones) explicitly when booting via the EFI stub.
> >
> > Not playing with the stack pointer also makes it more straight-forward
> > to call the trampoline code as an ordinary 64-bit function from C code.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   arch/x86/boot/compressed/head_64.S    | 34 ++++----------------
> >   arch/x86/boot/compressed/pgtable.h    |  6 ++--
> >   arch/x86/boot/compressed/pgtable_64.c | 12 ++++++-
> >   3 files changed, 21 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index b1f8a867777120bb..3b5fc851737ffc39 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -460,9 +460,6 @@ SYM_CODE_START(startup_64)
> >       leaq    TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
> >       call    *%rax
> >
> > -     /* Restore the stack, the 32-bit trampoline uses its own stack */
> > -     leaq    rva(boot_stack_end)(%rbx), %rsp
> > -
> >       /*
> >        * cleanup_trampoline() would restore trampoline memory.
> >        *
> > @@ -563,24 +560,17 @@ SYM_FUNC_END(.Lrelocated)
> >    * EDI contains the base address of the trampoline memory.
> >    * Non-zero ESI means trampoline needs to enable 5-level paging.
> >    */
> > +     .section ".rodata", "a", @progbits
> >   SYM_CODE_START(trampoline_32bit_src)
> > -     popq    %r8
> >       /* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
> >       pushq   $__KERNEL32_CS
> >       leaq    0f(%rip), %rax
> >       pushq   %rax
> >       lretq
> > +.Lret:       retq
>
> Maybe just add a comment above this to explain that this is a target of
> the long jump below to get back into long mode and be able to return
> without setting up a new stack for the 32-bit code.
>
> And then a corresponding comment on the long jump itself. I think it would
> make it easier to understand what is going on in this part of the code.
>

Fair point. I'll add that in the next version.
