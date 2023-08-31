Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46B078F0E5
	for <lists+linux-efi@lfdr.de>; Thu, 31 Aug 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbjHaQHs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Aug 2023 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQHq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Aug 2023 12:07:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34096E50
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 09:07:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564cd28d48dso764701a12.0
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693498062; x=1694102862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt+9EjvduU5MHNDAuSvAQ3bNBgQszfIiKkzKEcdHNCE=;
        b=Bux0AVKVQ148OQpuc4kUfzK/FiG7/6EQyXdHB8y5fdg/EJmYPC1AIvV2EeXUe6fKJH
         aC/rANPxF4hPGrEU1f7+VZBApzFAt9j6pM2fIVdjHKUU+Aa29aDGA4ioRfd4JbbNLSWk
         oDMGGesWgmmZIvklAtUFStmEBAHIJQmVAuDOrz9AN5vLdcgCbrTfG/CNwYrBEhOi4onM
         RUwmrEpb1hoz3gXQtdq+P0pM+VDOZRIFmv/lno4NNA6iZp12PY1t2yayFbbWEOqIVDjR
         4odyPttOwTUeArlAako5iG7Ht9dGGwsN3w77mEiFhI2sSZnw5T3LDKM4arRdjipEkbTI
         Oaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498062; x=1694102862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt+9EjvduU5MHNDAuSvAQ3bNBgQszfIiKkzKEcdHNCE=;
        b=hQjvKiuPnlpPa+8LRr7/Rmx0m7sl4gjpvx0pr5I2ItrKO0UuLGtQZuiH8vyTEtGXOr
         IBxfOydCIo1/fGj0h5BRgX/cISDXuJsP7QrWHarS8T8sL9i/UGGtalUsTntB6fMQ2vAL
         67hAs0BI+KV9ikDp9s+QJeOudhWqjWP3mDFp6GonTQiuoFQQyMVope8Fq8ylANhfGfOm
         sjYcNIf9QCtc6NXLbhjtyYPC5HkV9wxgQ8yf5qJHj6qJsUYy5oiCUUl4ag758JVREanD
         GwQxpmTjosDckDuQLTbLtAhMJFjN2b4b1QRcxCOlvuoXsgTg2KO61QCwzq+iJ3/rWKKV
         zfkg==
X-Gm-Message-State: AOJu0Yx773n0sj8V0treUi1gI/lUKK7BiCvsSWFN3L/d6zrbDXoWRo4j
        xEgrkdED5fpWgR/FwT61TvIH2WHfIrP87/ID8tYM8w==
X-Google-Smtp-Source: AGHT+IFt6g5apacYzh41nAGLXuzY3wp2OZedNRsJ9t+ZlewDMLKiSlOv0TsmobMtse+QKI+IUKH0jyY7uAazI5diPLY=
X-Received: by 2002:a17:90a:e2ca:b0:268:c5c7:f7ed with SMTP id
 fr10-20020a17090ae2ca00b00268c5c7f7edmr5255644pjb.30.1693498062492; Thu, 31
 Aug 2023 09:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy> <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 31 Aug 2023 21:37:30 +0530
Message-ID: <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+Andrew

