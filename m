Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681D317A09B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCEHj4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 02:39:56 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:52230 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEHj4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 02:39:56 -0500
X-Greylist: delayed 6532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 02:39:54 EST
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0257dgln022909;
        Thu, 5 Mar 2020 16:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0257dgln022909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583393983;
        bh=DE9J2HMf/HaJpnaqnbOVLXd0Z69euyhFlSalQuaonbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e27tLHpq7GzU9nMefpwuksqrk+uwyaOINtOZ7FAUt6ytvta7tXaRbC6Pi6XJyQpSp
         LbPyhIKnwQcW6uHIrqu4NmVesMzrHtsW8cqE+/adOVFYTrzk3Mj1geDZxducAJeXtZ
         W5FdYrWJ89JO4QU/tIk/bJNPGuk25vexRYay25COTp+tktI1A9vhpEE0C8slzXtlHg
         9TCJxSy1IjDX0hljXj/sfbDVsVK3XlEsWjaI1sAslW4HcWF5LcOn+0Hr5j0MnesffU
         s/E11y4tc2xxAABn9SUIaPsRRksNg5LbyrIU6rxi4S/EXTuG6PgYbbH8yd5kJMpAnM
         ym6qVVxj03REA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id u24so2934798vso.11;
        Wed, 04 Mar 2020 23:39:43 -0800 (PST)
X-Gm-Message-State: ANhLgQ2Ck5jk8GMqZUAGgmE3VS2Ucz/K3SVlSph2ZxHkk6USjtJbQ7H4
        4OpEqMhoH0OGGZ11gQf3fgXiCPtCMbpnLX7/z5s=
X-Google-Smtp-Source: ADFU+vuCr1dtv82gw0wXFgDh4OsJ2jvS3mMr3qSivpIWW2hyBlt4YX9KUTipyiQFX+m9dOLscgf0ErpoF9GeJ3DCVdg=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr4200678vsd.181.1583393982391;
 Wed, 04 Mar 2020 23:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20200305055047.6097-1-masahiroy@kernel.org> <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Mar 2020 16:39:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
Message-ID: <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 5, 2020 at 4:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 5 Mar 2020 at 06:50, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > drivers/firmware/efi/libstub/Makefile is supposed to create a static
> > library, which is not directly linked to vmlinux.
> >
>
> This is not true for arm64. Does that matter?



Yeah, I know.  arm64 vmlinux links it
(but in a different manner from normal lib.a )


Shall I rephrase this paragraph as follows?

drivers/firmware/efi/libstub/Makefile is supposed to create a static
library, which is not directly linked to vmlinux on ARCH=arm, x86.



This is just a matter of whether linking
unneeded lib-ksyms.o or not.





> > Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
> > reliably"), any Makefile using lib-y generates lib-ksyms.o which is
> > linked into vmlinux.
> >
> > In this case, the following garbage object is linked into vmlinux.
> >
> >   drivers/firmware/efi/libstub/lib-ksyms.o
> >
> > We do not want to link anything from libstub/ directly to vmlinux,
> > so using subdir-y instead of obj-y is the correct way to descend into
> > this directory.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  drivers/firmware/efi/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index 554d795270d9..4fd2fa02f549 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -19,7 +19,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         += efi-pstore.o
> >  obj-$(CONFIG_UEFI_CPER)                        += cper.o
> >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> > -obj-$(CONFIG_EFI_STUB)                 += libstub/
> > +subdir-$(CONFIG_EFI_STUB)              += libstub
> >  obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
> >  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
> >  obj-$(CONFIG_EFI_TEST)                 += test/
> > --
> > 2.17.1
> >



-- 
Best Regards
Masahiro Yamada
