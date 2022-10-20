Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63836066DA
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJTRRB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJTRRA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499D1A5B01
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808CB61C14
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47770C433C1;
        Thu, 20 Oct 2022 17:16:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bkmaOnj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666286216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+/mwcTVNB6b2ifOkK+X9f2lAbXl2uGHxf5obbvj/mc=;
        b=bkmaOnj0SsoF/6Gw2GwUPFYK8I8kGnbT51yjN8wzL/I3GlLEUrt0QhlqoJS7qdssZDZRI1
        nDcutRRn3Bz3nulG+N3mAK6MXMQs5OBG+6whMFjny9UtWavvow7MkGkzJ1mtth1R8wBs9c
        FBLGvh7KPP1iSBztPULJboBjO/o0xaE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6d73768a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 17:16:56 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:16:54 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v3 0/3] efi: consume random seed provided by loader
Message-ID: <Y1GChlADTKNw94pX@zx2c4.com>
References: <20221020083910.1902009-1-ardb@kernel.org>
 <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
 <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 20, 2022 at 07:06:33PM +0200, Ard Biesheuvel wrote:
> On Thu, 20 Oct 2022 at 18:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 2:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > For maximum simplicity, just concatenate the existing seed with the one
> > > obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
> > > the core kernel code to mix it in and credit it appropriately. This way,
> > > we have no need for copies of the Blake2s library in the EFI stub and in
> > > the zboot decompressor.
> >
> > FTR, while I think this is okay for the final stage that the kernel's
> > EFI loader does, it's less good for earlier stages. So, for example,
> > systemd-boot should still use the hashing scheme we discussed.
> 
> Not sure I follow. systemd-boot will put a seed in memory and publish
> it via the the table. How does hashing come into play here?

If systemd-boot is executed by another bootloader.