On Thu, Aug 31, 2023 at 9:29=E2=80=AFPM Wang, Xiao W <xiao.w.wang@intel.com=
> wrote:
>
>
> > -----Original Message-----
> > From: Conor Dooley <conor.dooley@microchip.com>
> > Sent: Wednesday, August 30, 2023 2:59 PM
> > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > Cc: Anup Patel <anup@brainfault.org>; paul.walmsley@sifive.com;
> > palmer@dabbelt.com; aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haichen=
g
> > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> >
> > On Wed, Aug 30, 2023 at 06:14:12AM +0000, Wang, Xiao W wrote:
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Anup Patel <anup@brainfault.org>
> > > > Sent: Tuesday, August 29, 2023 7:08 PM
> > > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > > aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haicheng
> > > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > > >
> > > > On Sun, Aug 6, 2023 at 8:09=E2=80=AFAM Xiao Wang <xiao.w.wang@intel=
.com>
> > wrote:
> > > > >
> > > > > This patch leverages the alternative mechanism to dynamically opt=
imize
> > > > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. =
When
> > > > > Zbb ext is not supported by the runtime CPU, legacy implementatio=
n is
> > > > > used. If Zbb is supported, then the optimized variants will be se=
lected
> > > > > via alternative patching.
> > > > >
> > > > > The legacy bitops support is taken from the generic C implementat=
ion as
> > > > > fallback.
> > > > >
> > > > > If the parameter is a build-time constant, we leverage compiler b=
uiltin to
> > > > > calculate the result directly, this approach is inspired by x86 b=
itops
> > > > > implementation.
> > > > >
> > > > > EFI stub runs before the kernel, so alternative mechanism should =
not be
> > > > > used there, this patch introduces a macro EFI_NO_ALTERNATIVE for =
this
> > > > > purpose.
> > > >
> > > > I am getting the following compile error with this patch:
> > > >
> > > >   GEN     Makefile
> > > >   UPD     include/config/kernel.release
> > > >   UPD     include/generated/utsrelease.h
> > > >   CC      kernel/bounds.s
> > > > In file included from /home/anup/Work/riscv-
> > > > test/linux/include/linux/bitmap.h:9,
> > > >                  from
> > > > /home/anup/Work/riscv-
> > test/linux/arch/riscv/include/asm/cpufeature.h:9,
> > > >                  from
> > > > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/hwcap.h:90,
> > >
> > >
> > > It looks there's a cyclic header including, which leads to this build=
 error.
> > > I checked https://github.com/kvm-riscv/linux/tree/master and
> > > https://github.com/torvalds/linux/tree/master, but I don't see
> > > "asm/cpufeature.h" is included in asm/hwcap.h:90, maybe I miss
> > something,
> > > could you help point me to the repo/branch I should work on?
> >
> > From MAINTAINERS:
> >       RISC-V ARCHITECTURE
> >       ...
> >       T:      git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/l=
inux.git
> >
> > The for-next branch there is what you should be basing work on top of.
> > AFAICT, you've made bitops.h include hwcap.h while cpufeature.h include=
s
> > both bitops.h (indirectly) and hwcap.h.
>
> Thanks for the info, but I can't reproduce Anup's build error with this f=
or-next branch, cpufeature.h is not included by hwcap.h there.
> Maybe Anup could help double check the test environment?

I figured that cpufeature.h included in hwcap.h is added by
Drew's patch "RISC-V: Enable cbo.zero in usermode"

I had tried this patch on-top-of dev-upstream branch of
https://github.com/ventanamicro/linux.git

Regards,
Anup

>
> BRs,
> Xiao
>
>
> >
> > Hope that helps,
> > Conor.
> >
> > > >                  from
> > > > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/bitops.h:26=
,
> > > >                  from
> > > > /home/anup/Work/riscv-test/linux/include/linux/bitops.h:68,
> > > >                  from /home/anup/Work/riscv-test/linux/include/linu=
x/log2.h:12,
> > > >                  from /home/anup/Work/riscv-test/linux/kernel/bound=
s.c:13:
> > > > /home/anup/Work/riscv-test/linux/include/linux/find.h: In function
> > > > 'find_next_bit':
> > > > /home/anup/Work/riscv-test/linux/include/linux/find.h:64:30: error:
> > > > implicit declaration of function '__ffs'
> > > > [-Werror=3Dimplicit-function-declaration]
> > > >    64 |                 return val ? __ffs(val) : size;
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > >
> > > > >
> > > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/bitops.h       | 266
> > +++++++++++++++++++++++++-
> > > > >  drivers/firmware/efi/libstub/Makefile |   2 +-
> > > > >  2 files changed, 264 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/bitops.h
> > > > b/arch/riscv/include/asm/bitops.h
> > > > > index 3540b690944b..f727f6489cd5 100644
> > > > > --- a/arch/riscv/include/asm/bitops.h
> > > > > +++ b/arch/riscv/include/asm/bitops.h
> > > > > @@ -15,13 +15,273 @@
> > > > >  #include <asm/barrier.h>
> > > > >  #include <asm/bitsperlong.h>
