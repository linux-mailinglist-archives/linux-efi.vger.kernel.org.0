Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E832712C8
	for <lists+linux-efi@lfdr.de>; Sun, 20 Sep 2020 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgITHun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Sep 2020 03:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgITHun (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 20 Sep 2020 03:50:43 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848BB207C3
        for <linux-efi@vger.kernel.org>; Sun, 20 Sep 2020 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600588242;
        bh=KmbwzOz8R5w3DRqAK2IS4kwYgSu2Dj1SM/ISdNgrjrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U/ZNc1Qcn+WqPmPGsfVaq4+EmVi55GB9yEGJpUaEONjodSu4LboRKRVtlr+Nypux/
         Y81087B+J/9eT6bA5rdRZt0tqagCe+dfFTSSNOqRSxK0l+ZjQsY+9oW5AMbrxzcRws
         c5xnIFkxQwdYakE5+MFS4/mx1+cG4M2cS/q//skA=
Received: by mail-oi1-f174.google.com with SMTP id x69so13019662oia.8
        for <linux-efi@vger.kernel.org>; Sun, 20 Sep 2020 00:50:42 -0700 (PDT)
X-Gm-Message-State: AOAM5329nlkKdLaooYXjzA5VHKFkZy4cbSqz0Ge14u7OL51yScg3Pq/H
        e9wkiLMFIrEYfMtsXHyPDvLXhucH9ff0E8a5SMQ=
X-Google-Smtp-Source: ABdhPJwMkv9aelF+XheZk/sY1NQtXA2G39QIpEGAHcEdZCFvjjMa50NH00slYkoEbq4isaUqJ2Oxl5m5kqJp0PhyFrU=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr14458357oic.33.1600588241860;
 Sun, 20 Sep 2020 00:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200918103102.18107-1-ardb@kernel.org> <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 20 Sep 2020 09:50:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com>
Message-ID: <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 20 Sep 2020 at 01:49, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 18 Sep 2020, Ard Biesheuvel wrote:
>
> > This series is inspired by Zhei Len's series [0], which updates the
> > ARM p2v patching code to optionally support p2v relative alignments
> > of as little as 64 KiB.
> >
> > Reducing this alignment is necessary for some specific Huawei boards,
> > but given that reducing this minimum alignment will make the boot
> > sequence more robust for all platforms, especially EFI boot, which
> > no longer relies on the 128 MB masking of the decompressor load address,
> > but uses firmware memory allocation routines to find a suitable spot
> > for the decompressed kernel.
> >
> > This series is not based on Zhei Len's code, but addresses the same
> > problem, and takes some feedback given in the review into account:
> > - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
> >   with the carry on LPAE
> > - add support for Thumb2 kernels as well
> > - make the change unconditional - it will bit rot otherwise, and has value
> >   for other platforms as well.
> >
> > The first four patches are general cleanup and preparatory changes.
> > Patch #5 implements the switch to a MOVW instruction without changing
> > the minimum alignment.
> > Patch #6 reduces the minimum alignment to 2 MiB.
> >
> > Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.
>
> At this point I think this really ought to be split into a file of its
> own... and maybe even rewritten in C. Even though I wrote the original
> code, I no longer understand it without re-investing time into it. But
> in either cases the whole of head.S would need to have its registers
> shuffled first to move long lived values away from r0-r3,ip,lr to allow
> for standard function calls.
>

I agree with that in principle, however, running C code with a stack
with the MMU off is slightly risky.

I have managed to simplify the code a bit more (given that some
patching was not needed to begin with), and I can add some more
comments to head.S to annotate the actions.
