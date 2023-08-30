Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1278D977
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjH3SdM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbjH3HAS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 03:00:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C171A3;
        Wed, 30 Aug 2023 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693378815; x=1724914815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mvg/nUDtYhEADCoBEFukMvDaTm/pr0NPS2b3VR6z3RM=;
  b=WjyZGU+XgyG9qhZTcgB8fizMjjN1agKm5S2SuuZ1kv18+92/aJWJ61wW
   SdCLdMGwEXU4jlRL5MREljKt+higARoxObIbrdR306UUPFVSlHie72NyW
   6nlZfCMQYkawWY0yoklFaj7d8GrnNpuXuDQwc/KcdYhQGjnZHwjgFKHDV
   OQRRkG2pXNjhoIc0Ra8xItOI65eUv5mc8vsFuP3+o1ZKutipv8E5A/EBz
   7JkenMtFpGRiSM+q06lDEpZAUXdVHLMZNWPHcTYo8AP6oldpnFG75C2m4
   mPxfz0npNOj3s9Cm25ub2i8wSeIEKOPLJzGAJNjWBsgZZcRwBR///qiqs
   w==;
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="asc'?scan'208";a="169013177"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2023 00:00:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 30 Aug 2023 00:00:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 30 Aug 2023 00:00:01 -0700
Date:   Wed, 30 Aug 2023 07:59:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
CC:     Anup Patel <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
Message-ID: <20230830-breeze-washboard-ef496d5c9d5a@wendy>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BxCw0DgMJ3ArtR6u"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--BxCw0DgMJ3ArtR6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 06:14:12AM +0000, Wang, Xiao W wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Anup Patel <anup@brainfault.org>
> > Sent: Tuesday, August 29, 2023 7:08 PM
> > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haicheng
> > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> >=20
> > On Sun, Aug 6, 2023 at 8:09=E2=80=AFAM Xiao Wang <xiao.w.wang@intel.com=
> wrote:
> > >
> > > This patch leverages the alternative mechanism to dynamically optimize
> > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > > Zbb ext is not supported by the runtime CPU, legacy implementation is
> > > used. If Zbb is supported, then the optimized variants will be select=
ed
> > > via alternative patching.
> > >
> > > The legacy bitops support is taken from the generic C implementation =
as
> > > fallback.
> > >
> > > If the parameter is a build-time constant, we leverage compiler built=
in to
> > > calculate the result directly, this approach is inspired by x86 bitops
> > > implementation.
> > >
> > > EFI stub runs before the kernel, so alternative mechanism should not =
be
> > > used there, this patch introduces a macro EFI_NO_ALTERNATIVE for this
> > > purpose.
> >=20
> > I am getting the following compile error with this patch:
> >=20
> >   GEN     Makefile
> >   UPD     include/config/kernel.release
> >   UPD     include/generated/utsrelease.h
> >   CC      kernel/bounds.s
> > In file included from /home/anup/Work/riscv-
> > test/linux/include/linux/bitmap.h:9,
> >                  from
> > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/cpufeature.h:9,
> >                  from
> > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/hwcap.h:90,
>=20
>=20
> It looks there's a cyclic header including, which leads to this build err=
or.
> I checked https://github.com/kvm-riscv/linux/tree/master and
> https://github.com/torvalds/linux/tree/master, but I don't see
> "asm/cpufeature.h" is included in asm/hwcap.h:90, maybe I miss something,
> could you help point me to the repo/branch I should work on?

=46rom MAINTAINERS:
	RISC-V ARCHITECTURE
	...
	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git

The for-next branch there is what you should be basing work on top of.
AFAICT, you've made bitops.h include hwcap.h while cpufeature.h includes
both bitops.h (indirectly) and hwcap.h.

Hope that helps,
Conor.

