Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9444327CFF2
	for <lists+linux-efi@lfdr.de>; Tue, 29 Sep 2020 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgI2NwD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Sep 2020 09:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgI2NwD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:52:03 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA19A20848
        for <linux-efi@vger.kernel.org>; Tue, 29 Sep 2020 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387522;
        bh=ylsd2gU+x25u4AOw5OXSMDG9SSuYx/FUkBWC264mr30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zxZsKN4dgrVeeDaTvpKRrDwH5ok+7KJw6qQwuKpNObtJ5A9YUCMxdbVK50JJKB4eP
         N5vEfNTC5RXn+duhO/Hh4Fegjjr3WAuPbVKhp1B1RNdqGBxAivUFaqZFvWp3KuJ4wE
         bsJDYAXBCjb+dElBbuGBq11cz74TioSWbV/F/qzI=
Received: by mail-oo1-f49.google.com with SMTP id t3so1277172ook.8
        for <linux-efi@vger.kernel.org>; Tue, 29 Sep 2020 06:52:01 -0700 (PDT)
X-Gm-Message-State: AOAM531hdRa6lW6EantFG6OUwxfqP1ln9egsh9gkkBrasOO/5b7tFjWz
        g9AweFfpsLjAwgURL+equTt72B0RRNJP+k0TT7o=
X-Google-Smtp-Source: ABdhPJwkyQfXPnv7GIzBLTs5EH4QNGTohZkzeObCq7jCSwWzN1XEqplhN70D7miPDMmdZ78I+YZIOpISK0oW5ER4x24=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr4685926ooo.45.1601387521063;
 Tue, 29 Sep 2020 06:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200926085850.16342-1-ardb@kernel.org> <2bad5e33-9b04-5ea3-da29-3eb914ef5436@gmx.de>
 <CAMj1kXF1gpTh5yFopkPmgdiHyC-+qKFrzgJSTynkujWUbwh9bg@mail.gmail.com> <612f4c25-45a8-5912-6661-77f02ef798bb@gmx.de>
In-Reply-To: <612f4c25-45a8-5912-6661-77f02ef798bb@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Sep 2020 15:51:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFibYeei42cZKZ8Mr+ir5Jmj3fn4GpTr7hYh9OMzFTeyQ@mail.gmail.com>
Message-ID: <CAMj1kXFibYeei42cZKZ8Mr+ir5Jmj3fn4GpTr7hYh9OMzFTeyQ@mail.gmail.com>
Subject: Re: [PATCH] efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Scott K Logan <logans@cottsay.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 27 Sep 2020 at 16:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/27/20 11:13 AM, Ard Biesheuvel wrote:
> > On Sun, 27 Sep 2020 at 10:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 9/26/20 10:58 AM, Ard Biesheuvel wrote:
> >>> Currently, on arm64, we abort on any failure from efi_get_random_bytes()
> >>> other than EFI_NOT_FOUND when it comes to setting the physical seed for
> >>> KASLR, but ignore such failures when obtaining the seed for virtual
> >>> KASLR or for early seeding of the kernel's entropy pool via the config
> >>> table. This is inconsistent, and may lead to unexpected boot failures.
> >>>
> >>> So let's permit any failure for the physical seed, and simply report
> >>> the error code if it does not equal EFI_NOT_FOUND.
> >>>
> >>> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Hello Ard,
> >>
> >> thank you for providing the patch. Unfortunately this seems not to be
> >> enough for booting with an EFI_RNG_PROTOCOL.GetRng() returning
> >> EFI_UNSUPPORTED.
> >>
> >> This is the output I received on v5.9-rc6, defconfig with your patch
> >> applied. I can retry with a branch from
> >> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/ if you
> >> indicate which one to use.
> >>
> >> EFI stub: Booting Linux Kernel...
> >> EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000003),
> >> KASLR will be disabled
> >> EFI stub: Using DTB from configuration table
> >>
> >> EFI stub: Exiting boot services and installing virtual address map...
> >>
> >> EFI stub: ERROR: Unable to construct new device tree.
> >> EFI stub: ERROR: Failed to update FDT and exit boot services
> >>
> >> This matches the problem originally reported by Scott.
> >>
> >
> > OK, so we need something like the below as well:
> >
> > --- a/drivers/firmware/efi/libstub/fdt.c
> > +++ b/drivers/firmware/efi/libstub/fdt.c
> > @@ -145,8 +145,6 @@ static efi_status_t update_fdt(void *orig_fdt,
> > unsigned long orig_fdt_size,
> >                         status = fdt_setprop_var(fdt, node,
> > "kaslr-seed", fdt_val64);
> >                         if (status)
> >                                 goto fdt_set_fail;
> > -               } else if (efi_status != EFI_NOT_FOUND) {
> > -                       return efi_status;
> >                 }
> >         }
> >
> >
> > Could you please check whether that fixes the issue?
> >
>
> The new change allows booting.
>
> I could not observe the new message from the patch on my ARM64 system.
> The only related messages I found are:
>
> [  +0.000000] efi: EFI v2.80 by Das U-Boot
> [  +0.000000] efi: RTPROP=0x7aef9040 SMBIOS=0x7aef5000 MEMRESERVE=0x566df040
> [  +0.000000] random: get_random_bytes called from
> start_kernel+0x314/0x4e8 with crng_init=0
> [  +0.003506] KASLR disabled due to lack of seed
>


Thanks. The EFI diagnostic messages are usually written directly to
the serial console - they are not captured by dmesg.
