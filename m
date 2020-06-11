Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28811F7064
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgFKWjU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Jun 2020 18:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKWjU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Jun 2020 18:39:20 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110552074B
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591915160;
        bh=HBbpxuPy4IQcGtrkGpRbuKnNpPVCJCSL/JSzmiPB+Hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VDm8SveDJ3su8/MsGDMMHmzdTaPVb5WtcLTNer0VucDc+Wt5yrVtuUEHP34MEaVQQ
         U9Oj6zoWRXmoA/N26OOraDYIl0l6kpXYQb1Ax+tllhlr1I82Ja1VOSC5E7Ck9KhRyJ
         YtNx35AyegoQWB4DtMs4VD0diqZk3K76A+oMEckc=
Received: by mail-oo1-f54.google.com with SMTP id k7so1554698ooo.12
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 15:39:20 -0700 (PDT)
X-Gm-Message-State: AOAM53145dLnAnDKE3QOSA2gwQDCGqQUxYQiFpjrhPNP8g7xDbVE/gTX
        w8xM6LGYw5j+PPfl58G0xzX6X53tpVlPBvgUkf0=
X-Google-Smtp-Source: ABdhPJxbrTl96LE5CGY5bB/Vvn0p/rGMbXaHS9Yk91JFHuzA0BWVkW8e9wC7xMSczU0L024lUpYVVCAXmzmSzf/bS5U=
X-Received: by 2002:a4a:896e:: with SMTP id g43mr8468004ooi.13.1591915159403;
 Thu, 11 Jun 2020 15:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200607135834.898294-1-ardb@kernel.org> <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de> <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
 <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de> <CAMj1kXGLoKDLJAihThkkcYwNpr12inneEB3dMOqvcZFm9oR5_w@mail.gmail.com>
 <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com> <20200611223800.GZ1551@shell.armlinux.org.uk>
In-Reply-To: <20200611223800.GZ1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 Jun 2020 00:39:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+y=Q+-wZaPT6ap278OfP2wbBM3CCvyHCL9K=AaBbO=A@mail.gmail.com>
Message-ID: <CAMj1kXE+y=Q+-wZaPT6ap278OfP2wbBM3CCvyHCL9K=AaBbO=A@mail.gmail.com>
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

On Fri, 12 Jun 2020 at 00:38, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 12, 2020 at 12:18:43AM +0200, Ard Biesheuvel wrote:
> > I've given this a spin myself on a RPi4 running 32-bit U-boot, and
> > everything works as expected, both with and without the GRUB hack
> > enabled.
> >
> > Russell, given that this only affects code inside #ifdef
> > CONFIG_EFI_STUB, do you have any objections to me taking this as a fix
> > via the EFI tree? I have a set of fixes I need to queue up and send
> > out anyway, and I intend to do so early next week.
>
> Please don't, I'll be basing my branches off -rc1 (as normal), and if
> you then submit this as a fix through the EFI tree for merging after
> rc1, and then send me further EFI work to go through the ARM tree,
> we'll end up in exactly the same merge issues as we did prior to this
> merge window.
>

Fair enough. What do you suggest instead? Shall I drop this into the
patch system?
