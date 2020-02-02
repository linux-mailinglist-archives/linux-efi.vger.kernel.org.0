Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FA14FC7E
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgBBJux (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 04:50:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37320 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBBJux (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 04:50:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so14119567wru.4
        for <linux-efi@vger.kernel.org>; Sun, 02 Feb 2020 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nXShXgICydLRT+vhePc/yrUZTUCenLVZV6Hzecb1CTw=;
        b=TyllWNqtlAm1kXiH+91HWWvfDWud2hYxl/Zqhm4Ip6gzUePh7uk6iDE9wD/Upt5Nf+
         RpSJo85F2Fdjja+/OQnZtrc9Jj84p7IY7TIq4jKUZrT8b59+LMDSCWhVz9r1uHxdhAmY
         19aq1E9KFwK+zBxuqs48gjRguEOr7GtS3BcBYq0z44hyXc1NhB9tHXqJ7Q2UMxLUm2Rz
         eOaIXiRz+mHeTfo1rm+v9SJ2KcOhsnnHR4cf+6x/zLyPHXMnIEqfo9YgGxiIzMEE17ad
         fxwo54/5hFa6gUG531R/jXn3uj2tHSVBxd/HLl4UofX0C85P0nTWTroXakeWNcw2N7ep
         ewWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nXShXgICydLRT+vhePc/yrUZTUCenLVZV6Hzecb1CTw=;
        b=JgHaQn6K750Q0rhMAfIKg7CuqjxW9N5ZcYmXnsPYvPSK1JUhJ3IyNUblk6bXnPErgH
         IUM4kBjCoKp4RhSKltbxSt2SMKfPEY5i1HnbOiSHw4ZJteqTgsw9s4x0x608FzlFjIBo
         eqCGTqJYUCEGMepMSetquM1lOhnSnU6s8r9aQHfo0H+z98tABvipLz4hE4VT4Mun7R+g
         Z/OBYBrxXL14q5s0PfYfQgl7M8IbxTB2lvRhMCCjPAYrqiW9Fjfw0i/zZy5Ev4/RGMfd
         H4WeBNbDX9tVW1wsIjof7+PPmn+9aNZh79OE0ghR7g/TKCwC3HESKGjiG6T/+skByLUK
         x5nw==
X-Gm-Message-State: APjAAAUcsxb7YaW2MYNrMiNvKxGojzZQbQsjZK2Q2AbeODX20aO+67uY
        oPw9poBqKOXBjeqvLKYmgpAoLZjvN27TeB8xf7ZPN0342yu6nSqd
X-Google-Smtp-Source: APXvYqwwa+nZtF9Sx3WfSZakXXeuoEBEmYIahuKbpO3xTf53DWVkAELeROBcyGvimqm9QPTVYkA0naJpKKfvkZmEazY=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr9309065wrm.262.1580637050093;
 Sun, 02 Feb 2020 01:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20200201233304.18322-1-ardb@kernel.org> <20200202093442.GB72728@gmail.com>
In-Reply-To: <20200202093442.GB72728@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 2 Feb 2020 10:50:39 +0100
Message-ID: <CAKv+Gu9V7hHFaFZmz=U_PP82wxP+J2rqVUasuOpvm-Jjg96OdA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: fix boot regression on systems with invalid
 memmap entries
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Feb 2020 at 10:34, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > In efi_clean_memmap(), we do a pass over the EFI memory map to remove
> > bogus entries that may be returned on certain systems.
> >
> > Commit 1db91035d01aa8bf ("efi: Add tracking for dynamically allocated
> > memmaps") refactored this code to pass the input to efi_memmap_install(=
)
> > via a temporary struct on the stack, which is populated using an
> > initializer which inadvertently defines the value of its size field
> > in terms of its desc_size field, which value cannot be relied upon yet
> > in the initializer itself.
> >
> > Fix this by using efi.memmap.desc_size instead, which is where we get
> > the value for desc_size from in the first place.
> >
> > Tested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 59f7f6d60cf6..ae923ee8e2b4 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
> >                       .phys_map =3D efi.memmap.phys_map,
> >                       .desc_version =3D efi.memmap.desc_version,
> >                       .desc_size =3D efi.memmap.desc_size,
> > -                     .size =3D data.desc_size * (efi.memmap.nr_map - n=
_removal),
> > +                     .size =3D efi.memmap.desc_size * (efi.memmap.nr_m=
ap - n_removal),
> >                       .flags =3D 0,
> >               };
>
> Applied, and I also added:
>
>     Reported-by: J=C3=B6rg Otte <jrg.otte@gmail.com>
>     Tested-by: J=C3=B6rg Otte <jrg.otte@gmail.com>
>
> I presumptively added the J=C3=B6rg's Tested-by tag: won't send the commi=
t to
> Linus if he still has trouble booting the laptop.
>
> I'm still amazed GCC doesn't warn about this pattern - why?
>

Not sure - it seems it just gets confused, given that the below

int foo(void)
{
        struct {
                int i;
                int j;
        } data =3D { .j =3D 0, .i =3D data.j };

        return data.i;
}

does give me

/tmp/foo.c: In function =E2=80=98foo=E2=80=99:
/tmp/foo.c:7:30: warning: =E2=80=98data.j=E2=80=99 is used uninitialized in=
 this
function [-Wuninitialized]
  } data =3D { .j =3D 0, .i =3D data.j };
                          ~~~~^~
while the warnings go away when I reorder i and j in the struct definition.

> BTW., could we please also organize such assignments vertically as well:
>
>                         .phys_map       =3D efi.memmap.phys_map,
>                         .desc_version   =3D efi.memmap.desc_version,
>                         .desc_size      =3D efi.memmap.desc_size,
>                         .size           =3D efi.memmap.desc_size * (efi.m=
emmap.nr_map - n_removal),
>                         .flags          =3D 0,
>
> (See the patch below.)
>

Sure, I'll incorporate that.

> Had we done that earlier the weird pattern would have stuck out a lot
> more:
>
>                         .phys_map       =3D efi.memmap.phys_map,
>                         .desc_version   =3D efi.memmap.desc_version,
>                         .desc_size      =3D efi.memmap.desc_size,
>                         .size           =3D data.desc_size * (efi.memmap.=
nr_map - n_removal),
>                         .flags          =3D 0,
>
> BTW., is there a reason "struct efi_memory_map" doesn't embedd a "struct
> efi_memory_map_data"? Or is efi_memory_map firmware ABI?
>
> If they shared the structure then copying would be easier.
>

It's not firmware ABI, and even the memory map itself is not firmware
ABI apart from the early call to SetVirtualAddressMap where the
firmware consumes a memory map provided by the kernel.

I'll put this on my list of things to look at. FYI I am current doing
another pass of improvements aimed at unifying the boot flow between
architectures even more, and adding support for UEFI spec changes that
permit firmware implementations to omit certain runtime services. So
expect another couple of PRs over the coming six weeks or so
