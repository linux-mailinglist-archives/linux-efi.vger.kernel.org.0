Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD72112E3A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfLDPXx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:23:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39740 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPXw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:23:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so100104qtj.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6/zYTC0hsoiL7NrCQovHkn32XtDX3BZo/IvkGPPp7M=;
        b=IbUmU65cnETNZXzyL9x9+aXrslwQfsSrJm2a5JuUQKBo0oeL4tYXMwRKkG9MoC/QX0
         ezOSZVyYhfUKQnLqSwld8y2twpStj+d1cgJ7G4Q86CYFeeLY8Q7MMkvVgcnyBWkBMXzR
         IvFxQ9Rad5tbTYBTNhBVek605wsM0gQ4EijdPH+lBh5a1z5cOy/kTBYiCbS5FJhKRfH4
         s3XziJIxXT1whM7XgRKg35bfd3xIqVirN3eIMNlIxLFboJKaDwDdGh9dyozLf5kQtmk+
         JDwdePBCBf8W3qHS04Mm9Ks1lY/vYhSAqAJf4n4TjGjLkaiVHERz278xtqF+i3aiTqLl
         ROtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6/zYTC0hsoiL7NrCQovHkn32XtDX3BZo/IvkGPPp7M=;
        b=txqMhE/uU95Qx1cEe8J07UwE3Dvet8mROqNGKkSXRJn+1KwxBF3X76pfIsfm+kvY5j
         w2MnyscQBB1ixwCRxu6njfreiaaByYokPLaD/X909KNqUeKcKf8/4yMY9OSVzZJ9bYJC
         oWnEMZ4/wK92zvdILYSHKmXCcidVSK3lYvqd/Xfn96XR5WdSIERsrjZSR7DKT7GacBmY
         23ollvumgZ3YfsjPbsGRYppeXN46wgcEdU7G9v07U4ztEJTbVvPII35rCT1cBykohl/+
         Mc90Io6rzYPKfetlqEmWTG1lPIf89+GZPo469/IsrP/6OEuXqchpTJS92Lzvgbj9CmVY
         VQpw==
X-Gm-Message-State: APjAAAVARQtMF8nhnlaBi+aizX43lYT/2acLxs0eA2cF7E5tKn3EXU7i
        b3s2MUm7kKCxuTGbqwsv+j9kwIBE/EM=
X-Google-Smtp-Source: APXvYqy8AXAPQnKaEIczpYk9WYnZDzEoAphaCxgWWuH6s2hHBroi10YhZgO1dTRxMXr/OGSwHb8p0Q==
X-Received: by 2002:ac8:3290:: with SMTP id z16mr3283025qta.134.1575473031321;
        Wed, 04 Dec 2019 07:23:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a85sm374906qkc.23.2019.12.04.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:23:50 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Dec 2019 10:23:49 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/2] efi/gop: Fix return value of setup_gop32/64
Message-ID: <20191204152348.GA626282@rani.riverdale.lan>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
 <CAKv+Gu-xTUBhV3Git9opPRs5sJvsCSHrcy9-=5Ac+nMaZhe7-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-xTUBhV3Git9opPRs5sJvsCSHrcy9-=5Ac+nMaZhe7-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 04, 2019 at 03:03:04PM +0000, Ard Biesheuvel wrote:
> On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > There are two ways the status return of setup_gop32/64 could be
> > incorrect.
> >
> > 1. If we don't find a usable GOP because none of them have a framebuffer
> > (i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
> > will return EFI_SUCCESS even though we didn't find a usable GOP. Return
> > EFI_NOT_FOUND instead, allowing the caller to probe for UGA instead.
> >
> > 2. If we do find a usable GOP, but one of the subsequent ones fails in
> > an EFI call while checking if any support console output, we may return
> > an EFI error code even though we found a usable GOP. Fix this by always
> > returning EFI_SUCCESS if we got a usable GOP.
> >
> 
> Please split this into 2 patches

Not quite following -- what should be the two pieces? Are you saying to
split the success return and the failure return into two patches -- that
seems excessively fine-grained.

> 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  drivers/firmware/efi/libstub/gop.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> > index 0101ca4c13b1..235a98797105 100644
> > --- a/drivers/firmware/efi/libstub/gop.c
> > +++ b/drivers/firmware/efi/libstub/gop.c
> > @@ -119,7 +119,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >         u64 fb_base;
> >         struct efi_pixel_bitmask pixel_info;
> >         int pixel_format;
> > -       efi_status_t status = EFI_NOT_FOUND;
> 
> Is it really necessary to move this declaration?

No, I just moved it inside the loop block since it's not used outside
any more.

> 
> >         u32 *handles = (u32 *)(unsigned long)gop_handle;
> >         int i;
> >
> > @@ -134,6 +133,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >                 void *dummy = NULL;
> >                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
> >                 u64 current_fb_base;
> > +               efi_status_t status;
> >
> >                 status = efi_call_early(handle_protocol, h,
> >                                         proto, (void **)&gop32);
> > @@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >
> >         /* Did we find any GOPs? */
> >         if (!first_gop)
> > -               goto out;
> > +               return EFI_NOT_FOUND;
> >
> >         /* EFI framebuffer */
> >         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> > @@ -197,8 +197,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >         si->lfb_size = si->lfb_linelength * si->lfb_height;
> >
> >         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> > -out:
> > -       return status;
> > +
> > +       return EFI_SUCCESS;
> >  }
> >
> >  static efi_status_t
> > @@ -237,7 +237,6 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >         u64 fb_base;
> >         struct efi_pixel_bitmask pixel_info;
> >         int pixel_format;
> > -       efi_status_t status = EFI_NOT_FOUND;
> >         u64 *handles = (u64 *)(unsigned long)gop_handle;
> >         int i;
> >
> > @@ -252,6 +251,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >                 void *dummy = NULL;
> >                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
> >                 u64 current_fb_base;
> > +               efi_status_t status;
> >
> >                 status = efi_call_early(handle_protocol, h,
> >                                         proto, (void **)&gop64);
> > @@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >
> >         /* Did we find any GOPs? */
> >         if (!first_gop)
> > -               goto out;
> > +               return EFI_NOT_FOUND;
> >
> >         /* EFI framebuffer */
> >         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> > @@ -315,8 +315,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >         si->lfb_size = si->lfb_linelength * si->lfb_height;
> >
> >         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> > -out:
> > -       return status;
> > +
> > +       return EFI_SUCCESS;
> >  }
> >
> >  /*
> > --
> > 2.23.0
> >
