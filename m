Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013A629782
	for <lists+linux-efi@lfdr.de>; Tue, 15 Nov 2022 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKOLcm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Nov 2022 06:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbiKOLcA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Nov 2022 06:32:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA224948
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 03:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6740616C5
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 11:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E4C433C1;
        Tue, 15 Nov 2022 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668511900;
        bh=rn62bIUKfNDs4qARPw8jT2XBwnVNQ2diPDoNbFA7xA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KY29oRW2w4aAlkXurwuEG+jqzSnvtn1NDiyN2U07IkVhG5TYvW4jfOtLuDdhjV5ht
         A9V4+arFWeqC2y0OEzo2yDiL6Q+c81iqkwj00YwQB8mLoDaydNQJgGkMa2W7YisMJS
         PI5XLYyzvs17nR+o87VHDt0/t/5495n7eBPuhl5CHC6NjinRzhfC+4OnB79gDZIchQ
         Jf/Ftw55MxSfynsQTaZmakYOq3KtpLHjsdtfghm26SSmync5JPg+gYzkJMsghXJFYB
         0Y1rMNIFMvKYNlz6JlWPt+cqwFC4ABNsKalydZtj157OgtNqELlSuga/3yZc4C0c9W
         9zZj/3kGkPIqA==
Date:   Tue, 15 Nov 2022 11:31:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
Message-ID: <20221115113134.GC32523@willie-the-truck>
References: <20221108182204.2447664-1-ardb@kernel.org>
 <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
 <20221115111658.GA32523@willie-the-truck>
 <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 15, 2022 at 12:21:55PM +0100, Ard Biesheuvel wrote:
> On Tue, 15 Nov 2022 at 12:17, Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Nov 11, 2022 at 05:36:19PM +0000, Mark Rutland wrote:
> > > On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> > > > The purpose of this series is to remove any explicit cache maintenance
> > > > for coherency during early boot that becomes unnecessary if we simply
> > > > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > > > and use it to populate the ID map page tables. After setting up this
> > > > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > > > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > > > need for any manipulations of memory while the MMU and caches are off.
> > > >
> > > > The only properties of the firmware provided 1:1 map we rely on is that
> > > > it does not require any explicit cache maintenance for coherency, and
> > > > that it covers the entire memory footprint of the image, including the
> > > > BSS and padding at the end - all else is under control of the kernel
> > > > itself, as before.
> > >
> > > As a high-level thing, I'm still very much not keen on entering the kernel with
> > > the MMU on. Given that we have to support booting with the MMU off for !EFI
> > > boot (including kexec when EFI is in use), I think this makes it harder to
> > > reason about the boot code overall (e.g. due to the conditional maintenance
> > > added to head.S), and adds more scope for error, even if it simplifies the EFI
> > > stub itself.
> >
> > As discussed offline, two things that would help the current series are:
> >
> >   (1) Some performance numbers comparing MMU off vs MMU on boot
> >
> >   (2) Use of a separate entry point for the MMU on case, potentially failing
> >       the boot if the MMU is on and we're not using EFI
> >
> 
> Ack.
> 
> But thinking about (2) again, failing the boot is better done at a
> time when you can inform the user about it, no?
> 
> IOW, just going into a deadloop really early if you enter the bare
> metal entry point with the MMU on is going to be hard to distinguish
> from other issues, whereas panicking after the console up is more
> likely to help getting the actual issue diagnosed.

Agreed.

> So perhaps we should panic() instead of warn+taint when this condition
> occurs, and do it from an early initcall instead of from setup_arch().

To be honest, and I appreciate that this is unhelpful, but I'm fine with
the warn+taint and prefer that to a fatal stop.

Will
