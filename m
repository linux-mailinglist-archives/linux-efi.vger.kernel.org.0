Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA153D89FE
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jul 2021 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhG1Iup (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Jul 2021 04:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhG1Iup (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 28 Jul 2021 04:50:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD0960462;
        Wed, 28 Jul 2021 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627462244;
        bh=veoYV/qgiA+7ByvVx2DahTLqqKTa0drP2DFUDRibq88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IrJN48/aK2KtespALOaANhFr299gcwpOFUn8TBjiKEPtgbr3zrrKuEElnNNpaNeIR
         x/ekblVpjN5GWAktJJcu/LCmp4eiy4cxm3ZJEi0sna854+/N7qH/hRSY5XMtw/98C8
         ceWz+4KJOEpmk7kS0UQl5Yl/xcTEQ39hjPbAWEwdZMZKC8GLRMBiJqtNsoG9IzIeKH
         +lhaMuIB5NubVKpf6rBruSJfFTf+AIYv3xEcIFD0tZ6qLqKOxpie5bqy7Tk9vBjCYt
         S2ReBnhjvUd7ZThkHAfF30DBu+HcPTkyzaSnklK334KaWMnU4oCvXaHgThuG7Rqrwd
         YXpepTdKjZWVw==
Received: by mail-oo1-f47.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so477980ooa.11;
        Wed, 28 Jul 2021 01:50:44 -0700 (PDT)
X-Gm-Message-State: AOAM533yQppBIP8ceLAQmPQ5lZKfdBtgfw9d2ombKq45z2oVbaBzfR0q
        hQsdtIy717YmNlCo6re6RyIHqzLYdwmE2GPYPrk=
X-Google-Smtp-Source: ABdhPJwO7poQ8JrF0ugXLbp8aSgdptes3oVmuxzJy1FXwX1z1W7sy1X6WlqFmeGXGMK2zRDfSPuyh4CviDRdHGFSSAk=
X-Received: by 2002:a4a:414e:: with SMTP id x75mr7194341ooa.13.1627462243546;
 Wed, 28 Jul 2021 01:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210727050447.7339-1-rdunlap@infradead.org> <CAMuHMdXrDLvPRNMy_pEtu1u=7ML8GT3mpKLba8vRnHU3iF8U+w@mail.gmail.com>
In-Reply-To: <CAMuHMdXrDLvPRNMy_pEtu1u=7ML8GT3mpKLba8vRnHU3iF8U+w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 28 Jul 2021 10:50:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVYneiWtiq7PcpMSL_u2K6YJvgkr9hTO2m81bYbs1WWQ@mail.gmail.com>
Message-ID: <CAMj1kXFVYneiWtiq7PcpMSL_u2K6YJvgkr9hTO2m81bYbs1WWQ@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 28 Jul 2021 at 10:39, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Randy,
>
> On Tue, Jul 27, 2021 at 7:06 AM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> > When # CONFIG_EFI is not set, there are 2 definitions of
> > sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
> > and the __init function from sysfb_efi.c should not be used.
> >
> > ../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of =E2=
=80=98sysfb_apply_efi_quirks=E2=80=99
> >  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> >              ^~~~~~~~~~~~~~~~~~~~~~
> > In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
> > ../include/linux/sysfb.h:65:20: note: previous definition of =E2=80=98s=
ysfb_apply_efi_quirks=E2=80=99 was here
> >  static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
> >                     ^~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks for your patch!
>
> > --- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
> > +++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
> > @@ -332,6 +332,7 @@ static const struct fwnode_operations ef
> >         .add_links =3D efifb_add_links,
> >  };
> >
> > +#ifdef CONFIG_EFI
> >  static struct fwnode_handle efifb_fwnode;
> >
> >  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> > @@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
> >                 pd->dev.fwnode =3D &efifb_fwnode;
> >         }
> >  }
> > +#endif
>
> How come you enter drivers/firmware/efi/ without CONFIG_EFI?
>
> Oh:
>
> drivers/firmware/Makefile:obj-$(CONFIG_EFI)             +=3D efi/
> drivers/firmware/Makefile:obj-$(CONFIG_UEFI_CPER)               +=3D efi/
>
> Looks like UEFI_CPER is not related to EFI at all (it's not set in
> my arm64 config which has CONFIG_EFI=3Dy). Perhaps it should be moved
> to drivers/acpi/ instead?
>

I think we should move this into drivers/firmware/cper/ instead, or
simply into drivers/firmware/
