Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926F1E51A3
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 01:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgE0XNU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 19:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgE0XNU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 19:13:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91DC08C5C2
        for <linux-efi@vger.kernel.org>; Wed, 27 May 2020 16:13:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l21so30032288eji.4
        for <linux-efi@vger.kernel.org>; Wed, 27 May 2020 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owh+wprAucDYqiOwYs5g0rV2VPgaJE9GgJPCRAVHdsw=;
        b=I3g72xvEhhITHxZc2UHaYQN/usQC0wOCPCnpF16NVNIU5DBpl39GXcvas43iU0S3XG
         9ySrZNrMYRz0/EFfzB0HMkiLOxhTNaJjlaLGlse5vSm5g+mzxbmceHAmv98POnyIBEeL
         XTUUSRfhuRp2ao1WBadscbA7vfh5cZR6hDnBfKsRXU/U36Hv67xk1KfAtp5nXND57Uvy
         VRh0yLByIu2DH7FSvWJ8CUDio/Ozvwlq6MrMEiBwAnFM5D15za6cINGe+E4t7on81hb9
         bnnJTA8lMZwbXLHdYqdfFM+Tl2pPBMqMOGkfrMOQNolrEShXX4NYDFYHozAwCAFTlEBk
         YTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owh+wprAucDYqiOwYs5g0rV2VPgaJE9GgJPCRAVHdsw=;
        b=PoUIieyyw6zAvIzSBCUQ1eYQqL9O1D2zlQLP5AbP0AsbKiNbeh7tHycPGU7Asm15rm
         eE9/jOR3fME6ElsUUGywnfKy/MkpT91KhdI5WGd32UNXByTvl1tfCXcq9SwqQO6FiA1P
         CiZm0DS/xb+aU4w0q31bmZeDQ3zEAmtxeYChYFFoXxIaHj25F5zZqQuqaQgDNx+3Ngcx
         N4Euz1dIrYDhln7C6yAum8B3X8LJJFJ1F/EPJFuLu5fHj6AR179CUz9yVGy7rUsaMwQ/
         pycOJ9sQ84qyZ8VAsjzJlkllAiinCv7uykraFBMsp4TWEOqkiBqJ24vF8IwuZWms6PN9
         1o1A==
X-Gm-Message-State: AOAM533M/PBwrmxe4v2Jw12dYZEZYBl5OhLl9TSIZJfzLP9SQG4jkFVV
        jjkUZhLQwl/I+NgKQCsswf/6zFja/ikRaFUcbYoIsQ==
X-Google-Smtp-Source: ABdhPJwGbkITXD+BOo5VJ+vb7qsNmF+rr8ZBOowDK5CfcTxnwszC+JkEbF88xZKm11qTOoMPkI2OhQRwK5juWeZei08=
X-Received: by 2002:a17:906:468e:: with SMTP id a14mr607322ejr.124.1590621198526;
 Wed, 27 May 2020 16:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200508180157.1816-1-ardb@kernel.org> <20200508180157.1816-9-ardb@kernel.org>
 <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com>
 <20200527224657.GA3568142@rani.riverdale.lan> <CAPcyv4jOCY=kxeZVWsS0Xc36jmPr7DSR_sFrsMeoiEs+iEfbEA@mail.gmail.com>
 <20200527230209.GA3575079@rani.riverdale.lan>
In-Reply-To: <20200527230209.GA3575079@rani.riverdale.lan>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 May 2020 16:13:07 -0700
Message-ID: <CAPcyv4hO1XEMHPLY-W6g_=TK2Dv=rLgJoVeKrBEHP63zTeq-sA@mail.gmail.com>
Subject: Re: [PATCH 08/15] efi/x86: Move command-line initrd loading to efi_main
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 27, 2020 at 4:02 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 27, 2020 at 03:56:45PM -0700, Dan Williams wrote:
> > On Wed, May 27, 2020 at 3:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Wed, May 27, 2020 at 10:30:18PM +0000, Williams, Dan J wrote:
> > > > On Fri, 2020-05-08 at 20:01 +0200, Ard Biesheuvel wrote:
> > > > > From: Arvind Sankar <nivedita@alum.mit.edu>
> > > > >
> > > > > Consolidate the initrd loading in efi_main.
> > > > >
> > > > > The command line options now need to be parsed only once.
> > > > >
> > > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > Link:
> > > > > https://lore.kernel.org/r/20200430182843.2510180-9-nivedita@alum.mit.edu
> > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Hi,
> > > >
> > > > This patch patch in tip/master as:
> > > >
> > > > 987053a30016 efi/x86: Move command-line initrd loading to efi_main
> > > >
> > > > ...regresses my nfs root configuration. It hangs trying to mount the
> > > > nfs root filesystem "root=/dev/nfs ip=dhcp".
> > > >
> > > > It does not revert cleanly.
> > > >
> > > >
> > >
> > > Does this fix it?
> > >
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index defeb6035109..f53362efef84 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -771,10 +771,12 @@ unsigned long efi_main(efi_handle_t handle,
> > >                         efi_err("Failed to load initrd!\n");
> > >                         goto fail;
> > >                 }
> > > -               efi_set_u64_split(addr, &hdr->ramdisk_image,
> > > -                                 &boot_params->ext_ramdisk_image);
> > > -               efi_set_u64_split(size, &hdr->ramdisk_size,
> > > -                                 &boot_params->ext_ramdisk_size);
> > > +               if (size > 0) {
> > > +                       efi_set_u64_split(addr, &hdr->ramdisk_image,
> > > +                                         &boot_params->ext_ramdisk_image);
> > > +                       efi_set_u64_split(size, &hdr->ramdisk_size,
> > > +                                         &boot_params->ext_ramdisk_size);
> > > +               }
> >
> > I'll give it a shot, but my guess would have been something related to
> > the fact that this patch moves the initrd loading relative to when the
> > command line is being parsed. In this case it's a dracut initrd built
> > by:
> >
> >     dracut -m "nfs network base"
> >
> > ...with a kernel built with:
> >
> > CONFIG_IP_PNP_DHCP=y
> >
> > ...and a built-in network interface. The behavior seems to be that the
> > kernel gets an IP address just fine, but there's no initrd userspace
> > to mount nfs and the kernel eventually gives up looking for root.
>
> It's an oversight in this patch: I set addr/size to 0 in the case where
> the EFI stub is not supposed to handle the initrd loading (because a
> bootloader ran before it and was responsible for handling the loading),
> but then those 0's get written into the bootparams structure anyway,
> blowing away whatever the bootloader had loaded.

Ah, ok.

...and yes, it works. You can add:

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks for the lightning quick turnaround!
