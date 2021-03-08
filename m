Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B640330F59
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 14:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCHNfI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 08:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhCHNfA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 08:35:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC898651C7;
        Mon,  8 Mar 2021 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615210500;
        bh=rTawbWi2EiTipSD35WcFDQWvztqyfT1kf4GSk63nS5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TJ/WtFXjy6VIYuKCmxpxeI+IH/N4ozgH2gCwkmhQ1SBxElaudqQRAcD4Vnwjudzbo
         c093db6Op/iKj9mJhFpk6wSkNlhvVZEicBtuwIS4U4hfIRis3RNbMZvBfy71T2/Yzd
         YgsZeKzHCzUDWKs+drFIGdlYuKBhVwJTmFXR3cuOGbvkcHlgBPo9cNV7U8cDjR4+lR
         l1/pBKTRuiplxHLswM6QF2paK55PIFUiT8iwbO3pKja/cuTRxwa1nRsiLwHoxW/v3b
         9rncdxZNPb4fMUkMUaU9DSyJDOzbwNP+BePkVW5CehB+24gN1yc3RePAXobl5MChvb
         en1QLpWh6wZXw==
Received: by mail-oi1-f176.google.com with SMTP id w65so10941924oie.7;
        Mon, 08 Mar 2021 05:34:59 -0800 (PST)
X-Gm-Message-State: AOAM530AxL/y3qxtg+31+/ZJnWEmKIIyjEp+YjCXAhcs2U7aTGgmFH9C
        igrzH4WAeWXKskVgngrvYSiDXuCB/unMWQIglBc=
X-Google-Smtp-Source: ABdhPJwFjExhz0x8zws3qpIc86IcyRK/YudaM1nXTdsFqO2kcYDTCERFqe9bdk174D54tcAHBNsGpti81StuHC/h98I=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr17403014oif.47.1615210499273;
 Mon, 08 Mar 2021 05:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
In-Reply-To: <20210307110228.GP17424@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Mar 2021 14:34:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
Message-ID: <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 7 Mar 2021 at 12:02, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> > Allow EFI systems to override the set of supported runtime services
> > declared via the RT_PROP table, by checking for the existence of a
> > 'OverrideSupported' EFI variable of the appropriate size under the
> > RT_PROP table GUID, and if it does, combine the supported mask using
> > logical AND. (This means the override can only remove support, not
> > add it back).
> >
> > Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: Leif Lindholm <leif@nuviainc.com>
> > Cc: linux-arm-msm@vger.kernel.org
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:
>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
>
> With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
> 'efi=novamap' kernel cmdline and get around the broken poweroff runtime
> services nicely.  Thanks!
>

Thanks for confirming.

However, I am not going to merge this without some justification, and
hopefully some input from other folks (Leif?)

RTPROP already provides what we need on all platforms that use
DtbLoader, and the patch for that is queued up for v5.12-rcX, with a
cc:stable to v5.10. This allows any RT service to be marked as
disabled, including SetVirtualAddressMap().

So afaict, that means that this patch would be a special case for
Flex5G, right? So how are platforms such as this one going to load the
DTB? If some loader will be involved (or even just GRUB), shouldn't it
be that component that sets RTPROP like DtbLoader will, not the kernel
itself.

Btw I don't think ACPI boot is a use case here. I don't see a software
framebuffer with no wifi support as a usage mode that justifies
carrying EFI stub hacks for everyone.

-- 
Ard.
