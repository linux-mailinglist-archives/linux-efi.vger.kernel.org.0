Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448D629748
	for <lists+linux-efi@lfdr.de>; Tue, 15 Nov 2022 12:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiKOLWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Nov 2022 06:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiKOLWM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Nov 2022 06:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A6FFF
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 03:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 139A5B818BC
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 11:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2818C433C1
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668511328;
        bh=RUex/uVLEtUTtpMrK7R5q8A3DmJVD4YlNTI9loy8eJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=glk47w7xi3guel3fw1pxy4K8FCcpsBMJFD8KXefzOCraQ+2YgX6DJ9Ex1PkGAc61s
         zSOfME613ERA8CIIToNU6uhuWgABZlEk82Si+IAZKRDUpQrg66hz3DswaUVamjG4Pa
         MN6yGYNOsMyW761/bRFGJfem40WlBixFR8fBNLcZmEHxnXIeFnzikS1H3YR3kEzML3
         8LHktd1WmOtCjfb/v6axdRqhdcYvKXfbE2xjqpkRL7jvEP3/koBhQn+/R6IcfI78FC
         HOVnXDtwGmPT+00HcL0mTOklfvsDeFpP4Zne7gtgP9sikpStyPZcgACpsG1g35Us5J
         Uy0U4PjcPEn/Q==
Received: by mail-lf1-f49.google.com with SMTP id d6so23891505lfs.10
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 03:22:08 -0800 (PST)
X-Gm-Message-State: ANoB5pmiiDgID0ERu82iJ2GeEE0Q7y8lb0l+Wep4XqKTeHEpsuBC48t/
        P2Y3OIX8l9HHWhpsAyGomDAY+jLDMYfmOkabdKs=
X-Google-Smtp-Source: AA0mqf5upU2WJXKcyknsXw7W4VQJs4KNSYC5eBDbx6d89648ofQiEYjSFn3R9Rp9WCIJ7it6fIYNJKte3XoKgsHmd+A=
X-Received: by 2002:a05:6512:1042:b0:4a2:2aad:95c4 with SMTP id
 c2-20020a056512104200b004a22aad95c4mr6434629lfb.110.1668511326789; Tue, 15
 Nov 2022 03:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20221108182204.2447664-1-ardb@kernel.org> <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
 <20221115111658.GA32523@willie-the-truck>
In-Reply-To: <20221115111658.GA32523@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Nov 2022 12:21:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
Message-ID: <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Nov 2022 at 12:17, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Nov 11, 2022 at 05:36:19PM +0000, Mark Rutland wrote:
> > On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> > > The purpose of this series is to remove any explicit cache maintenance
> > > for coherency during early boot that becomes unnecessary if we simply
> > > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > > and use it to populate the ID map page tables. After setting up this
> > > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > > need for any manipulations of memory while the MMU and caches are off.
> > >
> > > The only properties of the firmware provided 1:1 map we rely on is that
> > > it does not require any explicit cache maintenance for coherency, and
> > > that it covers the entire memory footprint of the image, including the
> > > BSS and padding at the end - all else is under control of the kernel
> > > itself, as before.
> >
> > As a high-level thing, I'm still very much not keen on entering the kernel with
> > the MMU on. Given that we have to support booting with the MMU off for !EFI
> > boot (including kexec when EFI is in use), I think this makes it harder to
> > reason about the boot code overall (e.g. due to the conditional maintenance
> > added to head.S), and adds more scope for error, even if it simplifies the EFI
> > stub itself.
>
> As discussed offline, two things that would help the current series are:
>
>   (1) Some performance numbers comparing MMU off vs MMU on boot
>
>   (2) Use of a separate entry point for the MMU on case, potentially failing
>       the boot if the MMU is on and we're not using EFI
>

Ack.

But thinking about (2) again, failing the boot is better done at a
time when you can inform the user about it, no?

IOW, just going into a deadloop really early if you enter the bare
metal entry point with the MMU on is going to be hard to distinguish
from other issues, whereas panicking after the console up is more
likely to help getting the actual issue diagnosed.

So perhaps we should panic() instead of warn+taint when this condition
occurs, and do it from an early initcall instead of from setup_arch().
