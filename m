Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E621D110263
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLCQdp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 11:33:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36347 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCQdo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 11:33:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so4255831wma.1
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7Rl2ommOFpZyqjc2xIe8+dnrgxiLpTR5CzNoZds2fo=;
        b=une3qIndSJoWVUjUi/0G2NHM2XesEgfnFTKtTU+VgTVszaqX3h6Wb+mFixhVGnisgu
         BkiRet5AUR6u9LLTh7N3nXmJPe6DST9mRqyMqbCjWaLz4kV7AzyBC5ZPQtRSjM6emySf
         gnHSd9TIzowsdY17wvPIrfZQwL6KJWh6fdudKc/BOCYU95F2QnBBlSYcXaRidjd8NUVe
         1/mHBV6Zy8wIObKW+ZcnpDneiahFLPFvIHmH9P6Tgysi7bk69dIaPrQExBB1uPenMzRa
         jElTuYb07v2FBhGMX96XnDGH161CgmXXsBztnxjZjDBgfQUV2uOUsfCP9u8NtphdW7+y
         SH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7Rl2ommOFpZyqjc2xIe8+dnrgxiLpTR5CzNoZds2fo=;
        b=ZuUitEO5SKuk4KrGk1T2zYDqmEUrxSolj+1NuDmEQZS/zaAYoPPEEWaHKAkgtTpxGG
         0Cn+XL96IiYrvAj9lj1CHxZgt4DjXYK6R6QMa+OsjFul4jAltaH6xUADp+D2ukhcOT1T
         btqN4QGwO6wG16JEUICZ9pIS8KRFCZ5bIvOVOHamtqiZUtOM0F8ucBBSWfli5DaNx+RO
         7RMS+d9T3ifajSovzGPMamSDdrO32W+NR85xNElixGGT6M9Gta0AAtauAwE2+UeHnoAd
         RV9IICWNPacP3L94YLS2IpoF/MUB6Ue+q6+7TEz9GSFXRwsQC+jHrrvEpGuXxhF7jXPE
         k7Nw==
X-Gm-Message-State: APjAAAUjnyCMT/aIj1aJ6d6jckJhm4YdhZrSbshQi2z27M+MBIJrSG5p
        Fh5l3XtykiPAWE/LyZoyGAUh49/Ho28mWKEkxbKheQ==
X-Google-Smtp-Source: APXvYqwin1u3AXgG2PuZ9aX89PaAGoHK2R75waW23arJcmIP7D3A/I5KQuhmkVgKQRud4tIQfFjqshT3/nlrzS64a9U=
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr15345919wmm.61.1575390822794;
 Tue, 03 Dec 2019 08:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com> <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
In-Reply-To: <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Dec 2019 16:33:37 +0000
Message-ID: <CAKv+Gu8ohahrVVvMO0FfJPQL+Um5HoL=OFegTD25RwBP6rgLHQ@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Dec 2019 at 15:30, Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Mon, Dec 2, 2019 at 4:41 PM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > Add an option to disable the busmaster bit in the control register on
> > all PCI bridges before calling ExitBootServices() and passing control to
> > the runtime kernel. System firmware may configure the IOMMU to prevent
> > malicious PCI devices from being able to attack the OS via DMA. However,
> > since firmware can't guarantee that the OS is IOMMU-aware, it will tear
> > down IOMMU configuration when ExitBootServices() is called. This leaves
> > a window between where a hostile device could still cause damage before
> > Linux configures the IOMMU again.
> >
> > If CONFIG_EFI_NO_BUSMASTER is enabled or the "disable_busmaster=1"
> > commandline argument is passed, the EFI stub will clear the busmaster
> > bit on all PCI bridges before ExitBootServices() is called. This will
> > prevent any malicious PCI devices from being able to perform DMA until
> > the kernel reenables busmastering after configuring the IOMMU.
>
> I hate to be an obnoxious bikeshedder, but I really dislike the
> "disable_busmaster" name.  I read this and $SUBJECT as "for some
> reason, the admin wants to operate the system with busmastering off".
> What you really want is something more like "disable busmastering
> before IOMMU initialization".  Maybe
> "iommu.disable_busmaster_before_init"?
>
> Similarly, EFI_NO_BUSMASTER sounds like a permanent state of affairs.
>
> Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> is busmastering on when the kernel is loaded?
>

Yes, bus mastering is on, but since legacy BIOS may implement things
like PS/2 emulation or other compatibility hacks where the PCI masters
(devices or bridges) may need to be left enabled across the transition
from firmware into the OS, I don't think it is wise to try and
implement this feature for it.

So the EFI stub is a reasonable place to put a feature like this,
except for the fact that [on x86], it does not get invoked unless GRUB
boots your kernel with 'linuxefi' rather than 'linux', and so in the
majority of cases, I guess we are essentially doing legacy BIOS boot,
even on UEFI systems.
