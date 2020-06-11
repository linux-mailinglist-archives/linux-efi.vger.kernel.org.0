Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269D1F70C8
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFKXRd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Jun 2020 19:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgFKXRc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Jun 2020 19:17:32 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B0B20878
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591917452;
        bh=fOD6ezCkOVRyI6PhH1XLtKafgMyMH59Fa6W8i7UEx4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/+WzhbdWr95ZdrlKpo/cn+zbcmliZFuKxUpOP+UNioXWQN4kPCbr/eH0Sthcwn4c
         S4tO7VaCtxahqhi5LpSTyB0+a72TjEAak7EXU+/Ijkx/qy6uv77nK3ECy2053Jwi1t
         RuEFyBZuQH3jg3m1HEHEp+A8lU8Im3wO6KixChUI=
Received: by mail-oi1-f172.google.com with SMTP id p70so7006666oic.12
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 16:17:32 -0700 (PDT)
X-Gm-Message-State: AOAM531bOHRMI0Etu21rk+1YKRgYgEaA/RMnD2vuuyj3CTinR7gn1zgw
        Q4HTwJTtEiJYDKkbY/zGwi8FSylDURZqtQGwyQw=
X-Google-Smtp-Source: ABdhPJwNBnjYMi/5e8oSMsVn/eTYdFfpk/D9sszQWxQP+L3G14j9WhMMAckIZrE6+9/rdAlnTM0EftrQNlDT/RBbTBk=
X-Received: by 2002:aca:6144:: with SMTP id v65mr278075oib.33.1591917451480;
 Thu, 11 Jun 2020 16:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200607135834.898294-1-ardb@kernel.org> <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de> <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
 <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de> <CAMj1kXGLoKDLJAihThkkcYwNpr12inneEB3dMOqvcZFm9oR5_w@mail.gmail.com>
 <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com>
 <20200611223800.GZ1551@shell.armlinux.org.uk> <CAMj1kXE+y=Q+-wZaPT6ap278OfP2wbBM3CCvyHCL9K=AaBbO=A@mail.gmail.com>
 <20200611224334.GA1551@shell.armlinux.org.uk>
In-Reply-To: <20200611224334.GA1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 Jun 2020 01:17:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEEd5aO=xHUM901bM_JaJ3rEs6KQ0a20-AOdXUBwK=CEA@mail.gmail.com>
Message-ID: <CAMj1kXEEd5aO=xHUM901bM_JaJ3rEs6KQ0a20-AOdXUBwK=CEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 12 Jun 2020 at 00:43, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 12, 2020 at 12:39:08AM +0200, Ard Biesheuvel wrote:
> > On Fri, 12 Jun 2020 at 00:38, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Jun 12, 2020 at 12:18:43AM +0200, Ard Biesheuvel wrote:
> > > > I've given this a spin myself on a RPi4 running 32-bit U-boot, and
> > > > everything works as expected, both with and without the GRUB hack
> > > > enabled.
> > > >
> > > > Russell, given that this only affects code inside #ifdef
> > > > CONFIG_EFI_STUB, do you have any objections to me taking this as a fix
> > > > via the EFI tree? I have a set of fixes I need to queue up and send
> > > > out anyway, and I intend to do so early next week.
> > >
> > > Please don't, I'll be basing my branches off -rc1 (as normal), and if
> > > you then submit this as a fix through the EFI tree for merging after
> > > rc1, and then send me further EFI work to go through the ARM tree,
> > > we'll end up in exactly the same merge issues as we did prior to this
> > > merge window.
> > >
> >
> > Fair enough. What do you suggest instead? Shall I drop this into the
> > patch system?
>
> Is it a regression?  If so, sending it prior to -rc1 is permissible.
> If not, please drop it in the patch system.
>

If you boot via the EFI stub in HYP mode with the caches off (or with
U-boot's GRUB hack enabled which fiddles with the caches halfway
through), it appears that you cannot boot current mainline. This is an
oversight on my part - the EFI spec does not permit doing either of
those things, and while EDK2 behaves in this regard, u-boot can be
configured in various different non-conforming ways. (Note that v5.7
and before will leave the MMU and caches enabled at HYP upon entering
the kernel proper after booting via EFI, so this is not something that
was 100% correct before, but at least it booted most of the time)

So this is a regression, but since the EFI tree goes through -tip, I
won't be able to get this fix in before -rc1 is released. Therefore, I
will be dropping this into the patch system in any case, and leave it
up to you to decide when it gets sent onwards.
