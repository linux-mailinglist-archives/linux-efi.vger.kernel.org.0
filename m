Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6428118A7E
	for <lists+linux-efi@lfdr.de>; Thu,  9 May 2019 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEINXy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 May 2019 09:23:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35400 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfEINXy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 May 2019 09:23:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3212589wmd.0
        for <linux-efi@vger.kernel.org>; Thu, 09 May 2019 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUyUc8V5gNpWWfYUQ1IWXC66UpXqeY/PjMWIhrRlCVU=;
        b=VObASKIi152VlCxeaXNXDF2optxvisuRWb92pWwEkqVMU1J1cOdGTNxwpT9ueQuKO6
         IxsnYKjFlWnq+mbkZ+PHUG9gtzB5OoGkqa6uqtNqVIQRGl3EeMgHJSXwfSoP52LAtM0Y
         x1cIrOKR2toq6yRGwnCk8owO8qKOvGBAoy9cEg+/mOAWQqRRa+0kcMayDflIm1M7mpSb
         GSjDtD4M/nj/Nxz7/Ex3r1yY0j/sQeSLN+FOg9cv11FoIK0ESOvfF4IL5k+VlYPAxiD9
         nJFm7j6u8KKuHuICxDXh8EOszSOQpVVgRUvx3scp7zmDyxAm2sczmRiIVHjBPyNXFhq6
         ubgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUyUc8V5gNpWWfYUQ1IWXC66UpXqeY/PjMWIhrRlCVU=;
        b=sNCaDLFJQu13fkj6NVOA2catgKI61dLuhB9rS2aZFfvw87D0P/Bwbf6Jc56t3tfyM7
         BTX9ufQFq8PNHI0QyeaeNjJP9i4XdbMhEBVngXeJlKzXKUTr7/9FdLicUctCXALucd+r
         hSbvWgTu/iKtgqjF4nLobxvXqoC6uZLY9j5kCnQlzcaUSPRWUzgiSa+GpPbHTo1QMAMJ
         0X54nsdDPBeKF+OisJPCGUl3pIr3fo76oxQlk3dqKp4V+NflSMXrR/6+A/lC55jlAGUo
         IFundqJmH4nXX43epH3sy1qQfpTKaL4GZaDt4HzTBy2pEGNXDa++L9bbNZtQ060Mfis8
         xEow==
X-Gm-Message-State: APjAAAV1msM0AyXroQ5zI85XII0BaXJ7NQ5bKf/YcD2EWbi+QI/AyayE
        +nppg1YtAGpB6c0Gkt9fedOKWnLNk+js7aB5AeE=
X-Google-Smtp-Source: APXvYqyDtW3houIUHJ0hhXVCtuzPZKlI4VBSir4cxI0Ppk2JuCFHcPr43B4S2fuT09lZvs8pVJynI7c1JQEUGzh2LHQ=
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr2937340wme.152.1557408232605;
 Thu, 09 May 2019 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190423144354.3465-1-ard.biesheuvel@linaro.org>
 <CADvTj4pYsCq8ZgcL7kELuT77URZbaDmDe-o8qj-M97e0aeCGUw@mail.gmail.com> <CAKv+Gu_EN2A9fBOuw34xw=Exjbqz_0J7BzrOb2ZuWK26ouxtCQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_EN2A9fBOuw34xw=Exjbqz_0J7BzrOb2ZuWK26ouxtCQ@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 9 May 2019 15:23:41 +0200
Message-ID: <CADvTj4r4bJFHU6XELFrJ9DsT9Ao92BbcHr0GhtYzFVs8+JrTSQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev/efifb: ignore framebuffer memmap entries that lack
 any memory types
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 23, 2019 at 5:38 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 23 Apr 2019 at 17:01, James Hilliard <james.hilliard1@gmail.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 4:44 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > Commit 38ac0287b7f4
> > >
> > >   ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> > >
> > > updated the EFI framebuffer code to use memory mappings for the linear
> > > framebuffer that are permitted by the memory attributes described by the
> > > EFI memory map for the particular region, if the framebuffer happens to
> > > be covered by the EFI memory map (which is typically only the case for
> > > framebuffers in shared memory). This is required since non-X86 systems
> > > may require cacheable attributes for memory mappings that are shared
> > > with other masters (such as GPUs), and this information cannot be
> > > described by the Graphics Output Protocol (GOP) EFI protocol itself,
> > > and so we rely on the EFI memory map for this.
> > >
> > > As reported by James, this breaks some x86 systems:
> > >
> > >   [ 1.173368] efifb: probing for efifb
> > >   [ 1.173386] efifb: abort, cannot remap video memory 0x1d5000 @ 0xcf800000
> > >   [ 1.173395] Trying to free nonexistent resource <00000000cf800000-00000000cf9d4bff>
> > >   [ 1.173413] efi-framebuffer: probe of efi-framebuffer.0 failed with error -5
> > >
> > > The problem turns out to be that the memory map entry that describes the
> > > framebuffer has no memory attributes listed at all, and so we end up with
> > > a mem_flags value of 0x0.
> > >
> > > So work around this by ensuring that the memory map entry's attribute field
> > > has a sane value before using it to mask the set of usable attributes.
> > >
> > > Reported-by: James Hilliard <james.hilliard1@gmail.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >
> > > James, could you give this a try please? Thanks.
> > I can confirm this fixes the regression on my system, thanks.
>
> Thanks James, I will add your tested-by.
>
> I forgot to include EFI_MEMORY_UC in the first mask, so I will respin
> and resend.
Is there an updated patch I should test?
>
> Ingo, Bartlomiej, may i suggest that we take this into tip directly as
> a fix? Thanks.
>
>
> > >
> > >  drivers/video/fbdev/efifb.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > > index ba906876cc45..1f9949f50900 100644
> > > --- a/drivers/video/fbdev/efifb.c
> > > +++ b/drivers/video/fbdev/efifb.c
> > > @@ -476,8 +476,11 @@ static int efifb_probe(struct platform_device *dev)
> > >                  * If the UEFI memory map covers the efifb region, we may only
> > >                  * remap it using the attributes the memory map prescribes.
> > >                  */
> > > -               mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
> > > -               mem_flags &= md.attribute;
> > > +               md.attribute &= EFI_MEMORY_WC | EFI_MEMORY_WT | EFI_MEMORY_WB;
> > > +               if (md.attribute) {
> > > +                       mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
> > > +                       mem_flags &= md.attribute;
> > > +               }
> > >         }
> > >         if (mem_flags & EFI_MEMORY_WC)
> > >                 info->screen_base = ioremap_wc(efifb_fix.smem_start,
> > > --
> > > 2.20.1
> > >
