Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07902690CB2
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 16:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBIPQG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 10:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjBIPPf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 10:15:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 387F86310C
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 07:15:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DAE2F4;
        Thu,  9 Feb 2023 07:15:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F493F703;
        Thu,  9 Feb 2023 07:14:59 -0800 (PST)
Date:   Thu, 9 Feb 2023 15:13:06 +0000
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
Message-ID: <Y+UNgo0fqiMl6Vlg@FVFF77S0Q05N>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 09, 2023 at 03:21:55PM +0100, Ard Biesheuvel wrote:
> On Wed, 8 Feb 2023 at 15:36, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Wed, 8 Feb 2023 at 15:25, Mark Rutland <mark.rutland@arm.com> wrote:
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

That make sense to me; with the CONFIG_ARM64_BTI_KERNEL check:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
