Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0090769500
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGaLgF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGaLgC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 07:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF351E66;
        Mon, 31 Jul 2023 04:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC5361077;
        Mon, 31 Jul 2023 11:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1C0C433CD;
        Mon, 31 Jul 2023 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690803360;
        bh=oE1D8TJVFZDdFJMBzELkSWrHUR5ubkXAgn9vix9XZVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Olt6AP6Z/kr1+/OOxJBJ1ZgxjK26NNnRTVH5pa9647IwnjcEQkRyEppiJX0OBkF7d
         EmAYILFXZcvtTk3fn54A3d0IVJGelFWk7dmFXxw61IU40Am3HknN8jGl+QjI/WvCsx
         +lnxb9Rffaro48HBxQ8g5avpa6hMOX50njGiEGIiGbSO5MX9+uy0O1oktz2EZnsRYD
         zDm3lXp6aJMGDp6245FQdx5HH4aSWKqKs2/zt36cKLrLBJZCX/8ptHVtntidKW7MZR
         a3oAlT82ILWpw3vu9mY77PsXfyWfE0MhBCP2+JH1tBMcbhB9/0BWW8KrqU4FIXCdHD
         TnX2pJBl2jQNA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so37111391fa.0;
        Mon, 31 Jul 2023 04:36:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLZZBmDIKCjlRZrnEajoVVRl7MgqAUixHZQ1mCNBFlS/H6C5RmYl
        Ksi/Q7hE1zofrs3EThXNgfmkCoz/Wvonxv2QSyY=
X-Google-Smtp-Source: APBJJlGpccRe76yFUtEoMSAokcGkgSh1DwVVReONKkEggf+aAU8XqoOwfZs0tor2Ygn8NIw0MfYa83XjV6z/f5mW328=
X-Received: by 2002:a05:651c:cd:b0:2b6:da61:d5b9 with SMTP id
 13-20020a05651c00cd00b002b6da61d5b9mr3315124ljr.14.1690803358472; Mon, 31 Jul
 2023 04:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-11-ardb@kernel.org>
 <20230731112842.GBZMea6qLHW+aZL3fB@fat_crate.local>
In-Reply-To: <20230731112842.GBZMea6qLHW+aZL3fB@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 13:35:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmcMMg48836CAxh551YDuOJebboTXq_szqX63gd6xOzQ@mail.gmail.com>
Message-ID: <CAMj1kXEmcMMg48836CAxh551YDuOJebboTXq_szqX63gd6xOzQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/22] x86/decompressor: Use standard calling
 convention for trampoline
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 31 Jul 2023 at 13:29, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 28, 2023 at 11:09:04AM +0200, Ard Biesheuvel wrote:
> > Update the trampoline code so its arguments are passed via RDI and RSI,
> > which matches the ordinary SysV calling convention for x86_64. This will
> > allow this code to be called directly from C.
> >
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 26 +++++++++-----------
> >  arch/x86/boot/compressed/pgtable.h |  2 +-
> >  2 files changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 1892679be2b6897a..491d985be75fd5b0 100644
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
> > @@ -534,15 +534,15 @@ SYM_FUNC_END(.Lrelocated)
> >  /*
> >   * This is the 32-bit trampoline that will be copied over to low memory.
> >   *
> > - * ECX contains the base address of the trampoline memory.
> > - * Non zero RDX means trampoline needs to enable 5-level paging.
> > + * EDI contains the base address of the trampoline memory.
> > + * Non-zero ESI means trampoline needs to enable 5-level paging.
> >   */
>
> This is confusing - this talks about 32-bit and 32-bit registers but
> uses the 64-bit calling convention because it gets called by 64-bit
> code. Please add a short sentence clarifying that.
>

Ok
