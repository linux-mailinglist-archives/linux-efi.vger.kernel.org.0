Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3576B3C7
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHALtU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjHALtI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 07:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3F11A;
        Tue,  1 Aug 2023 04:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2876155E;
        Tue,  1 Aug 2023 11:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F9C433CA;
        Tue,  1 Aug 2023 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690890546;
        bh=/EnFpJVOirRUmcSdhYmxqYtzYmk23apw6/a4SFiS2B8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QN99XNTwVXKMQRuZ0FeeyhHWtFRAWS0RLGxnj1uc1q6n6uH3I/oKlEmczVjdVrseS
         hrqlgiX6IwdlNpQ7XTGDy3ZpUm+3oxrlRV/OlE+ZRCvecShoLp+gH0QrOGkfgxmgE5
         gEOtAT51yDZf4yWVaAewvxNIuW+X69OvB4xvrReXmGTcEPtaO54JGH8IU6N2tV4BD7
         k8GPk3OJYVH6YLG7gT0yqFv/m7b94sjk861na3qK3k17x5qATLT4ruF4njOB6c/xwR
         BDrKMvWn2L/W0l24N9pIfMgR9lqtcsS8kJC8hhThGL8jmor91tUvYFbVVbftKyuv2U
         wc4K2gwcbJ0bQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe44955decso779608e87.1;
        Tue, 01 Aug 2023 04:49:06 -0700 (PDT)
X-Gm-Message-State: ABy/qLbf/NZlToRrc5FtRsJU7h8JiVOGF6KIyzzxUxaG4D5bCmaivy9d
        Qx797jpZd6uTkBNPftbPVkUSeghePH2NkFtB/Gk=
X-Google-Smtp-Source: APBJJlFrmZ8SVcqn3722N1Kq1jCOKWo0UUmwcxCKUeU+/3sKTSh5IyJMn9eA0ql2w0oTbGcJ1aSnShBGUlz+tSPH0nY=
X-Received: by 2002:a05:6512:1196:b0:4fd:fac4:2137 with SMTP id
 g22-20020a056512119600b004fdfac42137mr941579lfr.30.1690890544195; Tue, 01 Aug
 2023 04:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-13-ardb@kernel.org>
 <20230801114542.GEZMjwZne986ZxI6eG@fat_crate.local>
In-Reply-To: <20230801114542.GEZMjwZne986ZxI6eG@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Aug 2023 13:48:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyApdRYNmn7Px=faANXv6JXXTAvdPUToy3-H1UZg6-eQ@mail.gmail.com>
Message-ID: <CAMj1kXEyApdRYNmn7Px=faANXv6JXXTAvdPUToy3-H1UZg6-eQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/22] x86/decompressor: Call trampoline directly from
 C code
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Aug 2023 at 13:46, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 28, 2023 at 11:09:06AM +0200, Ard Biesheuvel wrote:
> > Instead of returning to the asm calling code to invoke the trampoline,
> > call it straight from the C code that sets the scene. That way, the
> > struct return type is no longer needed for returning two values, and the
> > call can be made conditional more cleanly in a subsequent patch.
> >
> > This means that all callee save 64-bit registers need to be preserved
> > and restored, as their contents may not survive the legacy mode switch.
> >
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S    | 28 +++++++-----------
> >  arch/x86/boot/compressed/pgtable_64.c | 30 ++++++++------------
> >  2 files changed, 23 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 1b0c61d1b389fd37..3f38db557112c155 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -430,24 +430,12 @@ SYM_CODE_START(startup_64)
> >  #endif
> >
> >       /*
> > -      * paging_prepare() sets up the trampoline and checks if we need to
> > -      * enable 5-level paging.
> > -      *
> > -      * paging_prepare() returns a two-quadword structure which lands
> > -      * into RDX:RAX:
> > -      *   - Address of the trampoline is returned in RAX.
> > -      *   - Non zero RDX means trampoline needs to enable 5-level
> > -      *     paging.
> > -      *
> > +      * set_paging_levels() updates the number of paging levels using a
>
> I'd say here "configure paging" or so.
>
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > index d66639c961b8eeda..649c51935fdec7ef 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
> >  unsigned int __section(".data") ptrs_per_p4d = 1;
> >  #endif
> >
> > -struct paging_config {
> > -     unsigned long trampoline_start;
> > -     unsigned long l5_required;
> > -};
> > -
> >  /* Buffer to preserve trampoline memory */
> >  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> >
> > @@ -29,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> >   * purposes.
> >   *
> >   * Avoid putting the pointer into .bss as it will be cleared between
> > - * paging_prepare() and extract_kernel().
> > + * set_paging_levels() and extract_kernel().
> >   */
> >  unsigned long *trampoline_32bit __section(".data");
> >
> > @@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
> >       return bios_start - TRAMPOLINE_32BIT_SIZE;
> >  }
> >
> > -struct paging_config paging_prepare(void *rmode)
> > +asmlinkage void set_paging_levels(void *rmode)
>
> So actually "paging_prepare" or "configure_paging" is more to the point
> than setting paging levels. When I see set_paging_levels() I wonder what
> levels are those and I have to look at the code and go, aaah, 5-level vs
> 4-level.
>

configure_5level_paging()? At least, that conveys to some extent that
nothing will happen unless the hardware supports it to begin with.
