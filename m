Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB2690D88
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBIPtZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 10:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjBIPtJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 10:49:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8CD658FE
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 07:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525C46195F
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 15:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5A7C433D2;
        Thu,  9 Feb 2023 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675957735;
        bh=d0cr5zp8UVGhD1K/k24duyIvnyEWqmNCPkFTqSYFItc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgpzXPk2JaQMUjN6Z/Suo/4wvBvWDouHN41/e0tVLkTzPQ5fJiLAEXuogwGA+cZYQ
         1O6xJuxeUoRhaWwdG3ZEKz8xBF37L8zo3o+MH5YqSbqT97+t3dtRITZ3cPQ1pOAzKL
         pIaDLwEJN3ojwkVvl+jl/EpRq5GqcyQeSeSi1CFa7jywBKbiG2biPgRKNnvu1d/4VP
         F2o+tqdCPf69918sLt+ee249jH6WX2xfi0La3y5prIuBv193OM5kxGj5zH9wFDB8QN
         KpT0wxtaKtJvn3aBDHC6aviR+t2D2cCbBJPWbPONBp9KD64DeBtysRIzpiTaLnc9f2
         ThVFQ6DiTFv/w==
Date:   Thu, 9 Feb 2023 15:48:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
Message-ID: <20230209154849.GA14628@willie-the-truck>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-3-ardb@kernel.org>
 <20230208130007.GA13529@willie-the-truck>
 <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
 <Y+Owvx0e24gZb7hy@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXG5iG=ok_nWnt7Tj5-Evwen4VvOQoNpVHh5mPU2mbCDWQ@mail.gmail.com>
 <CAMj1kXF8VQSMHhcO0o5SzfvJmdUnUBWaOMiiTtbTvbwpRwOu-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8VQSMHhcO0o5SzfvJmdUnUBWaOMiiTtbTvbwpRwOu-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 09, 2023 at 03:21:55PM +0100, Ard Biesheuvel wrote:
> On Wed, 8 Feb 2023 at 15:36, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 8 Feb 2023 at 15:25, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Wed, Feb 08, 2023 at 02:03:45PM +0100, Ard Biesheuvel wrote:
> > > > On Wed, 8 Feb 2023 at 14:00, Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > On Mon, Feb 06, 2023 at 01:49:37PM +0100, Ard Biesheuvel wrote:
> > > > > > UEFI v2.10 extends the EFI memory attributes table with a flag that
> > > > > > indicates whether or not all RuntimeServicesCode regions were
> > > > > > constructed with BTI landing pads, permitting the OS to map these
> > > > > > regions with BTI restrictions enabled.
> > > > > >
> > > > > > So let's take this into account on arm64.
> > > > > >
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > > > ---
> > > > > >  arch/arm64/kernel/efi.c   | 14 ++++++++++++--
> > > > > >  arch/arm64/kernel/traps.c |  6 ++++++
> > > > > >  2 files changed, 18 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > > > > > index 78ffd5aaddcbbaee..99971cd349f36310 100644
> > > > > > --- a/arch/arm64/kernel/efi.c
> > > > > > +++ b/arch/arm64/kernel/efi.c
> > > > > > @@ -96,15 +96,23 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +struct set_perm_data {
> > > > > > +     const efi_memory_desc_t *md;
> > > > > > +     bool                    has_bti;
> > > > > > +};
> > > > > > +
> > > > > >  static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
> > > > > >  {
> > > > > > -     efi_memory_desc_t *md = data;
> > > > > > +     struct set_perm_data *spd = data;
> > > > > > +     const efi_memory_desc_t *md = spd->md;
> > > > > >       pte_t pte = READ_ONCE(*ptep);
> > > > > >
> > > > > >       if (md->attribute & EFI_MEMORY_RO)
> > > > > >               pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> > > > > >       if (md->attribute & EFI_MEMORY_XP)
> > > > > >               pte = set_pte_bit(pte, __pgprot(PTE_PXN));
> > > > > > +     else if (system_supports_bti() && spd->has_bti)
> > > > >
> > > > > system_supports_bti() seems to check CONFIG_ARM64_BTI rather than
> > > > > CONFIG_ARM64_BTI_KERNEL. In theory, I think this means we could have
> > > > > mismatched BTI support, so it might be slightly more robust to use the
> > > > > latter option here even thought the runtime services aren't kernel code.
> > > > >
> > > > > What do you think?
> > > >
> > > > v1 checked for CONFIG_ARM64_BTI_KERNEL as well, but I dropped it
> > > > because we can do the enforcement even without it.
> > > >
> > > > I'm not sure how mismatched BTI support factors into that, though,
> > > > given that CONFIG_ARM64_BTI_KERNEL is set at compile time. You mean
> > > > mismatched between cores, right?
> > >
> > > I believe that there's no issue with mismatched CPUs, but there *might* might
> > > be a different issue with the ordering of feature detection and usage of the
> > > cap:
> > >
> > > * If CONFIG_ARM64_BTI_KERNEL=y, then the ARM64_BTI cap is detected as a strict
> > >   boot cpu feature, and secondaries without it will be rejected.
> > >
> > > * If CONFIG_ARM64_BTI_KERNEL=n then the ARM64_BTI cap is detected as a system
> > >   feature, and so we only set the cap bit after bringing all secondary CPUs
> > >   online, and only when *all* CPUs support it.
> > >
> > >   The happens under setup_cpu_features(), called from smp_cpus_done().
> > >
> > > So there's no issue with mismatch, but if system_supports_bti is called before
> > > smp_cpus_done() on a CONFIG_ARM64_BTI_KERNEL kernel it will return false. When
> > > do we set up the EFI mappings relative to that?
> > >
> >
> > Currently it is an early initcall so before SMP, but that is not
> > really necessary - the EFI table that carries this annotation is an
> > overlay that could easily be applied later.
> >
> > OTOH, what is the penalty for setting the GP attribute and using the
> > translation table on a core that does not implement BTI?
> 
> I'll merge this with the CONFIG_ARM64_BTI_KERNEL check re-added, if
> nobody minds?

Reviewed-by: Will Deacon <will@kernel.org>

Will
