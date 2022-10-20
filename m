Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E46066F0
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJTRWI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJTRWG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36B4B0C6
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC4061CCD
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44B7C433C1;
        Thu, 20 Oct 2022 17:22:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EqV146+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666286522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfFanBW2CCr1bDxRDzEzzKqdr8VSKlPfqL8UAR5jDww=;
        b=EqV146+47l1WD/GW7hhkqsvFQD1bJ28IJLo/faJByYymCP3pJYNmDw221eid5hTHc1DB4F
        CrgmPTabwkSl4VoMI1Ok6tJEWIC+sCcHUhEMKg4Nfadjr2Lktwrxr6uARb1IF5DaNNgwKt
        veEOzPD396MmR4mBQUnCFHjjBsEyRv8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 900c4dbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 17:22:02 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:22:00 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v3 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
Message-ID: <Y1GDuHcqTuMx9hu+@zx2c4.com>
References: <20221020083910.1902009-1-ardb@kernel.org>
 <20221020083910.1902009-4-ardb@kernel.org>
 <Y1F9oyE9QlJrzZNg@zx2c4.com>
 <CAMj1kXHG4_sboDNnZDvbuCr3oAYdeEn1kqAx3in1WXyBzXXaiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHG4_sboDNnZDvbuCr3oAYdeEn1kqAx3in1WXyBzXXaiQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 20, 2022 at 07:11:33PM +0200, Ard Biesheuvel wrote:
> On Thu, 20 Oct 2022 at 18:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Ard,
> >
> > Thanks for doing this. Some comments below:
> >
> > On Thu, Oct 20, 2022 at 10:39:10AM +0200, Ard Biesheuvel wrote:
> > > Instead of blindly creating the EFI random seed configuration table if
> > > the RNG protocol is implemented and works, check whether such a EFI
> > > configuration table was provided by an earlier boot stage and if so,
> > > concatenate the existing and the new seeds, leaving it up to the core
> > > code to mix it in and credit it the way it sees fit.
> > >
> > > This can be used for, e.g., systemd-boot, to pass an additional seed to
> > > Linux in a way that can be consumed by the kernel very early. In that
> > > case, the following definitions should be used to pass the seed to the
> > > EFI stub:
> > >
> > > struct linux_efi_random_seed {
> > >       u32     size; // of the 'seed' array in bytes
> > >       u8      seed[];
> > > };
> > >
> > > The memory for the struct must be allocated as EFI_ACPI_RECLAIM_MEMORY
> > > pool memory, and the address of the struct in memory should be installed
> > > as a EFI configuration table using the following GUID:
> > >
> > > LINUX_EFI_RANDOM_SEED_TABLE_GUID        1ce1e5bc-7ceb-42f2-81e5-8aadf180f57b
> > >
> > > Note that doing so is safe even on kernels that were built without this
> > > patch applied, but the seed will simply be overwritten with a seed
> > > derived from the EFI RNG protocol, if available. The recommended seed
> > > size is 32 bytes, anything beyond that is disregarded when the seeds are
> > > concatenated.
> >
> > Since this commit message will be used by other implementers inevitably,
> > you might want to include something about forward secrecy, memzeroing
> > old allocations, etc.
> >
> 
> Good point. Did you have any prose in mind?

How about:

In order to preserve forward secrecy, seeds from previous bootloaders
are memzero'd out, and in order to preserve memory, those older seeds
are also freed from memory. Freeing from memory without first memzeroing
is not safe to do, as it's possible that nothing else will ever
overwrite those pages used by EFI.

Or something like it?

> I'm more worried about memory corruption here. If the memory that the
> table points to was overwritten arbitrarily, the size field will be
> bogus, and memcpy()ing that number of bytes is likely to lead to
> tears.

Gotcha. Maybe cap it to 512 bytes then? Something overly big, but not
too large? That's what I do in arch/mips/kernel/setup.c's
setup_rng_seed, for example.

> > Also, I don't think that efi_warn() makes sense. In the easy case, if
> > the bootloader provides a seed bu EFI doesn't have a RNG_PROTOCOL
> > implementation, then that's a firmware limitation the user likely can't
> > do anything about, in which case it's really good that systemd-boot is
> > providing something instead. So that's not something to worry about.
> 
> We don't hit the warn in that case. If EFI_RNG_PROTOCOL does not
> exist, we just bail and if the bootloader provided a seed as well, it
> just remains where it was.

Oh yea, good point. So that warning message triggers for when there is a
EFI_RNG_PROTOCOL, but for some reason it still fails when using it.

> > In the more complicated cases, you jump here when
> > install_configuration_table() fails, so that's something to warn about,
> > but perhaps just before goto. Then, you also return early from the
> > function up at the call to allocate_pool, so that'd be a place to warn
> > about too.
> >
> > Not seen in this diff, but relevant too is that you currently exit early
> > from the function if locate_protocol fails. If there's a systemd-boot
> > seed already, this is premature.
> 
> Why? The bootloader seed will just be passed on in that case - no need
> to touch it if we're not going to combine it with anything else.

You're right.

Jason
