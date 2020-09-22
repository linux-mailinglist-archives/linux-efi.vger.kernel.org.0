Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95469273B42
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgIVGzM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 02:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgIVGzM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 02:55:12 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51518239E5
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600757711;
        bh=dFNrRvC+NuDy2tRnbW+eNwvFpmxiwQ74O9HFV8TJF7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gjHjIJphelXBGuvzLqDC4qrxuY+1bNpxBi2K/EsSEoXRoOB3mrxDU/PQywReICgaT
         rWbjSjFSOfbW62ateNUP6ax/1UsuuHVD392hqHFhTzLAoqf/RTcWHkvIQyAyecxssV
         FhNlQkSIZuE/BtU7FSL2oU6YIuh5LrLCcnIVrQVM=
Received: by mail-ot1-f44.google.com with SMTP id o6so14691774ota.2
        for <linux-efi@vger.kernel.org>; Mon, 21 Sep 2020 23:55:11 -0700 (PDT)
X-Gm-Message-State: AOAM531a7V/DwoabFNOXRAOcS0waX8Mi4nEZ/1BYi5/mF57QhgJaEm6X
        o/Y75rmpZj7PBXmriVL+jhtNqBQ0V/QGMbZ6IB0=
X-Google-Smtp-Source: ABdhPJyPRN9tLS0tlvjIvNXJcHmY6RJvetbQ2jtrZq+FHqvjJBat6KUBVLxEBDLJSmeP/ISeBfs8iSj/QCyaSa0t/FQ=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1889591otk.108.1600757710528;
 Mon, 21 Sep 2020 23:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-2-ardb@kernel.org>
 <20200921221828.GZ1551@shell.armlinux.org.uk>
In-Reply-To: <20200921221828.GZ1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 08:54:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM5ChGpsm4rd0REq5JGhgToL+=ayQE5azzizsaLET+=w@mail.gmail.com>
Message-ID: <CAMj1kXEM5ChGpsm4rd0REq5JGhgToL+=ayQE5azzizsaLET+=w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ARM: p2v: fix handling of LPAE translation in BE mode
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Sep 2020 at 00:18, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Sep 21, 2020 at 05:41:08PM +0200, Ard Biesheuvel wrote:
> > When running in BE mode on LPAE hardware with a PA-to-VA translation
> > that exceeds 4 GB, we patch bits 39:32 of the offset into the wrong
> > byte of the opcode. So fix that, by rotating the offset in r0 to the
> > right by 8 bits, which will put the 8-bit immediate in bits 31:24.
> >
> > Note that this will also move bit #22 in its correct place when
> > applying the rotation to the constant #0x400000.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Should this have a fixes tag?
>

Indeed. I will add

Fixes: d9a790df8e984 ("ARM: 7883/1: fix mov to mvn conversion in case
of 64 bit phys_addr_t and BE")

before I send the PR.


> > ---
> >  arch/arm/kernel/head.S | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index f8904227e7fd..98c1e68bdfcb 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -671,12 +671,8 @@ ARM_BE8(rev16    ip, ip)
> >       ldrcc   r7, [r4], #4    @ use branch for delay slot
> >       bcc     1b
> >       bx      lr
> > -#else
> > -#ifdef CONFIG_CPU_ENDIAN_BE8
> > -     moveq   r0, #0x00004000 @ set bit 22, mov to mvn instruction
> >  #else
> >       moveq   r0, #0x400000   @ set bit 22, mov to mvn instruction
> > -#endif
> >       b       2f
> >  1:   ldr     ip, [r7, r3]
> >  #ifdef CONFIG_CPU_ENDIAN_BE8
> > @@ -685,7 +681,7 @@ ARM_BE8(rev16     ip, ip)
> >       tst     ip, #0x000f0000 @ check the rotation field
> >       orrne   ip, ip, r6, lsl #24 @ mask in offset bits 31-24
> >       biceq   ip, ip, #0x00004000 @ clear bit 22
> > -     orreq   ip, ip, r0      @ mask in offset bits 7-0
> > +     orreq   ip, ip, r0, ror #8  @ mask in offset bits 7-0
> >  #else
> >       bic     ip, ip, #0x000000ff
> >       tst     ip, #0xf00      @ check the rotation field
> > --
> > 2.17.1
> >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
