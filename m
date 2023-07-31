Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E77692C0
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGaKJ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGaKJ0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 06:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD09E5B;
        Mon, 31 Jul 2023 03:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDE260281;
        Mon, 31 Jul 2023 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A791C433D9;
        Mon, 31 Jul 2023 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690798159;
        bh=5rHHUGOreerrmHRm3cKNZohiRqZkwp2euIM0AZtdzwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZN2X46EdJKglkooOkqxMH48cWsnN0TKl6Ec0pCc2mRvRCbLxBaK0F25FtXJ4yPTQY
         MIUHVWYxe3Cp80IHpDgOyxdOll/lwtPCmVXjWhsBs0IPSgwNcOBQhnSmKod0OOCax7
         m1tEBt+kQ9+pP/L1wPX2oeE2GzmxK2XqwyBahQhIn32Qlx0dCJwTuU+pnSS1yypxqb
         MqZb71yiY7tVc/HhSxsaJYi1A0AUTCIxEnJ+QuIZbR3t2b5o8KcaGhjedSSg21j24t
         A3zgdrz+UxgQDPVb7PnAXfHuo98y3SK1EvfpxurQmAnuIGlad0aumgfmDfPrDQ/go6
         DG6XYqX6rSL6A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso7075806e87.2;
        Mon, 31 Jul 2023 03:09:19 -0700 (PDT)
X-Gm-Message-State: ABy/qLZINCwicdjk2Va9xrkyO7NY+SSfz0jtEOIHpfQwSUna1yp8iL4i
        GkO8L+EK9PEyPy00zx0d6j6gSw/axxkCZFHkuHg=
X-Google-Smtp-Source: APBJJlFbnkyoxWRAVyFInFTTLpu2k7NN1HKiQqpXl1/kb0OMeyOolBysuEPDoM9xBIoqq5VsTm5JRrHryl/wRzAs9Sc=
X-Received: by 2002:ac2:4426:0:b0:4fd:fed1:9030 with SMTP id
 w6-20020ac24426000000b004fdfed19030mr5783979lfl.24.1690798157023; Mon, 31 Jul
 2023 03:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-2-ardb@kernel.org>
 <20230731100713.GAZMeH0RvXfNclFqMO@fat_crate.local>
In-Reply-To: <20230731100713.GAZMeH0RvXfNclFqMO@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 12:09:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHOsAHPMSSAdGKR22-uN-jki7y5TcQOJ4GLue1z1kbtuw@mail.gmail.com>
Message-ID: <CAMj1kXHOsAHPMSSAdGKR22-uN-jki7y5TcQOJ4GLue1z1kbtuw@mail.gmail.com>
Subject: Re: [PATCH v7 01/22] x86/decompressor: Don't rely on upper 32 bits of
 GPRs being preserved
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 31 Jul 2023 at 12:07, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 28, 2023 at 11:08:55AM +0200, Ard Biesheuvel wrote:
> > The 4-to-5 level mode switch trampoline disables long mode and paging i=
n
> > order to be able to flick the LA57 bit. According to section 3.4.1.1 of
> > the x86 architecture manual [0], we should not rely on 64-bit GPRs
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>

Sure.

> > retaining the upper 32 bits of their contents across such a mode switch=
.
> >
> > Given that RBP, RBX and RSI are live at this point, let's preserve them
> > on the stack, along with the return address that might be above 4G as
> > well.
> >
> > [0] Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s=
 Manual, Volume 1: Basic Architecture
> >
> >   "Because the upper 32 bits of 64-bit general-purpose registers are
> >    undefined in 32-bit modes, the upper 32 bits of any general-purpose
> >    register are not preserved when switching from 64-bit mode to a 32-b=
it
> >    mode (to protected mode or compatibility mode). Software must not
> >    depend on these bits to maintain a value after a 64-bit to 32-bit
> >    mode switch."
> >
> > Fixes: 194a9749c73d650c ("x86/boot/compressed/64: Handle 5-level paging=
 boot if kernel is above 4G")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 23 +++++++++++++++-----
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compres=
sed/head_64.S
> > index 03c4328a88cbd5d0..f7c11a0018477de8 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -459,11 +459,22 @@ SYM_CODE_START(startup_64)
> >       /* Save the trampoline address in RCX */
> >       movq    %rax, %rcx
> >
> > +     /* Set up 32-bit addressable stack */
> > +     leaq    TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
> > +
> >       /*
> > -      * Load the address of trampoline_return() into RDI.
> > -      * It will be used by the trampoline to return to the main code.
> > +      * Load the address of trampoline_return() into RDI and push it o=
nto
> > +      * the stack so it will survive 32-bit truncation due to the 32-b=
it
>
> I think you should explain here what that SDM excerpt above says so that
> it is clear what "32-bit truncation" is meant.
>

Ok

> > +      * protected mode switch. It will be used by the trampoline to re=
turn
> > +      * to the main code.
> >        */
> >       leaq    trampoline_return(%rip), %rdi
> > +     pushq   %rdi
> > +
> > +     /* Preserve other live 64-bit registers */
> > +     pushq   %rbp
> > +     pushq   %rbx
> > +     pushq   %rsi
> >
> >       /* Switch to compatibility mode (CS.L =3D 0 CS.D =3D 1) via far r=
eturn */
> >       pushq   $__KERNEL32_CS
>
> What is more interesting is why is this trampoline crap unconditional?
>
> /me goes and does git archeology...
>
> 194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kern=
el is above 4G")
>
>     We go through the trampoline even if we don't have to: if we're alrea=
dy
>     in 5-level paging mode or if we don't need to switch to it. This way =
the
>     trampoline gets tested on every boot.
>
> Well, f*ck no.
>
> All my machines don't have 5level pages. And I bet 5level pages is still
> not in the majority of the machines out there.
>
> This all needs to be abstracted away into a separate function which
> exits early if no 5 level support.
>
> Kirill, please fix this.
>

This is already fixed further down in the series.
