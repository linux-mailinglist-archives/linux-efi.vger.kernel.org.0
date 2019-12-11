Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF111B4F2
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 16:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbfLKPuT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 10:50:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36039 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfLKPuS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 10:50:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so9903974qkc.3
        for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2019 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dchBUg5XDx+C1rXR01PmWCnG9B1R4vKOIwZszNvnRCw=;
        b=AE2TJ3u2Jjf7kUzeM8V9b9DedNrqzc6W/RaZzOOje60YYdPB2bQh6FvG9sg3zdEdVv
         YmBNu8Hk5RuViTT09HT/Bazuu1FuHyyi4u3qgI/DlikLXeMp4VZjYrXLHgXVWV9ztO/b
         cY47HBOyqAAXifQdXyx5J1QPnC00MDwoYRXk2EKSSPly3o1sgvMIytVdvZjoTUoyn0Cw
         8D3UmsqohQuV1WixkRE05DQ56kMbjSIXHiDoGW1i3DSVSJkbl8Xf3TrReZkd9yhI+8QR
         Z4/dCIfjPY/FxVfbEqE1lsvcr24vwexpcTt9zlqGRSJSUZXy7rGiQM32DH5hoCR2NOjL
         eGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dchBUg5XDx+C1rXR01PmWCnG9B1R4vKOIwZszNvnRCw=;
        b=gApn+1llqgWUBrJ4kgVYzA/ZUQMcKc2lHT1dv0IpRosJAzrAzgHLDm8glGf0L96Hhl
         dARbwiWcSTm+4IRZi7+iru/zy/8MZwEh2VFvSq6LWB8JVRt1ynKCUFYbz+f2M66yUBrc
         xDuq83LWX26Ufhh7/lLDohNWIRUL6ZB5sXXNAx1sCrP+T6JYu/RWak16lRTxmSYUAke1
         Ktdx+dyyJ3nKRB+QiM7TDyq41jwzcsVIkCtITTsoh5d/uV0kUD+H7mZR2feakaq7WpIq
         bDk1nAX0wPfhyDJy/3NtVVxodAmtq9uD4qdFSigZPv3LmXNTZDaWw0wZgb6b0pIKyLyJ
         s7cA==
X-Gm-Message-State: APjAAAVsgZkU8pCVkn1QfZ9BaCosd39Zayk6Khr+aunHY1P9F19raIde
        2KVKpY9Yvc7pmFH4ZXe3wDg=
X-Google-Smtp-Source: APXvYqzfT604Z6D9dvJXPJQHZwhzsW5uLfeqZBJ5ItXyTbmzi2aOF6FRYUBgM+jVnNcGlUOnD/MNRg==
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr3603788qka.286.1576079417297;
        Wed, 11 Dec 2019 07:50:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c66sm790294qkf.7.2019.12.11.07.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:50:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Dec 2019 10:50:15 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191211155014.GA201667@rani.riverdale.lan>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
 <CAKv+Gu_=+nkcB3vEhYYBbD37UR4AJ-M2kTihAhXY+wc-Uwf=dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_=+nkcB3vEhYYBbD37UR4AJ-M2kTihAhXY+wc-Uwf=dQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 03:00:46PM +0100, Ard Biesheuvel wrote:
> On Wed, 11 Dec 2019 at 12:04, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 08:22:56AM +0000, Ard Biesheuvel wrote:
> > > (+ Andy)
> > >
> > > On Wed, 11 Dec 2019 at 00:24, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On x86, until PAT is initialized, WC translates into UC-. Since we
> > > > calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
> > > > initialized, this means we actually use UC- mappings instead of WC
> > > > mappings, which makes scrolling very slow.
> > > >
> > > > Instead store a boolean flag to indicate whether we want to use
> > > > writeback or write-combine mappings, and recalculate the actual pgprot_t
> > > > we need on every mapping. Once PAT is initialized, we will start using
> > > > write-combine mappings, which speeds up the scrolling considerably.
> > > >
> > > > Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Make sense.
> > One comment below.
> >
> > > > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > > > -       else
> > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > > > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > > > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> >
> > I would really like to keep the style with if-else.
> >
I could change this part back to the if/else. Are you ok with the
ternary operator in efi_earlycon_map?
> 
> Can't we just set a global flag to MEMREMAP_WB or MEMREMAP_WC in the
> init code, and use that directly?
We can't use it directly in efi_earlycon_map though, so we still need to
translate there, and we'd need an if/else in the init code, so this
would just move the if/else from here to the init code.
