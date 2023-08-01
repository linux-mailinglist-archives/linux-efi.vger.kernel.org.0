Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7022376B470
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjHAMLi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHAMLh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 08:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA417173A;
        Tue,  1 Aug 2023 05:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E57E61587;
        Tue,  1 Aug 2023 12:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D7FC43395;
        Tue,  1 Aug 2023 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690891895;
        bh=OYOL7Hw5oR70E4y5roEPOfitJ0N6mzz1nz14ilOpiZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=itkt8QgTndT6VYDeChXDKnc0qjMtppNb764IozPZuI/3dmnRrvHDEm1BvdYc4ebFe
         +fM06J4/Yaa+whTYjdcGZItAXtErWrDv8zqT7FKnGaVOTGqgiLWMtRIgtTLDryEH+w
         Xf/xPRmeIkdgV8XyvcGK0DatGYyBZm63L2YaQdAmVyvBpUr7ta5T4GIaM1eWVI6G+x
         q8cpyzkAxH7HnAd4rtn3lk8vtQ5Xf9yrptAoTpav8cJW+iwySmyksWDY+UP1MleuUr
         oIZ03p7Hx9x9i0H8NvVf5cAr/BcVX03MnX+D9aosLyY4lcZRbpOfUCp+IA9iW6sYsR
         8ROeAtAyvLRTQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so944834e87.3;
        Tue, 01 Aug 2023 05:11:35 -0700 (PDT)
X-Gm-Message-State: ABy/qLYequrxWzyi8RrDgx9g4ud0V0nACa9XbGG+qWQTV+k1AsGV341C
        1YNuvC6p2udRQrxx/+vikGr/A6dSq5auQVzH638=
X-Google-Smtp-Source: APBJJlE0js/FEHRKQdx2Jntw/hUtRYnfsdHU9E2jQGmW0IomWyErlWw/LM2BQ5DFD97hDonmrpLxIq+6OOFCO0Ijt80=
X-Received: by 2002:a05:6512:280c:b0:4f6:d7b:2f19 with SMTP id
 cf12-20020a056512280c00b004f60d7b2f19mr2317615lfb.24.1690891893656; Tue, 01
 Aug 2023 05:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-15-ardb@kernel.org>
 <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local>
In-Reply-To: <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Aug 2023 14:11:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
Message-ID: <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
Subject: Re: [PATCH v7 14/22] x86/decompressor: Merge trampoline cleanup with
 switching code
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

On Tue, 1 Aug 2023 at 14:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 28, 2023 at 11:09:08AM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > index 4016444e6788304f..4f50af23a0854f18 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -101,9 +101,10 @@ static unsigned long find_trampoline_placement(void)
> >       return bios_start - TRAMPOLINE_32BIT_SIZE;
> >  }
> >
> > -asmlinkage void set_paging_levels(void *rmode)
> > +asmlinkage void set_paging_levels(void *rmode, void *pgtable)
>
> Please get rid of this silly rmode arg which gets passed in here as
> boot_params and then gets assigned to an extern pointer to boot_params.
> This is just silly. Just do what the other functions get from %r15 now
> - a struct boot_params *bp arg.
>
> But perhaps in a separate patch.
>

OK

> >  {
> >       void (*toggle_la57)(void *trampoline, bool enable_5lvl);
> > +     void *trampoline_pgtable;
> >       bool l5_required = false;
> >
> >       /* Initialize boot_params. Required for cmdline_find_option_bool(). */
> > @@ -133,7 +134,7 @@ asmlinkage void set_paging_levels(void *rmode)
> >        * the desired one.
> >        */
> >       if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
> > -             return;
> > +             goto out;
> >
> >       trampoline_32bit = (unsigned long *)find_trampoline_placement();
> >
> > @@ -163,6 +164,8 @@ asmlinkage void set_paging_levels(void *rmode)
> >        * The new page table will be used by trampoline code for switching
> >        * from 4- to 5-level paging or vice versa.
> >        */
> > +     trampoline_pgtable = trampoline_32bit +
> > +                          TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
> >
> >       if (l5_required) {
> >               /*
> > @@ -182,31 +185,21 @@ asmlinkage void set_paging_levels(void *rmode)
> >                * may be above 4G.
> >                */
> >               src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
> > -             memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
> > -                    (void *)src, PAGE_SIZE);
> > +             memcpy(trampoline_pgtable, (void *)src, PAGE_SIZE);
> >       }
> >
> >       toggle_la57(trampoline_32bit, l5_required);
> > -}
> > -
> > -void cleanup_trampoline(void *pgtable)
> > -{
> > -     void *trampoline_pgtable;
> > -
> > -     trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
> >
> >       /*
> > -      * Move the top level page table out of trampoline memory,
> > -      * if it's there.
> > +      * Move the top level page table out of trampoline memory.
> >        */
> > -     if ((void *)__native_read_cr3() == trampoline_pgtable) {
> > -             memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
> > -             native_write_cr3((unsigned long)pgtable);
> > -     }
> > +     memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
> > +     native_write_cr3((unsigned long)pgtable);
> >
> >       /* Restore trampoline memory */
> >       memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
> >
> > +out:
> >       /* Initialize variables for 5-level paging */
> >  #ifdef CONFIG_X86_5LEVEL
> >       if (__read_cr4() & X86_CR4_LA57) {
> > @@ -215,4 +208,5 @@ void cleanup_trampoline(void *pgtable)
> >               ptrs_per_p4d = 512;
> >       }
> >  #endif
> > +     return;
>
> No need for that one. It'll return without it. :-)
>

Removing it breaks the build for !CONFIG_X86_5LEVEL

However, I can move these assignments into the conditional at the top
of the function (the one that sets l5_required) so we don't need the
label at all. Will fix for v8
