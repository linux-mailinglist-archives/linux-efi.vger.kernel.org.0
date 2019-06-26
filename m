Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF956890
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2019 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZMW0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jun 2019 08:22:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33866 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMW0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jun 2019 08:22:26 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so1342507iot.1
        for <linux-efi@vger.kernel.org>; Wed, 26 Jun 2019 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH7xpQciCZs70JZEWv7HAB81UCE0xL055vW5CItage0=;
        b=mHPiXk08vVvMTzHObSpnX5Sd1QHb+lxVMsOw7xG4zCZ2dyBto2nde77I4y6Hby4rEC
         kpSd/G/SMpdZb1kA7Z2Jpg9UvO9xnODquu0FTZ9cCuWZCl9VPAO/bOBKHDxguf/yZ/dg
         S7oGd4qXtvP9hg6R2xqWvUl/ONNSpVrbvYLTCQM6nMgmPKWnqANOrSuPeOLzVuuc4Q2F
         3egOJhogOlsqOoUzF1pOD8t07DeOYOJvVK+cgyprKAeIg6jkjUfhzprkODbG2VP2aRix
         mDaRM6e+Uq9NAnExmlJRVjasH65vo4umglG1rhImpVr4gk/r/ViFYAtJLST1VXjxJxE0
         tozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH7xpQciCZs70JZEWv7HAB81UCE0xL055vW5CItage0=;
        b=UMElC++Bkb1g5+L4MVqe6WHC7F3kXwhM2b+90HGXDTgDYPQIX5V8/Sxzo6tLhOlKOr
         RiNv/cM3Xn3PZGDfelek3uqHcsjyF3LAWJZM2RgxufBa3LT1l7c3sbLRcP99drGPzSA4
         mwJXjwaG4jke+jxafE5TVAb/qmwCqbVrVXkiEJ/nRQBPYEli4C5pLEmYG4HGZMXEeGl4
         ozSnNuKzRUqfGxbQSoXYKyyw7cLU7DssCtnegflvAl2rkLBSrprIJwTqlnA5UcmV5mZc
         OLq0uvObVzZrvD5tHKVp/hmghGy3Cp/QLCG7mQQbvcWD+TfCybtHfBczg9mDcxJjkxXD
         eUPg==
X-Gm-Message-State: APjAAAWF0nnFefavDduyurSbAbKiTdYnlYxQ3562PaNckWLX04dIf21W
        SIWwUKhuPlI8kBoIji7QKNJi+h55mT3UUpXjS7y3lg==
X-Google-Smtp-Source: APXvYqxjYfWQSDkwha69Ba2U3sA2ZyGZeZ5iFNrc1TUsng+IrEQsr3ntCNCKHmCkurax/dJobAkxqr31mRrhLZm/rpk=
X-Received: by 2002:a02:1a86:: with SMTP id 128mr4526946jai.95.1561551745348;
 Wed, 26 Jun 2019 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617101134.GA2242@localhost.localdomain> <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
 <20190625120944.GA4465@localhost.localdomain> <CAKv+Gu_cdjU49d5JSJKJ_2Eb2Pp2JY=xe=39J3KyVs7qQnke2g@mail.gmail.com>
 <20190626121712.GA2523@localhost.localdomain>
