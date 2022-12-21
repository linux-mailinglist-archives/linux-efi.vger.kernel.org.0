Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA776532CE
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLUPAP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 10:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLUPAN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 10:00:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ECB6334;
        Wed, 21 Dec 2022 07:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC12617F5;
        Wed, 21 Dec 2022 15:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E9C433D2;
        Wed, 21 Dec 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671634811;
        bh=YUEtdkBBPAUWmuq6fIL/UyKq54OeFkglF7xic8M8yqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=igRLuaTwOufsczIztnoTZkdWW+ncUgjnZqT8iSzR1TyxsCD1eOh/FCpw42Bg+Bnmn
         vH7CGRXY+Mo7YcOd4XDBw+n0NnyNV4kig1DocR0/ZvFQviMzoh+vG2IUCgt+F53EF7
         t8zFoqbNx34nXSbs57ytUvlt7GO3xrpMtOg7X7RbynupJR3dwt5QkWrriCIalMVdvW
         Ae1habiMbrcy7qnSPyfh2shxD4+nhKUgM+JQFPnLuceG+PiCMpvZ2O/ciCc28PAVCK
         IdEtH58QdiEy85GpCUMZaU18iovT97XZpVjnSciRiu+TvHGDcMNTX4Skdz0ChLsKbR
         4GRokJwDTBrzA==
Date:   Wed, 21 Dec 2022 15:00:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH 4/6] riscv: Fix EFI stub usage of KASAN instrumented
 string functions
Message-ID: <Y6MfdfRhlWYBL2KH@spud>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
 <20221216162141.1701255-5-alexghiti@rivosinc.com>
 <Y6MSxBaJU7JqfkJO@spud>
 <CAHVXubgzac0gXNF2FVeUrCAnOe7U9QhAfj3nWd_jc0maaepN2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YCPDz/kjihqgJ7An"
Content-Disposition: inline
In-Reply-To: <CAHVXubgzac0gXNF2FVeUrCAnOe7U9QhAfj3nWd_jc0maaepN2g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--YCPDz/kjihqgJ7An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 03:23:36PM +0100, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On Wed, Dec 21, 2022 at 3:06 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey Alex!
> >
> > On Fri, Dec 16, 2022 at 05:21:39PM +0100, Alexandre Ghiti wrote:
> > > The EFI stub must not use any KASAN instrumented code as the kernel
> > > proper did not initialize the thread pointer and the mapping for the
> > > KASAN shadow region.
> > >
> > > Avoid using generic string functions by copying stub dependencies from
> > > lib/string.c to drivers/firmware/efi/libstub/string.c as RISC-V does
> > > not implement architecture-specific versions of those functions.
> >
> > To the unaware among us, how does this interact with Heiko's custom
> > functions for bitmanip extensions? Is this diametrically opposed to
> > that, or does it actually help avoid having to have special handling
> > for the efi stub?
>=20
> I'm not sure which patchset you are referring to, but I guess you are
> talking about arch-specific string functions:

Oh sorry, I thought I had linked it..
https://lore.kernel.org/linux-riscv/20221130225614.1594256-1-heiko@sntech.d=
e/

> - If they are written in assembly and are then not kasan-instrumented,
> we'll be able to use them and then revert part of this patch.

They are indeed written in assembly. Ard had left some comments there.
Heiko's intention was to keep them out of the efistub, so perhaps your
patchset helps him out.

