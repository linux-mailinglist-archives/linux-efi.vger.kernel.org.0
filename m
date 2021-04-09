Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A4359531
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 08:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIGNJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 02:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIGNJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Apr 2021 02:13:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D9A06113A
        for <linux-efi@vger.kernel.org>; Fri,  9 Apr 2021 06:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617948776;
        bh=RlsK1tWjOROm94G4bAOOp4MGmlFo8jW1QDhFLLzMg/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K4fgq+ogQnS38EHnnePdORgEMU55oYIHlvg7ybqdJP4fgppKzu/akDNloLwdwA7Ap
         Fbg1erA6MyDHSF/EiVdyh/5zbcIlDMrsHMBcZqeEjURUQ5AkqZeO7Fuvehpiexfr0b
         LJqzk6K/ezktptM6PaueVnletR9CfnK2mx8jSTOkwuxTCF2NBO8biBJaLX4xkWwqiE
         RyYevVNSKPiwouk/0Hlxx0Muw+RfB5HJTRE7D5ZL5MSDoVDjNlm/yg2DePgSd5dVSg
         WZaktQw09vg9Wcegs0z2klMN4EVKr6UxNdSkcRoGNAvYO6xbJ6Lrcdnb02FniRx3MM
         cO1OjNB47vNsA==
Received: by mail-oi1-f176.google.com with SMTP id i81so4722462oif.6
        for <linux-efi@vger.kernel.org>; Thu, 08 Apr 2021 23:12:56 -0700 (PDT)
X-Gm-Message-State: AOAM533XxWvknHok/3SoYnG8Brga0bAGks+evBbcVXPLfrXq7nqDipmD
        KajIzPGAiij/w/fWzcoowHgky0CDvo/dEsMErIM=
X-Google-Smtp-Source: ABdhPJx0V2sCbVMluY6Iw2MiNa480Hnfng244pX9WgLSWbTGwvxdDXXZ3w8ndVkEN3irW+tVfM/2hY7n3A6Tx6BP0CQ=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr8900319oia.33.1617948775948;
 Thu, 08 Apr 2021 23:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201025134941.4805-1-ard.biesheuvel@arm.com> <20201025134941.4805-6-ard.biesheuvel@arm.com>
 <70b3f147-b6d6-013e-fc65-e7228486d911@gmx.de>
In-Reply-To: <70b3f147-b6d6-013e-fc65-e7228486d911@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Apr 2021 08:12:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFC6OvBD2tDeKWbSWugurvheZdr9vw_F-r6WRwnpLsG2w@mail.gmail.com>
Message-ID: <CAMj1kXFC6OvBD2tDeKWbSWugurvheZdr9vw_F-r6WRwnpLsG2w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] linux/arm: account for COFF headers appearing at
 unexpected offsets
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Apr 2021 at 20:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
> > The way we load the Linux and PE/COFF image headers depends on a fixed
> > placement of the COFF header at offset 0x40 into the file. This is a
> > reasonable default, given that this is where Linux emits it today.
> > However, in order to comply with the PE/COFF spec, which permits this
> > header to appear anywhere in the file, let's ensure that we read the
> > header from where it actually appears in the file if it is not located
> > at offset 0x40.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > ---
> >   grub-core/loader/arm64/linux.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> > index 915b6ad7292d..28ff8584a3b5 100644
> > --- a/grub-core/loader/arm64/linux.c
> > +++ b/grub-core/loader/arm64/linux.c
> > @@ -66,6 +66,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
> >     grub_dprintf ("linux", "UEFI stub kernel:\n");
> >     grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
> >
> > +  /*
> > +   * The PE/COFF spec permits the COFF header to appear anywhere in the file, so
> > +   * we need to double check whether it was where we expected it, and if not, we
> > +   * must load it from the correct offset into the coff_image_header field of
> > +   * struct linux_arch_kernel_header.
> > +   */
> > +  if ((grub_uint8_t *) lh + lh->hdr_offset != (grub_uint8_t *) &lh->coff_image_header)
> > +    {
> > +      grub_file_seek (file, lh->hdr_offset);
>
> Isn't this overly complicated? Why don't we first read the whole file
> into memory and then analyze it instead of using multiple accesses which
> only slows down the process?
>

Given that the condition will never hold in practice, as the offset is
always going to be 0x40, this change is not expected to affect
performance at all.

Doing a complete overhaul of the PE image loading logic for this seems
unwise to me.
