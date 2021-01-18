Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728852FAB65
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jan 2021 21:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437908AbhARUZO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jan 2021 15:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437212AbhARUY6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jan 2021 15:24:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76EC061573;
        Mon, 18 Jan 2021 12:24:15 -0800 (PST)
Received: from zn.tnic (p200300ec2f069f0062c4736095b963a8.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9f00:62c4:7360:95b9:63a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E31721EC0283;
        Mon, 18 Jan 2021 21:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611001454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wg2C2nBbuOIoS8W3mFG5ELiW7MV2Ki338+OxxUJ5xdQ=;
        b=RtFIAxXornjPEFiX1Srlbb2t6bk2lF+oLnAzkcRMedV6rByl6aIGIv/lKOkbyBG70ahfWT
        jcHHlCmbrEyksnKcBp4vR2ZTQMgMan9kbBCDRpY/7cIv5QGBbkuj5DUKkrFVBT1UKjUmso
        QU0sy23k/qpjfFqEM3DWGBmXEpVwoK4=
Date:   Mon, 18 Jan 2021 21:24:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210118202409.GG30090@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 16, 2021 at 05:34:27PM +0100, Ard Biesheuvel wrote:
> On Fri, 15 Jan 2021 at 21:27, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Jan 15, 2021 at 02:07:51PM -0500, Arvind Sankar wrote:
> > > On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> > > >
> > > > x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> > > > efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
> > > >
> > > > Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> > > > and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> > > > so it only triggers for constant input.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/256
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/x86/platform/efi/efi_64.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > > > index e1e8d4e3a213..62bb1616b4a5 100644
> > > > --- a/arch/x86/platform/efi/efi_64.c
> > > > +++ b/arch/x86/platform/efi/efi_64.c
> > > > @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
> > > >      * As with PGDs, we share all P4D entries apart from the one entry
> > > >      * that covers the EFI runtime mapping space.
> > > >      */
> > > > -   BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > > > -   BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > > > +   MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > > > +   MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > > >
> > > >     pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
> > > >     pgd_k = pgd_offset_k(EFI_VA_END);
> > > > --
> > > > 2.29.2
> > > >
> > >
> > > I think this needs more explanation as to why clang is triggering this.
> > > The issue mentions clang not inline p4d_index(), and I guess not
> > > performing inter-procedural analysis either?
> > >
> > > For the second assertion there, everything is always constant AFAICT:
> > > EFI_VA_START, EFI_VA_END and P4D_MASK are all constants regardless of
> > > CONFIG_5LEVEL.
> > >
> > > For the first assertion, it isn't technically constant, but if
> > > p4d_index() gets inlined, the compiler should be able to see that the
> > > two are always equal, even though ptrs_per_p4d is not constant:
> > >       EFI_VA_END >> 39 == MODULES_END >> 39
> > > so the masking with ptrs_per_p4d-1 doesn't matter for the comparison.
> > >
> > > As a matter of fact, it seems like the four assertions could be combined
> > > into:
> > >       BUILD_BUG_ON((EFI_VA_END & P4D_MASK) != (MODULES_END & P4D_MASK));
> > >       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > > instead of separately asserting they're the same PGD entry and the same
> > > P4D entry.
> > >
> > > Thanks.
> >
> > I actually don't quite get the MODULES_END check -- Ard, do you know
> > what that's for?
> >
> 
> Maybe Boris remembers? He wrote the original code for the 'new' EFI
> page table layout.

That was added by Kirill for 5-level pgtables:

  e981316f5604 ("x86/efi: Add 5-level paging support")

 Documentation/x86/x86_64/mm.rst should explain the pagetable layout:

   ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
   ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
   ffffffff80000000 |-2048    MB |                  |         |
   ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
   ffffffffff000000 |  -16    MB |                  |         |
      FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset

That thing which starts at -512 GB above is the last PGD on the
pagetable. In it, between -4G and -68G there are 64G which are the EFI
region mapping space for runtime services.

Frankly I'm not sure what this thing is testing because the EFI VA range
is hardcoded and I can't imagine it being somewhere else *except* in the
last PGD.

Lemme add Kirill for clarification.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