> - If they are written in C and are then kasan-instrumented (because
> we'll want to instrument them), we'll keep using the implementation
> added here.
>=20
> Hope that answers your question!
>=20
> Alex
>=20
> >
> > Also, checkpatch seems to be rather unhappy with you here:
> > https://gist.github.com/conor-pwbot/e5b4c8f2c3b88b4a8fcab4df437613e2
>=20
> Yes, those new functions are exact copies from lib/string.c, I did not
> want to fix those checkpatch errors in this patchset.

I figured from the description that that was likely, just mentioned it
as I was already replying! Apologies for not looking at the source of
the copy.

Thanks!

> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/riscv/kernel/image-vars.h        |   8 --
> > >  drivers/firmware/efi/libstub/Makefile |   7 +-
> > >  drivers/firmware/efi/libstub/string.c | 133 ++++++++++++++++++++++++=
++
> > >  3 files changed, 137 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image=
-vars.h
> > > index d6e5f739905e..15616155008c 100644
> > > --- a/arch/riscv/kernel/image-vars.h
> > > +++ b/arch/riscv/kernel/image-vars.h
> > > @@ -23,14 +23,6 @@
> > >   * linked at. The routines below are all implemented in assembler in=
 a
> > >   * position independent manner
> > >   */
> > > -__efistub_memcmp             =3D memcmp;
> > > -__efistub_memchr             =3D memchr;
> > > -__efistub_strlen             =3D strlen;
> > > -__efistub_strnlen            =3D strnlen;
> > > -__efistub_strcmp             =3D strcmp;
> > > -__efistub_strncmp            =3D strncmp;
> > > -__efistub_strrchr            =3D strrchr;
> > > -
> > >  __efistub__start             =3D _start;
> > >  __efistub__start_kernel              =3D _start_kernel;
> > >  __efistub__end                       =3D _end;
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware=
/efi/libstub/Makefile
> > > index b1601aad7e1a..031d2268bab5 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -130,9 +130,10 @@ STUBCOPY_RELOC-$(CONFIG_ARM)     :=3D R_ARM_ABS
> > >  # also means that we need to be extra careful to make sure that the =
stub does
> > >  # not rely on any absolute symbol references, considering that the v=
irtual
> > >  # kernel mapping that the linker uses is not active yet when the stu=
b is
> > > -# executing. So build all C dependencies of the EFI stub into libstu=
b, and do
> > > -# a verification pass to see if any absolute relocations exist in an=
y of the
> > > -# object files.
> > > +# executing. In addition, we need to make sure that the stub does no=
t use KASAN
> > > +# instrumented code like the generic string functions. So build all C
> > > +# dependencies of the EFI stub into libstub, and do a verification p=
ass to see
> > > +# if any absolute relocations exist in any of the object files.
> > >  #
> > >  STUBCOPY_FLAGS-$(CONFIG_ARM64)       +=3D --prefix-alloc-sections=3D=
=2Einit \
> > >                                  --prefix-symbols=3D__efistub_
> > > diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware=
/efi/libstub/string.c
> > > index 5d13e43869ee..5154ae6e7f10 100644
> > > --- a/drivers/firmware/efi/libstub/string.c
> > > +++ b/drivers/firmware/efi/libstub/string.c
> > > @@ -113,3 +113,136 @@ long simple_strtol(const char *cp, char **endp,=
 unsigned int base)
> > >
> > >       return simple_strtoull(cp, endp, base);
> > >  }
> > > +
> > > +#ifndef __HAVE_ARCH_STRLEN
> > > +/**
> > > + * strlen - Find the length of a string
> > > + * @s: The string to be sized
> > > + */
> > > +size_t strlen(const char *s)
> > > +{
> > > +     const char *sc;
> > > +
> > > +     for (sc =3D s; *sc !=3D '\0'; ++sc)
> > > +             /* nothing */;
> > > +     return sc - s;
> > > +}
> > > +EXPORT_SYMBOL(strlen);
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_STRNLEN
> > > +/**
> > > + * strnlen - Find the length of a length-limited string
> > > + * @s: The string to be sized
> > > + * @count: The maximum number of bytes to search
> > > + */
> > > +size_t strnlen(const char *s, size_t count)
> > > +{
> > > +     const char *sc;
> > > +
> > > +     for (sc =3D s; count-- && *sc !=3D '\0'; ++sc)
> > > +             /* nothing */;
> > > +     return sc - s;
> > > +}
> > > +EXPORT_SYMBOL(strnlen);
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_STRCMP
> > > +/**
> > > + * strcmp - Compare two strings
> > > + * @cs: One string
> > > + * @ct: Another string
> > > + */
> > > +int strcmp(const char *cs, const char *ct)
> > > +{
> > > +     unsigned char c1, c2;
> > > +
> > > +     while (1) {
> > > +             c1 =3D *cs++;
> > > +             c2 =3D *ct++;
> > > +             if (c1 !=3D c2)
> > > +                     return c1 < c2 ? -1 : 1;
> > > +             if (!c1)
> > > +                     break;
> > > +     }
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(strcmp);
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_STRRCHR
> > > +/**
> > > + * strrchr - Find the last occurrence of a character in a string
> > > + * @s: The string to be searched
> > > + * @c: The character to search for
> > > + */
> > > +char *strrchr(const char *s, int c)
> > > +{
> > > +     const char *last =3D NULL;
> > > +     do {
> > > +             if (*s =3D=3D (char)c)
> > > +                     last =3D s;
> > > +     } while (*s++);
> > > +     return (char *)last;
> > > +}
> > > +EXPORT_SYMBOL(strrchr);
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_MEMCMP
> > > +/**
> > > + * memcmp - Compare two areas of memory
> > > + * @cs: One area of memory
> > > + * @ct: Another area of memory
> > > + * @count: The size of the area.
> > > + */
> > > +#undef memcmp
> > > +__visible int memcmp(const void *cs, const void *ct, size_t count)
> > > +{
> > > +     const unsigned char *su1, *su2;
> > > +     int res =3D 0;
> > > +
> > > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > +     if (count >=3D sizeof(unsigned long)) {
> > > +             const unsigned long *u1 =3D cs;
> > > +             const unsigned long *u2 =3D ct;
> > > +             do {
> > > +                     if (get_unaligned(u1) !=3D get_unaligned(u2))
> > > +                             break;
> > > +                     u1++;
> > > +                     u2++;
> > > +                     count -=3D sizeof(unsigned long);
> > > +             } while (count >=3D sizeof(unsigned long));
> > > +             cs =3D u1;
> > > +             ct =3D u2;
> > > +     }
> > > +#endif
> > > +     for (su1 =3D cs, su2 =3D ct; 0 < count; ++su1, ++su2, count--)
> > > +             if ((res =3D *su1 - *su2) !=3D 0)
> > > +                     break;
> > > +     return res;
> > > +}
> > > +EXPORT_SYMBOL(memcmp);
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_MEMCHR
> > > +/**
> > > + * memchr - Find a character in an area of memory.
> > > + * @s: The memory area
> > > + * @c: The byte to search for
> > > + * @n: The size of the area.
> > > + *
> > > + * returns the address of the first occurrence of @c, or %NULL
> > > + * if @c is not found
> > > + */
> > > +void *memchr(const void *s, int c, size_t n)
> > > +{
> > > +     const unsigned char *p =3D s;
> > > +     while (n-- !=3D 0) {
> > > +             if ((unsigned char)c =3D=3D *p++) {
> > > +                     return (void *)(p - 1);
> > > +             }
> > > +     }
> > > +     return NULL;
> > > +}
> > > +EXPORT_SYMBOL(memchr);
> > > +#endif
> > > --
> > > 2.37.2
> > >
> > >

--YCPDz/kjihqgJ7An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6MfdQAKCRB4tDGHoIJi
0rD1AQCqrDhav6hfY0d+Zxo7d411z36snzEbHw/G2g8zY1b+aQEA5L8T8mE5iRl3
Ov5E1pIIrfvvmg4vRhlfFTAQXS7AkQs=
=gSFB
-----END PGP SIGNATURE-----

--YCPDz/kjihqgJ7An--
