Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632455E7AF
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiF1OJe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiF1OJe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 10:09:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3E9D35879
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 07:09:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD922153B;
        Tue, 28 Jun 2022 07:09:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6393F5A1;
        Tue, 28 Jun 2022 07:09:31 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:09:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using
 typeof()
Message-ID: <20220628140929.do5e5ic77twmed5e@bogus>
References: <20220628125938.694256-1-sudeep.holla@arm.com>
 <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
 <20220628134738.xqj6gu5ngbsuql2f@bogus>
 <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:38PM +0200, Ard Biesheuvel wrote:
> On Tue, 28 Jun 2022 at 15:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 03:16:26PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 28 Jun 2022 at 14:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > Currently, the arch_efi_call_virt() assumes all users of it will have
> > > > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > > > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > > > actually expects void pointer.
> > > >
> > > > Simplify the arch_efi_call_virt() macro by using typeof(p->f) which must
> > > > be a pointer as required by __efi_rt_asm_wrapper() and eliminate the
> > > > explicit need for efi_##f##_t type for every user of this macro.
> > > >
> > > > This change is done to align with implementations on other similar
> > > > architectures.
> > > >
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  arch/arm/include/asm/efi.h | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > Hi,
> > > >
> > > > Reference for this change [1] and in particular[2]
> > > >
> > > > Regards,
> > > > Sudeep
> > > >
> > > > [1] https://lore.kernel.org/r/20220628125346.693304-1-sudeep.holla@arm.com
> > > > [2] https://lore.kernel.org/r/20220628125346.693304-3-sudeep.holla@arm.com/
> > > >
> > > > diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> > > > index 27218eabbf9a..d4a405c9b4b6 100644
> > > > --- a/arch/arm/include/asm/efi.h
> > > > +++ b/arch/arm/include/asm/efi.h
> > > > @@ -26,8 +26,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> > > >
> > > >  #define arch_efi_call_virt(p, f, args...)                              \
> > > >  ({                                                                     \
> > > > -       efi_##f##_t *__f;                                               \
> > > > -       __f = p->f;                                                     \
> > > > +       typeof(p->f) __f = p->f;                                        \
> > > >         __f(args);                                                      \
> > > >  })
> > > >
> > >
> > > I think this could simply be
> > >
> > > #define arch_efi_call_virt(p, f, args...) ((p)->f(args))
> > >
> > > no?
> >
> > Yes, I came to similar conclusion just after sending this out as I started to
> > look if we can have one generic definition for arm/arm64/riscv/loongarch.
> >
> 
> Not really - arm64 has the asm wrapper, and loongarch is only halfway
> merged so I'm not sure yet if this is the final form.
>

Aargh! arm64 was typo, indeed arm64 has wrapper. I meant to refer other 3 archs.

> > I am yet to figure out how asm/efi.h and linux/efi.h are included so that
> > we can have generic definition in linux/efi.h and x86 can undefine that
> > and redefine its own version.
> >
> > Does that make sense ?
> >
> 
> I appreciate the effort, but for now, let's just fix the ones we need
> to fix (and the ARM one too while we're at it). PRM can only be
> enabled on x86 and arm64 anyway.

True. OK then I will just update ARM version and leave loongarch as is.

--
Regards,
Sudeep