In-Reply-To: <20190626121712.GA2523@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Jun 2019 14:22:11 +0200
Message-ID: <CAKv+Gu95FCwTZs6iA-y2myoi60rGrpK14SZZ-59P7hOed1Vk=A@mail.gmail.com>
Subject: Re: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com
Cc:     Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Jun 2019 at 14:17, <Narendra.K@dell.com> wrote:
>
> On Tue, Jun 25, 2019 at 04:21:33PM +0200, Ard Biesheuvel wrote:
> [...]
> > > > > --- a/drivers/firmware/efi/efi.c
> > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > @@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
> > > > >         .rng_seed               = EFI_INVALID_TABLE_ADDR,
> > > > >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> > > > >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > > > > +       .rci2                   = EFI_INVALID_TABLE_ADDR,
> > > >
> > > > Does this really need to live in the efi struct?
> > >
> > > It probably need not be part of struct efi. We could define a struct of
> > > type 'efi_config_table_type_t' in the rci2_table.c. Did you have a
> > > similar idea in mind ? If yes, I will modify and test this idea.
> > >
> >
> > Yes, I'd like to start keeping these things separate.
> >
> > I pushed a branch here
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> >
> > that changes the way uv_systab is handled, and moves it into arch/x86.
> > Please follow that pattern instead.
>
> Okay. Thank you for the guidance. I will make this change in the next version.
>
> >
> > > >
> > > > >  };
> > > > >  EXPORT_SYMBOL(efi);
> > > > >
> > > > > @@ -73,6 +74,7 @@ static unsigned long *efi_tables[] = {
> > > > >         &efi.esrt,
> > > > >         &efi.properties_table,
> > > > >         &efi.mem_attr_table,
> > > > > +       &efi.rci2,
> > > > >  };
> > > > >
> > > >
> > > > AFAICT, this table is only used by memremap_is_efi_data() to decide
> > > > whether a page should be map as unencrypted, and if the address is in
> > > > boot services data or runtime services data, the test will already
> > > > success, regardless of whether it appears in this enumeration.
> > >
> > > Yes. Before 'memremap_is_efi_data()' checks if the memory type is boot
> > > services data for runtime services data, it checks if the address is a
> > > 'table' address in 'efi_is_table_address'. I added it because of this
> > > check. Since the memory type used for the table is efi reserved type, we
> > > need to add the table address to 'efi_tables' array so that it could be
> > > checked in 'efi_is_table_address'. Please share your thought on this.
> > >
> >
> > OK. My branch ^^^ moves this into arch/x86 as well, please add it there
>
> I have a query related to this change. I will discuss it in next section
> below as it helps provide complete context.
>
> > > > > @@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t common_tables[] = {
> > > > >         {NULL_GUID, NULL, NULL},
> > > > >  };
> > > > >
> > > > > +/* OEM Tables */
> > > > > +static __initdata efi_config_table_type_t oem_tables[] = {
> > > > > +       {DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},
> > > >
> > > > Please drop the string. We don't have to print the presence of this
> > > > table in the bootlog since it has no significance to the OS itself.
> > >
> > > Okay. I will drop this in the next version of the patch.
> > >
> > > >
> > > > > +       {NULL_GUID, NULL, NULL},
> > > > > +};
> > > > > +
> > > >
> > > > Do we really need a separate oem_tables[] array?
> > >
> > > The RCI2 table did not seem to be part of the group of common tables
> > > such as SMBIOS and ACPI. To indicate this, I created a separate array.
> > > It seems like it is not required. Having the array allows to leverage
> > > the table matching code in 'match_config_table' function. Would you prefer
> > > to have this entry added to the 'common_tables' array ?
> > >
> >
> > Please add it to the arch_tables array in arch/x86 (if my assumption
> > is correct that this is x86-only)
>
> The table is used on x86. But it is not specific to x86 and is
> independent of the architecture. Because of this detail, my thinking is
> to keep the rci2_table.c and related changes in generic efi layer
> drivers/firmware/efi/. If we keep the changes in drivers/firmware/efi/,
> then two options are
>
> 1. Retain the oem_tables array and add rci2 table address to this array
> 2. Add rci2 table address to common_tables array
>
> Does this detail sound correct ?
>

Yes, and I'd prefer the latter.

> Also, since the 'efi_is_table_address' function and efi_tables array are moved
> to arch/x86, for rci2 table address to be detected as a table address, it needs to be
> added to 'efi_tables' array. Would it be correct to add rci2 table
> address to this array with rest of the changes residing in the generic efi
> layer ?
>

Yes.

> Please share your thoughts on the two details.
>
> [...]
> > > Would you prefer to merge this function into 'efi_rci2_sysfs_init' function ?
> > >
> >
> > Yes. Only user space needs to access this, so we can defer this to
> > later, when the normal memremap() functions are available.
> >
>
> Okay, I will make this change in the next version.
>
> --
> With regards,
> Narendra K
