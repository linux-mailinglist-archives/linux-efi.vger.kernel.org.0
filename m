Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9A17A0A9
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCEHr2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 02:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgCEHr2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Mar 2020 02:47:28 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392A120870
        for <linux-efi@vger.kernel.org>; Thu,  5 Mar 2020 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583394447;
        bh=uYnZ8RHtPgOP0bMawYXhsO4Ftw7rRBzo1uB+1SPw8Tk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZDPUVnTrYZWbY/bp0iouzuzOe/egonJiJF8W5yqlXcdcvLABGWIM2ZJS/gjqIWWR
         0uoeBC7VjBHmxh5TRw55FaU73855VpMjfK4zV3r3yqOU4Nf4vuL/TyE89uqzcPVsq6
         9gx/CsLPFb8GhZbkTWeQCMIKrLHJWHygL5G+6ow8=
Received: by mail-wm1-f45.google.com with SMTP id 6so5049692wmi.5
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 23:47:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ0ImhSZbNW0ok8q3NXLp5eJNMqZFiEhUgA27nfF5R+cGQtqPAbb
        7nLln9SAE6iIew+x6br6wRiusXWN25uVHdmddkZpUg==
X-Google-Smtp-Source: ADFU+vsoa1s+f4+HYz7apQWwuAhfOae5XkffzCXVQ4Bm3Ifg0B2MiPly03//GtukTrjQ7r7KJ3QBW3+/1vaSSpYIGCQ=
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr7771511wmm.40.1583394445713;
 Wed, 04 Mar 2020 23:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20200305055047.6097-1-masahiroy@kernel.org> <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
 <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
In-Reply-To: <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:47:15 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
Message-ID: <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Mar 2020 at 08:39, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Mar 5, 2020 at 4:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 5 Mar 2020 at 06:50, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > drivers/firmware/efi/libstub/Makefile is supposed to create a static
> > > library, which is not directly linked to vmlinux.
> > >
> >
> > This is not true for arm64. Does that matter?
>
>
>
> Yeah, I know.  arm64 vmlinux links it
> (but in a different manner from normal lib.a )
>
>
> Shall I rephrase this paragraph as follows?
>
> drivers/firmware/efi/libstub/Makefile is supposed to create a static
> library, which is not directly linked to vmlinux on ARCH=arm, x86.
>
>
>
> This is just a matter of whether linking
> unneeded lib-ksyms.o or not.
>

How about

"""
drivers/firmware/efi/libstub/Makefile builds a static library, which
is not linked into the main vmlinux target in the ordinary way
[arm64], or at all [ARM, x86]
"""



>
>
>
>
> > > Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
> > > reliably"), any Makefile using lib-y generates lib-ksyms.o which is
> > > linked into vmlinux.
> > >
> > > In this case, the following garbage object is linked into vmlinux.
> > >
> > >   drivers/firmware/efi/libstub/lib-ksyms.o
> > >
> > > We do not want to link anything from libstub/ directly to vmlinux,

and

"""
We do not want to follow the default linking rules for static
libraries built under libstub/
"""

If you agree, no need to resend, I'll fix it up when applying


> > > so using subdir-y instead of obj-y is the correct way to descend into
> > > this directory.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  drivers/firmware/efi/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > > index 554d795270d9..4fd2fa02f549 100644
> > > --- a/drivers/firmware/efi/Makefile
> > > +++ b/drivers/firmware/efi/Makefile
> > > @@ -19,7 +19,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         += efi-pstore.o
> > >  obj-$(CONFIG_UEFI_CPER)                        += cper.o
> > >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> > >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> > > -obj-$(CONFIG_EFI_STUB)                 += libstub/
> > > +subdir-$(CONFIG_EFI_STUB)              += libstub
> > >  obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
> > >  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
> > >  obj-$(CONFIG_EFI_TEST)                 += test/
> > > --
> > > 2.17.1
> > >
>
>
>
> --
> Best Regards
> Masahiro Yamada
