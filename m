Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF19C340C2B
	for <lists+linux-efi@lfdr.de>; Thu, 18 Mar 2021 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCRRwg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 13:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCRRwf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Mar 2021 13:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A591064F1D
        for <linux-efi@vger.kernel.org>; Thu, 18 Mar 2021 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616089954;
        bh=s6n+ced3ag6LObr5pmBV5dYOQaeA+PW8rqXlxaCJ+Do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cggI0B0lORnR7Aqd7PLXAFcy8BNNfjubLwH4AGxiHdDra4ykpAZ1PGgLFmJTIcI5U
         QkYWssBUGRjJxx1lcTq8wV/Q178MRHXgI0D0201k1FuqQQ7dvNlR/4wXCGJedf83qJ
         xIQLJu0Dm/RVaS/6d8KBQ1I0IVqcN5ouTy7vLi22ud8Nq0lewv8d2FwSyUE+heS3Sa
         ypSToGvtrlSWWvMPVGEvFfUovkH1CmOtR62z6uXO2i/H4lswcKw33Rlcc74nCYgt56
         fNB3WbA9gAVo3g2aOIjMlPwq3nNTzLrA67kZgMhBSEPZXCj1gwIxgsZQsjBl+527Da
         yzzZ3GBYlIezg==
Received: by mail-oo1-f42.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so1634584oom.11
        for <linux-efi@vger.kernel.org>; Thu, 18 Mar 2021 10:52:34 -0700 (PDT)
X-Gm-Message-State: AOAM530no7ULBC+xMBjjHsRe4y+kzNd9I/U1SQ5YYFP9ZdId60CNff40
        /bts3Ssy2M5k3Vdxfflsio6oFg0Jy5zCo0gJj34=
X-Google-Smtp-Source: ABdhPJz/25dEZ09AjZFZ8tjJmwFDOiGxs2jZSvbSzpihrmEbbmQd7g3lQGXANFapzxTOX3OFbQexXgDzGHi/rubRxwQ=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr8437640oop.13.1616089953896;
 Thu, 18 Mar 2021 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210310081210.95147-1-ardb@kernel.org> <20210310222139.7frwtzxd5jgxvwsl@archlinux-ax161>
In-Reply-To: <20210310222139.7frwtzxd5jgxvwsl@archlinux-ax161>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Mar 2021 18:52:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5-NPBEHAd9PRQvf_tqWr7zt0HEesHX+h5w=WPtx_K1w@mail.gmail.com>
Message-ID: <CAMj1kXE5-NPBEHAd9PRQvf_tqWr7zt0HEesHX+h5w=WPtx_K1w@mail.gmail.com>
Subject: Re: [PATCH] efi: use 32-bit alignment for efi_guid_t literals
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Mar 2021 at 23:21, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 09:12:10AM +0100, Ard Biesheuvel wrote:
> > Commit 494c704f9af0 ("efi: Use 32-bit alignment for efi_guid_t") updated
> > the type definition of efi_guid_t to ensure that it always appears
> > sufficiently aligned (the UEFI spec is ambiguous about this, but given
> > the fact that its EFI_GUID type is defined in terms of a struct carrying
> > a uint32_t, the natural alignment is definitely >= 32 bits).
> >
> > However, we missed the EFI_GUID() macro which is used to instantiate
> > efi_guid_t literals: that macro is still based on the guid_t type,
> > which does not have a minimum alignment at all. This results in warnings
> > such as
> >
> >   In file included from drivers/firmware/efi/mokvar-table.c:35:
> >   include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to
> >       4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
> >       access [-Walign-mismatch]
> >           status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
> >                                           ^
> >   include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to
> >       4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
> >       access [-Walign-mismatch]
> >           get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
> >
> > The distinction only matters on CPUs that do not support misaligned loads
> > fully, but 32-bit ARM's load-multiple instructions fall into that category,
> > and these are likely to be emitted by the compiler that built the firmware
> > for loading word-aligned 128-bit GUIDs from memory
> >
> > Instead of bodging this further, let's simply switch to our own definition
> > of efi_guid_t that carries a uint32_t as well. Since efi_guid_t is used as
> > an opaque type everywhere in the EFI code, this is only a minor code change.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I ran this through my series of 32-bit and 64-bit x86 builds and I did
> not see any additional warnings added because of it.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>

Thanks all, but I am going to drop these, as I have decided to fix it
in a different way after all.


> > ---
> >
> > I am currently testing this change via my for-kernelci branch. Please give
> > this some soak time in the other CIs that we have access to.
> >
> >  include/linux/efi.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 8710f5710c1d..f39e9ec7485f 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -63,17 +63,22 @@ typedef void *efi_handle_t;
> >   * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
> >   * this means that firmware services invoked by the kernel may assume that
> >   * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> > - * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> > + * do not tolerate misalignment.
> >   *
> >   * Note that the UEFI spec as well as some comments in the EDK2 code base
> >   * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
> >   * a mistake, given that no code seems to exist that actually enforces that
> >   * or relies on it.
> >   */
> > -typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> > +typedef struct {
> > +     u32     a;
> > +     u16     b;
> > +     u16     c;
> > +     u8      d[8];
> > +} efi_guid_t;
> >
> >  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> > -     GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> > +     (efi_guid_t){ a, b, c, { d0,d1,d2,d3,d4,d5,d6,d7 }}
> >
> >  /*
> >   * Generic EFI table header
> > @@ -598,8 +603,8 @@ efi_guidcmp (efi_guid_t left, efi_guid_t right)
> >  static inline char *
> >  efi_guid_to_str(efi_guid_t *guid, char *out)
> >  {
> > -     sprintf(out, "%pUl", guid->b);
> > -        return out;
> > +     sprintf(out, "%pUl", guid);
> > +     return out;
> >  }
> >
> >  extern void efi_init (void);
> > --
> > 2.30.1
> >
