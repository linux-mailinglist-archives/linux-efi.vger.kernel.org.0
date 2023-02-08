Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989F68F0AB
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 15:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBHOZV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 09:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjBHOZT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 09:25:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00794B185
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 06:25:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB2711042;
        Wed,  8 Feb 2023 06:25:52 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8D8D3F8C6;
        Wed,  8 Feb 2023 06:25:08 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:25:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
Message-ID: <Y+Owvx0e24gZb7hy@FVFF77S0Q05N.cambridge.arm.com>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-3-ardb@kernel.org>
 <20230208130007.GA13529@willie-the-truck>
 <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 08, 2023 at 02:03:45PM +0100, Ard Biesheuvel wrote:
> On Wed, 8 Feb 2023 at 14:00, Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Feb 06, 2023 at 01:49:37PM +0100, Ard Biesheuvel wrote:
> > > UEFI v2.10 extends the EFI memory attributes table with a flag that
> > > indicates whether or not all RuntimeServicesCode regions were
> > > constructed with BTI landing pads, permitting the OS to map these
> > > regions with BTI restrictions enabled.
> > >
> > > So let's take this into account on arm64.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/arm64/kernel/efi.c   | 14 ++++++++++++--
> > >  arch/arm64/kernel/traps.c |  6 ++++++
> > >  2 files changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > > index 78ffd5aaddcbbaee..99971cd349f36310 100644
> > > --- a/arch/arm64/kernel/efi.c
> > > +++ b/arch/arm64/kernel/efi.c
> > > @@ -96,15 +96,23 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
> > >       return 0;
> > >  }
> > >
> > > +struct set_perm_data {
> > > +     const efi_memory_desc_t *md;
> > > +     bool                    has_bti;
> > > +};
> > > +
> > >  static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
> > >  {
> > > -     efi_memory_desc_t *md = data;
> > > +     struct set_perm_data *spd = data;
> > > +     const efi_memory_desc_t *md = spd->md;
> > >       pte_t pte = READ_ONCE(*ptep);
> > >
> > >       if (md->attribute & EFI_MEMORY_RO)
> > >               pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> > >       if (md->attribute & EFI_MEMORY_XP)
> > >               pte = set_pte_bit(pte, __pgprot(PTE_PXN));
> > > +     else if (system_supports_bti() && spd->has_bti)
> >
> > system_supports_bti() seems to check CONFIG_ARM64_BTI rather than
> > CONFIG_ARM64_BTI_KERNEL. In theory, I think this means we could have
> > mismatched BTI support, so it might be slightly more robust to use the
> > latter option here even thought the runtime services aren't kernel code.
> >
> > What do you think?
> 
> v1 checked for CONFIG_ARM64_BTI_KERNEL as well, but I dropped it
> because we can do the enforcement even without it.
> 
> I'm not sure how mismatched BTI support factors into that, though,
> given that CONFIG_ARM64_BTI_KERNEL is set at compile time. You mean
> mismatched between cores, right?

I believe that there's no issue with mismatched CPUs, but there *might* might
be a different issue with the ordering of feature detection and usage of the
cap:

* If CONFIG_ARM64_BTI_KERNEL=y, then the ARM64_BTI cap is detected as a strict
  boot cpu feature, and secondaries without it will be rejected.

* If CONFIG_ARM64_BTI_KERNEL=n then the ARM64_BTI cap is detected as a system
  feature, and so we only set the cap bit after bringing all secondary CPUs
  online, and only when *all* CPUs support it.

  The happens under setup_cpu_features(), called from smp_cpus_done().

So there's no issue with mismatch, but if system_supports_bti is called before
smp_cpus_done() on a CONFIG_ARM64_BTI_KERNEL kernel it will return false. When
do we set up the EFI mappings relative to that?

Thanks,
Mark.
