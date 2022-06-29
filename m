Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5D55FB45
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiF2JDo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jun 2022 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiF2JDn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jun 2022 05:03:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D2C17AB7
        for <linux-efi@vger.kernel.org>; Wed, 29 Jun 2022 02:03:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72731477;
        Wed, 29 Jun 2022 02:03:42 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC4F3F792;
        Wed, 29 Jun 2022 02:03:41 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:02:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using
 typeof()
Message-ID: <20220629090230.flwocqj7na4qvwoi@bogus>
References: <20220628125938.694256-1-sudeep.holla@arm.com>
 <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
 <20220628134738.xqj6gu5ngbsuql2f@bogus>
 <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
 <20220628140929.do5e5ic77twmed5e@bogus>
 <CAMj1kXHyRgT0mM5+r6Gd0ww5ADB9coDGbuYY8KCQJibTJdzBSQ@mail.gmail.com>
 <20220629085619.jqujeyvsffxi6i6p@bogus>
 <CAMj1kXFc7CaTV3vhJrskL+VZS2rAdb320Be1mhwX4VW=pSsdJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFc7CaTV3vhJrskL+VZS2rAdb320Be1mhwX4VW=pSsdJA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 29, 2022 at 10:58:29AM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Jun 2022 at 10:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 07:58:38PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 28 Jun 2022 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 03:57:38PM +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 28 Jun 2022 at 15:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > >
> > > ...
> > >
> > > > > > I am yet to figure out how asm/efi.h and linux/efi.h are included so that
> > > > > > we can have generic definition in linux/efi.h and x86 can undefine that
> > > > > > and redefine its own version.
> > > > > >
> > > > > > Does that make sense ?
> > > > > >
> > > > >
> > > > > I appreciate the effort, but for now, let's just fix the ones we need
> > > > > to fix (and the ARM one too while we're at it). PRM can only be
> > > > > enabled on x86 and arm64 anyway.
> > > >
> > > > True. OK then I will just update ARM version and leave loongarch as is.
> > > >
> > >
> > > Actually, this was rather straight-forward so I folded this change
> > > into your ARM patch.
> >
> > I see you have the generic version for all archs except arm64 and x86 as
> > we discussed earlier. Since you have even included the arm64 changes, the
> > PRMT enablement patches need to routed via your tree now as it depends on
> > the change you have in your -next.
> >
> > Are you OK with that if Rafael agrees ? I can ask him on the other thread.
> > No further changes are needed. Let me know.
> >
> 
> Yes, that is fine. Or I can put that patch on a stable branch by itself.

Thanks I will check with Rafael now.

-- 
Regards,
Sudeep
