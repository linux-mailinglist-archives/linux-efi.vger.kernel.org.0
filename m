Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A530624A88
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKJTVy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 14:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKJTVx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 14:21:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D77655
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 11:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C5661DEF
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 19:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA09C433D6
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668108112;
        bh=aDLOOek9p9Uc9KYfbsIi300+d2TwGgHFneAzXYQOsvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f7vcZU+iEj8/QGpmyE+/2j8QPZAlUZVOmPuLHIr23IjJLYWqqG07EzJinmvMka5MO
         Ll23F/HF3ia29+zrELqL28fRc05BfATBmzsDgP5FipDE+8jg8v6+eyCt/wWxOms+W0
         RLfF8alrWAs0jW3eV6da/Z6nxfrNlXAhFtE02advbWTpfZW+yQeuxdEIeSW+2N/4Kw
         i9sNQh8koNiqHs7lX+gP0GyXo4UPWj4mf7Icu2+pSWMDMneYMRpH+r3FnWyQqv1Ezu
         oi/h6JseI5yo5p0PTRuiduS2zb/G5dbjZDIcEEWmjcKNR1VSUWYAiOWfhYSjq0rbTc
         XensRQKAsvf8w==
Received: by mail-lf1-f43.google.com with SMTP id bp15so4986960lfb.13
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 11:21:52 -0800 (PST)
X-Gm-Message-State: ACrzQf3QkRS0l5JnwMdYaICdfbi6/4mJB+ZCwGKSdf7/OJdikm9V5zGs
        QafNmrVF8gx2EkcSB6paMcEoA8bycZhyl/T83G0=
X-Google-Smtp-Source: AMsMyM6ZGetpPeKfxb/myBWyqHnjrZ6b6rMtLaqXGwk6GHTmO3ZYAKI9N9Dw+KLYLQj8gMnVc3clG9uU3KKCPqgvyhs=
X-Received: by 2002:a05:6512:2004:b0:4a2:bfd2:b218 with SMTP id
 a4-20020a056512200400b004a2bfd2b218mr1748988lfb.228.1668108110189; Thu, 10
 Nov 2022 11:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20221110094951.2963479-1-ardb@kernel.org> <Y20MradQoIhwOAKW@monolith.localdoman>
 <CAMj1kXHsu9=ahdVYtR+a6QB-uvMb6FP3D75c0Ya-CZFFMj8v6w@mail.gmail.com> <Y20Z++yz4gW9jHBL@monolith.localdoman>
In-Reply-To: <Y20Z++yz4gW9jHBL@monolith.localdoman>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Nov 2022 20:21:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETy24d8syUKkiX7Nr0Pax2VzDvELNc64bz65uGHupRFA@mail.gmail.com>
Message-ID: <CAMj1kXETy24d8syUKkiX7Nr0Pax2VzDvELNc64bz65uGHupRFA@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Force the use of SetVirtualAddressMap() on
 Altra machines
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 16:34, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Thu, Nov 10, 2022 at 03:45:03PM +0100, Ard Biesheuvel wrote:
> > On Thu, 10 Nov 2022 at 15:37, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Nov 10, 2022 at 10:49:51AM +0100, Ard Biesheuvel wrote:
> > > > Ampere Altra machines are reported to misbehave when the SetTime() EFI
> > > > runtime service is called after ExitBootServices() but before calling
> > > > SetVirtualAddressMap(). Given that the latter is horrid, pointless and
> > > > explicitly documented as optional by the EFI spec, we no longer invoke
> > > > it at boot if the configured size of the VA space guarantees that the
> > > > EFI runtime memory regions can remain mapped 1:1 like they are at boot
> > > > time.
> > > >
> > > > This means that SetTime() calls on Ampere Altra machines issued by the
> > > > rtc-efi driver now trigger a synchronous exception during boot.  We can
> > > > now recover from those without bringing down the system entirely, due to
> > > > commit 23715a26c8d81291 ("arm64: efi: Recover from synchronous
> > > > exceptions occurring in firmware"). However, it would be better to avoid
> > > > this completely, given that the firmware appears to remain in a funny
> > > > state after this.
> > > >
> > > > So attempt to identify these machines based on the 'family' field in the
> > > > type #1 SMBIOS record, and call SetVirtualAddressMap() unconditionally
> > > > in that case.
> > >
> > > This works for my machine. Tested with this patch on top of the patch [1] that
> > > disables only the misbehaving services, not runtime services altogether (can
> > > test other configurations, if you feel it's necessary):
> > >
> > > Tested-by: Alexandru Elisei <alexandru.elisei@gmail.com>
> > >
> >
> > Thanks.
> >
> > I take it this means that efibootmgr now works as it should?
>
> Yes, tested GetVariable() (# efibootmgr) and SetVariable() (# efibootmgr -t
> 30). Also tested this patch on top of v6.1-rc4, same results.
>

Excellent news, thank you very much.
