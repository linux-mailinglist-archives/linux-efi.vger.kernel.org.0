Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085068351A
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 19:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAaSXH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 13:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaSXG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 13:23:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3523C41;
        Tue, 31 Jan 2023 10:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA176160B;
        Tue, 31 Jan 2023 18:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8090AC433EF;
        Tue, 31 Jan 2023 18:23:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EqE57RqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675189381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QpT46/u33S6NMwaECaUNHvlKPKaadrNKuyaF728fjXY=;
        b=EqE57RqBg6yn6nqrbDD80y4P2xlhLeKSyO8QWqqmnMPBmM519vHQb/nKWIimx4BHJYM9EF
        J9I5Hn4ZFYQ/etGHFpZOd4th2Z2/hQnXz0eZMgqSCC/XbwosLjoQvVN2spclerlvgpeZg8
        1NwncALk2I8WyjLNZCZ5qyFSGyvSS1o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e409f5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 31 Jan 2023 18:23:01 +0000 (UTC)
Date:   Tue, 31 Jan 2023 19:23:00 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Message-ID: <Y9lchEgyNGLKu/4R@zx2c4.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 31, 2023 at 03:21:39PM +0000, Justin He wrote:
> Hi Ard,
> 
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Tuesday, January 31, 2023 3:19 PM
> > To: Justin He <Justin.He@arm.com>; Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>; linux-efi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Alexandru Elisei <Alexandru.Elisei@arm.com>
> > Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
> >
> > (cc Jason for awareness)
> >
> > On Tue, 31 Jan 2023 at 05:04, Jia He <justin.he@arm.com> wrote:
> > >
> > > I met a hung task warning and then kernel was hung forever with latest
> > > kernel on an Ampere Emag server.
> > >
> > > The root cause is kernel was hung  when invoking an efi rts call to
> > > set the RandomSeed variable during the booting stage. The
> > > arch_efi_call_virt call (set_variable) was never returned and then caused the
> > hung task error.
> > >
> >
> > Given that EFI variables work on this platform (as far as I know), the problem
> > may be that we are calling SetVariable() too early.
> >
> > Could you double check whether setting variables works as expected?
> > You can use efibootmgr -t 10 as root (for example) to set the boot timeout, and
> > check whether the new value is retained after a reboot (efibootmgr will print
> > the current value for you)
> >
> > Could you also please share the kernel log up until the point where it hangs?
> >
> The set_variable seems to be ok in 5.19+:
> root@:~# efibootmgr -t 10
> BootCurrent: 0000
> Timeout: 10 seconds

I think what we want to learn is whether efibootmgr -t 10 works in the
latest RC. If not, it would suggest the issue isn't with the seed
setting, but with some other unrelated change.

Can you run efibootmgr -t 10 (or whatever) again on a kernel where
you've commented out these lines in efi.c inside of efisubsys_init():

    if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
        execute_with_initialized_rng(&refresh_nv_rng_seed_nb);

-->

    // if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
    //     execute_with_initialized_rng(&refresh_nv_rng_seed_nb);

Or something like that.

Jason