> >                  from
> > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/bitops.h:26,
> >                  from
> > /home/anup/Work/riscv-test/linux/include/linux/bitops.h:68,
> >                  from /home/anup/Work/riscv-test/linux/include/linux/lo=
g2.h:12,
> >                  from /home/anup/Work/riscv-test/linux/kernel/bounds.c:=
13:
> > /home/anup/Work/riscv-test/linux/include/linux/find.h: In function
> > 'find_next_bit':
> > /home/anup/Work/riscv-test/linux/include/linux/find.h:64:30: error:
> > implicit declaration of function '__ffs'
> > [-Werror=3Dimplicit-function-declaration]
> >    64 |                 return val ? __ffs(val) : size;
> >=20
> > Regards,
> > Anup
> >=20
> >=20
> > >
> > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > ---
> > >  arch/riscv/include/asm/bitops.h       | 266 ++++++++++++++++++++++++=
+-
> > >  drivers/firmware/efi/libstub/Makefile |   2 +-
> > >  2 files changed, 264 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/bitops.h
> > b/arch/riscv/include/asm/bitops.h
> > > index 3540b690944b..f727f6489cd5 100644
> > > --- a/arch/riscv/include/asm/bitops.h
> > > +++ b/arch/riscv/include/asm/bitops.h
> > > @@ -15,13 +15,273 @@
> > >  #include <asm/barrier.h>
> > >  #include <asm/bitsperlong.h>
> > >
> > > +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(EFI_NO_ALTERNATIVE)
> > >  #include <asm-generic/bitops/__ffs.h>
> > > -#include <asm-generic/bitops/ffz.h>
> > > -#include <asm-generic/bitops/fls.h>
> > >  #include <asm-generic/bitops/__fls.h>
> > > +#include <asm-generic/bitops/ffs.h>
> > > +#include <asm-generic/bitops/fls.h>
> > > +
> > > +#else
> > > +#include <asm/alternative-macros.h>
> > > +#include <asm/hwcap.h>
> > > +
> > > +#if (BITS_PER_LONG =3D=3D 64)
> > > +#define CTZW   "ctzw "
> > > +#define CLZW   "clzw "
> > > +#elif (BITS_PER_LONG =3D=3D 32)
> > > +#define CTZW   "ctz "
> > > +#define CLZW   "clz "
> > > +#else
> > > +#error "Unexpected BITS_PER_LONG"
> > > +#endif
> > > +
> > > +static __always_inline unsigned long variable__ffs(unsigned long wor=
d)
> > > +{
> > > +       int num;
> > > +
> > > +       asm_volatile_goto(
> > > +               ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_Z=
BB, 1)
> > > +               : : : : legacy);
> > > +
> > > +       asm volatile (
> > > +               ".option push\n"
> > > +               ".option arch,+zbb\n"
> > > +               "ctz %0, %1\n"
> > > +               ".option pop\n"
> > > +               : "=3Dr" (word) : "r" (word) :);
> > > +
> > > +       return word;
> > > +
> > > +legacy:
> > > +       num =3D 0;
> > > +#if BITS_PER_LONG =3D=3D 64
> > > +       if ((word & 0xffffffff) =3D=3D 0) {
> > > +               num +=3D 32;
> > > +               word >>=3D 32;
> > > +       }
> > > +#endif
> > > +       if ((word & 0xffff) =3D=3D 0) {
> > > +               num +=3D 16;
> > > +               word >>=3D 16;
> > > +       }
> > > +       if ((word & 0xff) =3D=3D 0) {
> > > +               num +=3D 8;
> > > +               word >>=3D 8;
> > > +       }
> > > +       if ((word & 0xf) =3D=3D 0) {
> > > +               num +=3D 4;
> > > +               word >>=3D 4;
> > > +       }
> > > +       if ((word & 0x3) =3D=3D 0) {
> > > +               num +=3D 2;
> > > +               word >>=3D 2;
> > > +       }
> > > +       if ((word & 0x1) =3D=3D 0)
> > > +               num +=3D 1;
> > > +       return num;
> > > +}
> > > +
> > > +/**
> > > + * __ffs - find first set bit in a long word
> > > + * @word: The word to search
> > > + *
> > > + * Undefined if no set bit exists, so code should check against 0 fi=
rst.
> > > + */
> > > +#define __ffs(word)                            \
> > > +       (__builtin_constant_p(word) ?           \
> > > +        (unsigned long)__builtin_ctzl(word) :  \
> > > +        variable__ffs(word))
> > > +
> [...]

--BxCw0DgMJ3ArtR6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO7oxwAKCRB4tDGHoIJi
0ozlAQDIl5mI7ovdiMJADRIobwVL0Wabj7o88Y28I+1sghdKfAEAx17o0kYzHC1p
TWhYbjU4Mgdz6pbu5yyaDwqyyD44qw0=
=MI7l
-----END PGP SIGNATURE-----

--BxCw0DgMJ3ArtR6u--
