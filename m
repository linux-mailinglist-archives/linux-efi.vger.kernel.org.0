Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6867215A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjARPdq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 10:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjARPdp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 10:33:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A961CF7E
        for <linux-efi@vger.kernel.org>; Wed, 18 Jan 2023 07:33:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4A4A6186E
        for <linux-efi@vger.kernel.org>; Wed, 18 Jan 2023 15:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1818BC433F0
        for <linux-efi@vger.kernel.org>; Wed, 18 Jan 2023 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674056023;
        bh=IIS4gQaCxyYgU5hzMKvHy1tAQ2RhlgJh2+4yNQv7fSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VlIWGl6IyeG24lzba+eSqVZnZEdcmHWVnr6Cp1i9kRY0TBRoEiMwMO+W7JYbSDxj0
         kubpFy3QENfNDLJPHLjBHhGAGFlmb0jNymJRJ5PM0X9/xpUe7yaNyV3cTNo3sU1Fdg
         +GOqZFJmKCykHgaP5U5YaWJ1DjgQt1fYOpi1hZobuERfMGyPRs0BVeihRyz+pl0QB6
         LvxNW3b/9BxeXZlvUEeeqCbWofIqxW3cUZYLaduVkApEEMCnOyLjSXcZ82Qk9VFEds
         yiALWQ84hMxx7DipCIKpVnKY/sewQf4W5SPBMaDFnGccw5WRqZWDjeDSQlIeIiaE+g
         aRLe0fev1+cog==
Received: by mail-lj1-f171.google.com with SMTP id bn6so37022914ljb.13
        for <linux-efi@vger.kernel.org>; Wed, 18 Jan 2023 07:33:42 -0800 (PST)
X-Gm-Message-State: AFqh2koyMZ/OaOKsEAP3WmyUtd3d1/OQPfq4t9Wfx+ea8dJioe85YC2Q
        F9OyioOqmZ8Pjxwp+SBboqcvidOMV2f1yykwMOI=
X-Google-Smtp-Source: AMrXdXtrUJL1v9/wsla7FYzdMYbMxSIh1pW+OrQxdgLc8iV5VoDB3MVWAamTEa5mZxGaZl+CmY0Hol9D7uArgl3etN0=
X-Received: by 2002:a05:651c:b1f:b0:28b:814d:7087 with SMTP id
 b31-20020a05651c0b1f00b0028b814d7087mr678072ljr.516.1674056020872; Wed, 18
 Jan 2023 07:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20230117142718.564299-1-ardb@kernel.org> <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
 <Y8bbK30nptwHKn88@dev-arch.thelio-3990X> <CAMj1kXFmj9p5xX7bzhatHsj=6JVAtcshN76Dp9Sv8moFBnZc0A@mail.gmail.com>
 <Y8gPnlngCV4cyDEY@dev-arch.thelio-3990X>
