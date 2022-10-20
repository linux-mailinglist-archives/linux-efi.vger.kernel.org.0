Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C0606702
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJTR2g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJTR2T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76111DA9E
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C016B82886
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF27C433D6
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666286876;
        bh=TBaUUIDVBJRENh3ZjV5OYwdo59tRhJvpADRNBPFpI/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mC8V74YPBVvvRmp9WbEqIpVoK1VJ41J6Xg0tzcLY17Yd9micvJZf4A8cuT+YzuoMj
         AyFkPM0ocvXxTQQbQapq5BvpcsXxMc+nH5s0NIFzLh2wvE72jFUv+gtfxijpfec0qE
         vtf9TvGkRom3d46Eiun9tpBaupx3gkqoR5ic6S37m+G7TzunEM0Tno8u7mFMN1s+Q9
         gzgknn8FNp/QPskWZATIAi/Isu+crUXhTgJEAUcTfhq0i7AI1uVAUxaRoX/J7o48Ri
         /LvD6KbWfZ95baCAX7qBtkekN51iuRe1thsCDrxe5ChWlVBdQAzkQhnm/q3JHuSH8W
         tt1KCCg1OKjuw==
Received: by mail-lf1-f45.google.com with SMTP id be13so577557lfb.4
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:27:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf3cSYUUts/eF1lGOXShwILd5H1fnuTPEWMrI44pZrVoHk8ZZLZz
        11v0wLlRzCzp+vPWBv8gMTY7/d+5swS0hzfX+MY=
X-Google-Smtp-Source: AMsMyM41A1ALKDa4HcTYp9PP3fdRioLlVl6JRglbDbuZMHNMuWIzHGoaW7RXDEfRvYXxHASTZHe1sUXsUPuJBxmN5Vc=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr4927474lfb.583.1666286873948; Thu, 20
 Oct 2022 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org> <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
 <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com> <Y1GChlADTKNw94pX@zx2c4.com>
In-Reply-To: <Y1GChlADTKNw94pX@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Oct 2022 19:27:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwzo5f_6Rrip0ferTednnvy14NSOXyuACBq55cgaVMeQ@mail.gmail.com>
Message-ID: <CAMj1kXGwzo5f_6Rrip0ferTednnvy14NSOXyuACBq55cgaVMeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] efi: consume random seed provided by loader
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Oct 2022 at 19:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Oct 20, 2022 at 07:06:33PM +0200, Ard Biesheuvel wrote:
> > On Thu, 20 Oct 2022 at 18:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 2:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > For maximum simplicity, just concatenate the existing seed with the one
> > > > obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
> > > > the core kernel code to mix it in and credit it appropriately. This way,
> > > > we have no need for copies of the Blake2s library in the EFI stub and in
> > > > the zboot decompressor.
> > >
> > > FTR, while I think this is okay for the final stage that the kernel's
> > > EFI loader does, it's less good for earlier stages. So, for example,
> > > systemd-boot should still use the hashing scheme we discussed.
> >
> > Not sure I follow. systemd-boot will put a seed in memory and publish
> > it via the the table. How does hashing come into play here?
>
> If systemd-boot is executed by another bootloader.

And that bootloader creates the same table, then systemd-boot does it, etc etc?
