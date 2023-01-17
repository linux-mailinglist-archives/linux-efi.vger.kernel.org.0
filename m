Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077E66E506
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 18:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjAQRd1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjAQRa4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 12:30:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D03D0AD
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 09:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39677614EA
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 17:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B88FC433D2;
        Tue, 17 Jan 2023 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673976621;
        bh=beJ9V6BeAGV4kkOUI+f/aiJagpRj03qFsG6dL1mSE44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmF4u8cxwyN/VLCdzaGw6x/hPcPeZCgHo8u362TWYbFNTU7dWvB4M0jbFzyD9RSZT
         AsZRB9mRoSSNCpHB1L7L1nchqmNRmuK8SZpiLba1XDH7wAM2Z0L2CJMh0SJ4HZl0n9
         3EP3/SVB5JfRwYZ3aEEE8aE0x97RnNeo4BRC4omHD87wt5hDyTExJcXsxo6/u+DMRX
         XRDznz0Asill7l4VZMujgfMnfP4nxWGuEjK4LArhu5uRxK5OPxKn2tSPLMhQGqRgBv
         KfJ+9YzUJKO8M48YHLWodE/fB+Bp5smVB9rQpHWPvsuSxp+3zA+H/Kc6yyRHNj2bnr
         m7YYuxSk2efFw==
Date:   Tue, 17 Jan 2023 10:30:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFT PATCH 0/2] arm64: efi: Call SetVaMap() with a 1:1 mapping
Message-ID: <Y8bbK30nptwHKn88@dev-arch.thelio-3990X>
References: <20230117142718.564299-1-ardb@kernel.org>
 <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 17, 2023 at 04:20:09PM +0100, Ard Biesheuvel wrote:
> On Tue, 17 Jan 2023 at 15:27, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Linux on arm64 is now in the same boat as x86, where supporting laptops
> > that were built to run Windows and never tested beyond what is required
> > for the Windows Logo certification need workarounds for all kinds of
> > bizarre behaviors.
> >
> > On Snapdragon laptops, we cannot call SetVirtualAddressMap() from the
> > stub, because the firmware will crash while trying to access memory via
> > the virtual addresses being installed, which is explicitly unsupported
> > by the EFI spec.
> >
> > However, not calling SetVirtualAddressMap() results in other problems:
> > on Ampere Altra, it causes SetTime() to crash. On Surface and Flex5g
> > Windows-on-ARM laptops, it causes ResetSystem() to crash.
> >
> > So let's try to work around this while not making too much of a mess.
> >
> > First of all, install a 1:1 mapping instead of avoiding SetVaMap()
> > altogether - from the EFI spec pov, this should amount to the same
> > thing.
> >
> > Then, given that we already use a SMBIOS based hack for Altra to force
> > the use of SetVirtualAddressMap(), let's check for Surface systems in
> > the same way.
> >
> > Please test, and please report the SMBIOS type 1 family field for which
> > this workaround is needed.
> >
> > Also, note that these changes will not make a difference if the
> > EFI_RT_PROPERTIES_TABLE lists SetVirtualAddressMap() as not implemented.
> >
> > Nathan, I would appreciate it if you could give this a spin on your
> > Altra box (only patch #1 should make a difference), and for good
> > measure, double check that hwclock still works as it should.
> >
> > Cc: Johan Hovold <johan+linaro@kernel.org>
> > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Steev Klimaszewski <steev@kali.org>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> >
> > Ard Biesheuvel (2):
> >   arm64: efi: Prefer a flat virtual mapping of the runtime services
> >   arm64: efi: Force use of SetVirtualAddressMap() on MS Surface
> >
> 
> Bah this does not even work on Yoga C630, so this is not going to help us.
> 
> If we want ResetSystem() on these machines, we'll have to retain other
> memory ranges and map the in the EFI runtime map. Yuck.
> 
> Nathan - still interested in whether patch #1 works on Altra,

I applied patch 1 on top of commit 6e50979a9c87 ("Merge tag
'mm-hotfixes-stable-2023-01-16-15-23' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in Linus' tree
and everything still appears to be okay with hwclock. If there is any
more specific testing that I should do, please let me know. Feel free to
add

    Tested-by: Nathan Chancellor <nathan@kernel.org>

to patch 1 in future revisions, and I am happy to test anything else
that you might need in this series or future ones.

Mainline:

# uname -mr
6.2.0-rc4-00031-g6e50979a9c87 aarch64

# hwclock
2023-01-17 09:04:58.845411-07:00

Patch:

# uname -mr
6.2.0-rc4-00032-g20165e83052e aarch64

# hwclock
2023-01-17 10:25:38.843788-07:00

Cheers,
Nathan