In-Reply-To: <Y8gPnlngCV4cyDEY@dev-arch.thelio-3990X>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Jan 2023 16:33:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKwy9rZ-a6imw_2wLap87zHFF0UEmfxo8Bsn=x-go1Qw@mail.gmail.com>
Message-ID: <CAMj1kXEKwy9rZ-a6imw_2wLap87zHFF0UEmfxo8Bsn=x-go1Qw@mail.gmail.com>
Subject: Re: [RFT PATCH 0/2] arm64: efi: Call SetVaMap() with a 1:1 mapping
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 18 Jan 2023 at 16:26, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Jan 18, 2023 at 08:56:54AM +0100, Ard Biesheuvel wrote:
> > On Tue, 17 Jan 2023 at 18:30, Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 04:20:09PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 17 Jan 2023 at 15:27, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > Linux on arm64 is now in the same boat as x86, where supporting laptops
> > > > > that were built to run Windows and never tested beyond what is required
> > > > > for the Windows Logo certification need workarounds for all kinds of
> > > > > bizarre behaviors.
> > > > >
> > > > > On Snapdragon laptops, we cannot call SetVirtualAddressMap() from the
> > > > > stub, because the firmware will crash while trying to access memory via
> > > > > the virtual addresses being installed, which is explicitly unsupported
> > > > > by the EFI spec.
> > > > >
> > > > > However, not calling SetVirtualAddressMap() results in other problems:
> > > > > on Ampere Altra, it causes SetTime() to crash. On Surface and Flex5g
> > > > > Windows-on-ARM laptops, it causes ResetSystem() to crash.
> > > > >
> > > > > So let's try to work around this while not making too much of a mess.
> > > > >
> > > > > First of all, install a 1:1 mapping instead of avoiding SetVaMap()
> > > > > altogether - from the EFI spec pov, this should amount to the same
> > > > > thing.
> > > > >
> > > > > Then, given that we already use a SMBIOS based hack for Altra to force
> > > > > the use of SetVirtualAddressMap(), let's check for Surface systems in
> > > > > the same way.
> > > > >
> > > > > Please test, and please report the SMBIOS type 1 family field for which
> > > > > this workaround is needed.
> > > > >
> > > > > Also, note that these changes will not make a difference if the
> > > > > EFI_RT_PROPERTIES_TABLE lists SetVirtualAddressMap() as not implemented.
> > > > >
> > > > > Nathan, I would appreciate it if you could give this a spin on your
> > > > > Altra box (only patch #1 should make a difference), and for good
> > > > > measure, double check that hwclock still works as it should.
> > > > >
> > > > > Cc: Johan Hovold <johan+linaro@kernel.org>
> > > > > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > Cc: Steev Klimaszewski <steev@kali.org>
> > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > >
> > > > > Ard Biesheuvel (2):
> > > > >   arm64: efi: Prefer a flat virtual mapping of the runtime services
> > > > >   arm64: efi: Force use of SetVirtualAddressMap() on MS Surface
> > > > >
> > > >
> > > > Bah this does not even work on Yoga C630, so this is not going to help us.
> > > >
> > > > If we want ResetSystem() on these machines, we'll have to retain other
> > > > memory ranges and map the in the EFI runtime map. Yuck.
> > > >
> > > > Nathan - still interested in whether patch #1 works on Altra,
> > >
> > > I applied patch 1 on top of commit 6e50979a9c87 ("Merge tag
> > > 'mm-hotfixes-stable-2023-01-16-15-23' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in Linus' tree
> > > and everything still appears to be okay with hwclock. If there is any
> > > more specific testing that I should do, please let me know. Feel free to
> > > add
> > >
> > >     Tested-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > to patch 1 in future revisions, and I am happy to test anything else
> > > that you might need in this series or future ones.
> > >
> > > Mainline:
> > >
> > > # uname -mr
> > > 6.2.0-rc4-00031-g6e50979a9c87 aarch64
> > >
> > > # hwclock
> > > 2023-01-17 09:04:58.845411-07:00
> > >
> > > Patch:
> > >
> > > # uname -mr
> > > 6.2.0-rc4-00032-g20165e83052e aarch64
> > >
> > > # hwclock
> > > 2023-01-17 10:25:38.843788-07:00
> > >
> >
> > Thanks Nathan,
> >
> > Forgot to mention, though: it is SetTime() not GetTime() that is
> > problematic on this platform. Could you please double check whether
> > setting the RTC using hwclock works too?
>
> Ah, okay, makes sense! As far as I can tell, that works too.
>
> Mainline:
>
> # uname -mr
> 6.2.0-rc4-00031-g6e50979a9c87 aarch64
>
> # hwclock --systohc
>
> # echo $status
> 0
>
> Patch:
>
> # uname -mr
> 6.2.0-rc4-00032-g20165e83052e aarch64
>
> # hwclock --systohc
>
> # echo $status
> 0
>

Thanks again!
