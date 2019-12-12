Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC21F11D9A9
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfLLWtC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:49:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38636 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfLLWtB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:49:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4425553wmi.3
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhZm0tPb60o6yARvKL1uceXGEcpK+m2wdp27Ea/okyM=;
        b=KeLej8ZdtiIG4yQ1vXX0VQ/o+RmHzLv/zNFPx2XvMtO7SuxE5XFyMh4G+Ej54WazAY
         jEnt1L+7agavVYh07Mj5M23T0zKv2JkLqDX3QB0Kgux29y09z87P0ZtvP0fy048NLnBg
         QO0eUJ3Ak/J0UO79DYbYD+DZn0rQN6qiPaB5lYTBkZCn0EQ3gzbYrR8Hd/F/sHW2pPWz
         2dZSu/zrbqgOteTMwZ9+n/bcdxl1e+kU9ZWoQ8aGCRCk5irus9D39abmqbApKFVmI0lv
         eD458Y91t6AvWBEsMHLRwHJ7uMr30uZ6/Ad3Z/4V0hr5EFwOzJ41JzCPjtLi8hNa12cq
         2FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhZm0tPb60o6yARvKL1uceXGEcpK+m2wdp27Ea/okyM=;
        b=f4sluaIoaHHtROVObj6uU220mJeWGUoAkABtjWyZm996xD1Ex9+JrUs5uMwbX+awNo
         O28c4B2figG0ZW0azlHVzYk5DU1LzRJIpuj1KY97dgw1yU9FaPgj7sZMF7eqwZwF3MLR
         WmslezZTFTisIKSo/3sCYFPCk9GsDqSiCjo+/CyX5TnZMoY1L2dUVhoPG3dtupNhxB3A
         JVcyWS0VleFrnCVksM+ZQ8fECwpSHpJc9FRtPixsrNaLaunK52mJHFYujeCCHJiarmXM
         a9sGc2ttdky6Tje0q+CTM+vX6k8pKFIl7Uwoz1Iii3sNc8h9T6t0kcEbSoTzRRj8EJdF
         dsIg==
X-Gm-Message-State: APjAAAVyvlC7crS2HsHPcJ3tt4+OmL+zf8P6qG3afFiAOCbyulKqkU3U
        TfLhLDMZuyDZfyq5lOkIYnHY5zr3xVRNxHPMm/jGVA==
X-Google-Smtp-Source: APXvYqwGVT2CWnlwlu2u9N7fqStZ1aoUyrui4/9nj2nZ5yvvDtk2bU5zDw2HURyjk5KpIgofJPYybSDLUSiUx/n9lHs=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr580386wme.148.1576190939492;
 Thu, 12 Dec 2019 14:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20191212213443.24128-1-nivedita@alum.mit.edu> <20191212213443.24128-4-nivedita@alum.mit.edu>
 <CAKv+Gu804kOz2BJw=O1o8F3XF828E3BYp_UnJu1VSwy7gKm-7g@mail.gmail.com> <20191212224116.GC10385@rani.riverdale.lan>
In-Reply-To: <20191212224116.GC10385@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 22:48:57 +0000
Message-ID: <CAKv+Gu8uP+a3rW+dDpBn8bQEHn539_dKew8Hy2ySRKcSt0Asxw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] efi/gop: Convert GOP structures to typedef and
 cleanup some types
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 23:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Dec 12, 2019 at 10:35:56PM +0000, Ard Biesheuvel wrote:
> > On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wro=
te:
> > >
> > > Use typedef for the GOP structures, in anticipation of unifying
> > > 32/64-bit code. Also use more appropriate types in the non-bitness
> > > specific structures for the framebuffer address and pointers.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> >
> > This gives me
> >
> > /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c: In function
> > =E2=80=98setup_gop32=E2=80=99:
> > /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:96:27: error:
> > storage size of =E2=80=98pixel_info=E2=80=99 isn=E2=80=99t known
> >   struct efi_pixel_bitmask pixel_info;
> >                            ^~~~~~~~~~
> > /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:125:38: error:
> > dereferencing pointer to incomplete type =E2=80=98struct
> > efi_graphics_output_protocol_32=E2=80=99
> >    mode =3D (void *)(unsigned long)gop32->mode;
> >                                       ^~
> > /home/ardbie01/linux/scripts/Makefile.build:265: recipe for target
> > 'drivers/firmware/efi/libstub/gop.o' failed
> > make[5]: *** [drivers/firmware/efi/libstub/gop.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
>
> Something must be wrong with the application of the patch. The patch
> does change the declaration of pixel_info and gop32 as seen below.
>

Yeah, indeed. Sorry for the noise.


> > > @@ -87,13 +87,13 @@ static efi_status_t
> > >  setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *s=
i,
> > >              efi_guid_t *proto, unsigned long size, void **gop_handle=
)
> > >  {
> > > -       struct efi_graphics_output_protocol_32 *gop32, *first_gop;
> > > +       efi_graphics_output_protocol_32_t *gop32, *first_gop;
> > >         unsigned long nr_gops;
> > >         u16 width, height;
> > >         u32 pixels_per_scan_line;
> > >         u32 ext_lfb_base;
> > > -       u64 fb_base;
> > > -       struct efi_pixel_bitmask pixel_info;
> > > +       efi_physical_addr_t fb_base;
> > > +       efi_pixel_bitmask_t pixel_info;
> > >         int pixel_format;
