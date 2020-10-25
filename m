Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46CA2982BD
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417629AbgJYRYt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415746AbgJYRYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Oct 2020 13:24:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CAC061755;
        Sun, 25 Oct 2020 10:24:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m65so5086540qte.11;
        Sun, 25 Oct 2020 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PZFCyeKv5e8ADxosNdndjAJeNVY61tGhsC7YMDs2lLY=;
        b=rrSDS/GHYiQ/mJTLF/Bn4P7l35W697D0DhBeQ5VBoStO6fjKxe5XqJzYSjGyY/qlQ7
         kK3gKLhTbglAZr9DBzKhgx1NH1/s71324/2xqdvYRVr6vJF3rtIMs03cFiipKteUDtuB
         8QkJCzowu9QPaiqMAuZKvLO4LfTgnZ19hfA2zRZz8nOiDH73l4P6hphcKbWnqnC/x53X
         fT/3PNS9d2xMuqxUqVTjXfWxr9ymEmvxfRWaPQhg4yRxdF9mW5Po2KIBX+xtX92drOUk
         6NuAbpZ3VayYNh48gl+RwFkTNU5OQz6FlOWFLUve0kgbx+wYwE1jfEmy5tAlxVl1yHYL
         JMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PZFCyeKv5e8ADxosNdndjAJeNVY61tGhsC7YMDs2lLY=;
        b=lgCVKntqhfZGocxy1x7UgvmPvkxw/tS1bK5cbH7YAsytXOdLLVh7lL0dceOf8nNOLI
         3x0t2hpeQ3fWEJwoDUO0zZCAV/M82nmGrBdzdQKRxO2FNAelwHKugXB2w5XCMT9r2pII
         Jfa+thRgdmazScuzhfQCAmwXtcv8q8yqSkW/xz/2+u1Gv+OddSNTOj+UaditEGnWPyYD
         v4JIGYwwYNQ3O1loIexv964WATTlOaPN+5yiGhuiV5rP3ojZPaUjCMcMkhi6PkUHPe7B
         6I2dhcg8M4mVMwNx6E+JkMxNvCS3UvG+ymQo1Ve4AMbW2kzsLf3dnamR5LQgX564U/in
         f9xA==
X-Gm-Message-State: AOAM531ItybZTmtT52y6qYw26M7A1e2rx8bIWPtHUfk4FV5TTnNb9uHX
        RgvoyGMyl5IXJiqmfBpdPr8=
X-Google-Smtp-Source: ABdhPJxC3NAqB+fHxVRL6eVL3ig0Ov5daJGEA0uFVRn5BCwnN9nQnY+OAtQy/vfD71LJho6GqmLCbg==
X-Received: by 2002:ac8:470a:: with SMTP id f10mr11440109qtp.246.1603646686066;
        Sun, 25 Oct 2020 10:24:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s14sm593690qtb.25.2020.10.25.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:24:45 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 25 Oct 2020 13:24:43 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/x86: Only copy the compressed kernel image in
 efi_relocate_kernel()
Message-ID: <20201025172443.GA1222048@rani.riverdale.lan>
References: <20201011142012.96493-1-nivedita@alum.mit.edu>
 <20201025161931.GA1119983@rani.riverdale.lan>
 <CAMj1kXGBybyTOADr+PvC+ZVohw+aRZbEnfweHTECKKdX9JHXTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGBybyTOADr+PvC+ZVohw+aRZbEnfweHTECKKdX9JHXTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 25, 2020 at 05:28:06PM +0100, Ard Biesheuvel wrote:
> On Sun, 25 Oct 2020 at 17:19, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Oct 11, 2020 at 10:20:12AM -0400, Arvind Sankar wrote:
> > > The image_size argument to efi_relocate_kernel() is currently specified
> > > as init_size, but this is unnecessarily large. The compressed kernel is
> > > much smaller, in fact, its image only extends up to the start of _bss,
> > > since at this point, the .bss section is still uninitialized.
> > >
> > > Depending on compression level, this can reduce the amount of data
> > > copied by 4-5x.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Ping
> >
> 
> I'll pick this up as a fix once the merge window closes.

Thanks!

> 
> > > ---
> > >  drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index 3672539cb96e..f14c4ff5839f 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
> > >           (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
> > >           (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
> > >           (image_offset == 0)) {
> > > +             extern char _bss[];
> > > +
> > >               status = efi_relocate_kernel(&bzimage_addr,
> > > -                                          hdr->init_size, hdr->init_size,
> > > +                                          (unsigned long)_bss - bzimage_addr,
> > > +                                          hdr->init_size,
> > >                                            hdr->pref_address,
> > >                                            hdr->kernel_alignment,
> > >                                            LOAD_PHYSICAL_ADDR);
> > > --
> > > 2.26.2
> > >
