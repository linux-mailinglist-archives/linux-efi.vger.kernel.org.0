Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34359279FE5
	for <lists+linux-efi@lfdr.de>; Sun, 27 Sep 2020 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgI0JNh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Sep 2020 05:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0JNh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 27 Sep 2020 05:13:37 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD16623977
        for <linux-efi@vger.kernel.org>; Sun, 27 Sep 2020 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601198017;
        bh=UXIlaqw6XTtOGZqQy8V0RsZCAGApl6EZph8+uwfzwe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q/Fr7ZCBZ1O7uonVcSpxqtSvZ+CTO3dHrAqlZEAUNLYTyuM2lwAAZ+fMEw+obmGx2
         2g1C2e/6gIUNlPZHxyFtagdXor3/HvG69egnUWhh/oYEe8xmRL6il8blyWQeDjBj5Y
         y5KipbkuwlS0wLEaCnGQRbtwC+rWob9uXSpkm2Vc=
Received: by mail-oi1-f169.google.com with SMTP id m7so8053204oie.0
        for <linux-efi@vger.kernel.org>; Sun, 27 Sep 2020 02:13:36 -0700 (PDT)
X-Gm-Message-State: AOAM533Cl7c+2fiE9CThaNoBKoLxrDDKr1HQh3NnNI/gbsquE7J/Tgre
        5rGVTu/Qbyx8Q3GAYFZUDxrSGv3vycPBkFeH6no=
X-Google-Smtp-Source: ABdhPJySyZArEfubkzUaY8c0/eOWTFlOMHJyMGa3WOpIHMcvggDlObHf+o7pgEqN42bIRXsBgDO1n77tPZiAmaEX7fo=
X-Received: by 2002:aca:d845:: with SMTP id p66mr2932890oig.47.1601198016197;
 Sun, 27 Sep 2020 02:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200926085850.16342-1-ardb@kernel.org> <2bad5e33-9b04-5ea3-da29-3eb914ef5436@gmx.de>
In-Reply-To: <2bad5e33-9b04-5ea3-da29-3eb914ef5436@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Sep 2020 11:13:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF1gpTh5yFopkPmgdiHyC-+qKFrzgJSTynkujWUbwh9bg@mail.gmail.com>
Message-ID: <CAMj1kXF1gpTh5yFopkPmgdiHyC-+qKFrzgJSTynkujWUbwh9bg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Scott K Logan <logans@cottsay.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 27 Sep 2020 at 10:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/26/20 10:58 AM, Ard Biesheuvel wrote:
> > Currently, on arm64, we abort on any failure from efi_get_random_bytes()
> > other than EFI_NOT_FOUND when it comes to setting the physical seed for
> > KASLR, but ignore such failures when obtaining the seed for virtual
> > KASLR or for early seeding of the kernel's entropy pool via the config
> > table. This is inconsistent, and may lead to unexpected boot failures.
> >
> > So let's permit any failure for the physical seed, and simply report
> > the error code if it does not equal EFI_NOT_FOUND.
> >
> > Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Hello Ard,
>
> thank you for providing the patch. Unfortunately this seems not to be
> enough for booting with an EFI_RNG_PROTOCOL.GetRng() returning
> EFI_UNSUPPORTED.
>
> This is the output I received on v5.9-rc6, defconfig with your patch
> applied. I can retry with a branch from
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/ if you
> indicate which one to use.
>
> EFI stub: Booting Linux Kernel...
> EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000003),
> KASLR will be disabled
> EFI stub: Using DTB from configuration table
>
> EFI stub: Exiting boot services and installing virtual address map...
>
> EFI stub: ERROR: Unable to construct new device tree.
> EFI stub: ERROR: Failed to update FDT and exit boot services
>
> This matches the problem originally reported by Scott.
>

OK, so we need something like the below as well:

--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -145,8 +145,6 @@ static efi_status_t update_fdt(void *orig_fdt,
unsigned long orig_fdt_size,
                        status = fdt_setprop_var(fdt, node,
"kaslr-seed", fdt_val64);
                        if (status)
                                goto fdt_set_fail;
-               } else if (efi_status != EFI_NOT_FOUND) {
-                       return efi_status;
                }
        }


Could you please check whether that fixes the issue?
