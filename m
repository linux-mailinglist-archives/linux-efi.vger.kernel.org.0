Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D366112E61
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLDP2i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:28:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33614 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfLDP2g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:28:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so9179012wrq.0
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQ+Bjovtb1wQjUleKeH5+qgGtbRdHU3my4UW5rrT54k=;
        b=MyLcYBRfNK1wqWzak5kKyEBoJTxexQUFfGEYhQOwhhupj2twtNUkyuIPl3nzFYzjub
         zKPvseh9ck+zp8BOmofRm+zpymMFFD29ueLoMnqSn9MbFM3PQgyOjxgP/BNd7ThYsY/3
         bqm2u+5w9e5olBqPJLMvVxiO+w/5j7lhOCiiX+Co3Bgzpi2Y7x0rwuJVMkEocPEkdr+j
         65Rr6ierK1yPcgi/5hEbiykCOesh9oTnQChMRysfOkgwD0AlwYLQu6LI7DLazf2VT7fq
         e7moG+UMSzyyLU2bqLpV+DZ/hekzdXUAwEMdgpu+PwibhnlgBWpz35J6dETv+CMScmZF
         8bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQ+Bjovtb1wQjUleKeH5+qgGtbRdHU3my4UW5rrT54k=;
        b=OdrTDzt9LFgI/dvAGx6P6bUidaVmFVsk+t1SlfWu0wWztyH+87elWtMBITFDTVgj8n
         FF5aC+l7uAiDsmvxfQPB4TIldS2cCfzxBbtix4A2dL20+5+q0GGwPSbuyhnC59BR8gu1
         XNADSAV7pNhlldCIDV6Ma5MhwBx2TmgWqkE6fNFbu92g9UV0nNXMPKdgZJXJ9fME2/nV
         UnzAsUCxzw8Ng97hRqVeNScWh6NjkOTbfnSEKi/03i5UDhT8M8tz8YUMM+qDMVackSce
         c+B2+h1J6xznkz/gUdHVBpQhrMpcMBBc5hEgGfjEAMV5t+ooC9beeRyYHD5QruXUPUVl
         9E7Q==
X-Gm-Message-State: APjAAAXScMZNSmFTNfGzgqEdGIpu6IBslmO6h+UqABhJYwNGJbfAAzbU
        ZtQG3aoYaUXfyxrGW6a3NToUROf9puAoT2KVV+kQhQ==
X-Google-Smtp-Source: APXvYqyR/djpKD7o+rvxroHioQQ2jGUppthjXUFlnqCPHDAAnxq/AUHg6UbQNNtlwzagA0aSJYKeI/RqpF3gM+khhSE=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr4851377wrw.246.1575473313768;
 Wed, 04 Dec 2019 07:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20191203214728.19264-1-nivedita@alum.mit.edu> <CAKv+Gu-xTUBhV3Git9opPRs5sJvsCSHrcy9-=5Ac+nMaZhe7-w@mail.gmail.com>
 <20191204152348.GA626282@rani.riverdale.lan>
In-Reply-To: <20191204152348.GA626282@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 15:28:30 +0000
Message-ID: <CAKv+Gu8LHeAM6wGS+abWPX9Mu4fkd_HBwP=XxzyvuzVZy01xLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/gop: Fix return value of setup_gop32/64
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Dec 2019 at 15:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Dec 04, 2019 at 03:03:04PM +0000, Ard Biesheuvel wrote:
> > On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > There are two ways the status return of setup_gop32/64 could be
> > > incorrect.
> > >
> > > 1. If we don't find a usable GOP because none of them have a framebuffer
> > > (i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
> > > will return EFI_SUCCESS even though we didn't find a usable GOP. Return
> > > EFI_NOT_FOUND instead, allowing the caller to probe for UGA instead.
> > >
> > > 2. If we do find a usable GOP, but one of the subsequent ones fails in
> > > an EFI call while checking if any support console output, we may return
> > > an EFI error code even though we found a usable GOP. Fix this by always
> > > returning EFI_SUCCESS if we got a usable GOP.
> > >
> >
> > Please split this into 2 patches
>
> Not quite following -- what should be the two pieces? Are you saying to
> split the success return and the failure return into two patches -- that
> seems excessively fine-grained.
>

Your commit log describes two distinct changes 1. and 2. The patch
addresses those two issues, and in addition, moves variable
declarations around. The result is much more difficult to read than
necessary.

> >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > ---
> > >  drivers/firmware/efi/libstub/gop.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> > > index 0101ca4c13b1..235a98797105 100644
> > > --- a/drivers/firmware/efi/libstub/gop.c
> > > +++ b/drivers/firmware/efi/libstub/gop.c
> > > @@ -119,7 +119,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >         u64 fb_base;
> > >         struct efi_pixel_bitmask pixel_info;
> > >         int pixel_format;
> > > -       efi_status_t status = EFI_NOT_FOUND;
> >
> > Is it really necessary to move this declaration?
>
> No, I just moved it inside the loop block since it's not used outside
> any more.
>
> >
> > >         u32 *handles = (u32 *)(unsigned long)gop_handle;
> > >         int i;
> > >
> > > @@ -134,6 +133,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >                 void *dummy = NULL;
> > >                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
> > >                 u64 current_fb_base;
> > > +               efi_status_t status;
> > >
> > >                 status = efi_call_early(handle_protocol, h,
> > >                                         proto, (void **)&gop32);
> > > @@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >
> > >         /* Did we find any GOPs? */
> > >         if (!first_gop)
> > > -               goto out;
> > > +               return EFI_NOT_FOUND;
> > >
> > >         /* EFI framebuffer */
> > >         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> > > @@ -197,8 +197,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >         si->lfb_size = si->lfb_linelength * si->lfb_height;
> > >
> > >         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> > > -out:
> > > -       return status;
> > > +
> > > +       return EFI_SUCCESS;
> > >  }
> > >
> > >  static efi_status_t
> > > @@ -237,7 +237,6 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >         u64 fb_base;
> > >         struct efi_pixel_bitmask pixel_info;
> > >         int pixel_format;
> > > -       efi_status_t status = EFI_NOT_FOUND;
> > >         u64 *handles = (u64 *)(unsigned long)gop_handle;
> > >         int i;
> > >
> > > @@ -252,6 +251,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >                 void *dummy = NULL;
> > >                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
> > >                 u64 current_fb_base;
> > > +               efi_status_t status;
> > >
> > >                 status = efi_call_early(handle_protocol, h,
> > >                                         proto, (void **)&gop64);
> > > @@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >
> > >         /* Did we find any GOPs? */
> > >         if (!first_gop)
> > > -               goto out;
> > > +               return EFI_NOT_FOUND;
> > >
> > >         /* EFI framebuffer */
> > >         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> > > @@ -315,8 +315,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >         si->lfb_size = si->lfb_linelength * si->lfb_height;
> > >
> > >         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> > > -out:
> > > -       return status;
> > > +
> > > +       return EFI_SUCCESS;
> > >  }
> > >
> > >  /*
> > > --
> > > 2.23.0
> > >
