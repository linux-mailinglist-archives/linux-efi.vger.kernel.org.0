Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AF60671E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJTRgX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJTRgV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8435913ECC5
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3239DB828A1
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8825C433D7
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:36:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D+Z+d+V0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666287372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mbsh/6ZrlZii+V297OVDsAlX030sanwdoKGmN3GrmY=;
        b=D+Z+d+V0LT75wc7NWybPUtNFeSkHTRxsNRx7gGHZAO/ISxK4CtQdwqjIgi2oODADCT0RCt
        aQgNZi76UkrtVRk5cBYMYufAlypx1QVpprnBmpPpwOOPQMStdiF4+tbYLZoVXjgJ87LxJs
        MDExu4mtjUNwir5tIe/Ski31AG97kIs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3348ec93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 20 Oct 2022 17:36:11 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id h25so177719vkc.6
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:36:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf2pOOLDsz/e2jMpyratRR190NmUoffH50nT/BVg3gOTGq9DBZsa
        Mn74FnxY7fXtRgtlseJiM6XrUtyolPq6+YJLoL8=
X-Google-Smtp-Source: AMsMyM6QGrb9WD30GUB1REoX8/8K6FOF16s+ju/Z00Uxvvp4nnsos0hudibPMjrUH7xgy0mdJq1UIY5onxhSeVw0318=
X-Received: by 2002:a1f:e0c4:0:b0:3ab:191d:e135 with SMTP id
 x187-20020a1fe0c4000000b003ab191de135mr7622198vkg.41.1666287370746; Thu, 20
 Oct 2022 10:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org> <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
 <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com>
 <Y1GChlADTKNw94pX@zx2c4.com> <CAMj1kXGwzo5f_6Rrip0ferTednnvy14NSOXyuACBq55cgaVMeQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGwzo5f_6Rrip0ferTednnvy14NSOXyuACBq55cgaVMeQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Oct 2022 11:35:59 -0600
X-Gmail-Original-Message-ID: <CAHmME9pF3ZVt4j1NLXviMtr92ATPBjPK-oHCZ43PC4DQAbfCAg@mail.gmail.com>
Message-ID: <CAHmME9pF3ZVt4j1NLXviMtr92ATPBjPK-oHCZ43PC4DQAbfCAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] efi: consume random seed provided by loader
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 20, 2022 at 11:27 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 20 Oct 2022 at 19:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 07:06:33PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 20 Oct 2022 at 18:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Thu, Oct 20, 2022 at 2:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > For maximum simplicity, just concatenate the existing seed with the one
> > > > > obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
> > > > > the core kernel code to mix it in and credit it appropriately. This way,
> > > > > we have no need for copies of the Blake2s library in the EFI stub and in
> > > > > the zboot decompressor.
> > > >
> > > > FTR, while I think this is okay for the final stage that the kernel's
> > > > EFI loader does, it's less good for earlier stages. So, for example,
> > > > systemd-boot should still use the hashing scheme we discussed.
> > >
> > > Not sure I follow. systemd-boot will put a seed in memory and publish
> > > it via the the table. How does hashing come into play here?
> >
> > If systemd-boot is executed by another bootloader.
>
> And that bootloader creates the same table, then systemd-boot does it, etc etc?

Yea, the idea being all the bootloaders chain things forward by hashing.
