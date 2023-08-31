Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE878F197
	for <lists+linux-efi@lfdr.de>; Thu, 31 Aug 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbjHaRAQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Aug 2023 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbjHaRAO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Aug 2023 13:00:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3BEA3
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 10:00:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so124573366b.3
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693501209; x=1694106009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sR+D5V6w6Qq1SltI9MYKs11ulmOe+c77VyqwFo26gw4=;
        b=HEIhvP9xY6GqahXqynHtDmy85Za7aO3G5kC39Nsi0v/UMWvK5XXXm8TxBSggY8vc8H
         eiN83DM6/rL+bEGkRf8M3Lh4q/WapWjbTw94odnrCm5WSY/cC5EuacTqGg3c8rFxNBZ7
         ZeM/hW3ypl5NS8zxaepc8Fc0fAjtJEqUs+rC0ytstRFfTaob8vO2/AfYVhiC6cOpLR7r
         b55s1bTbvcq65lM+NSk8MyaeELRMbmrZlVqoyelkSnTGuG4YOcqFORJSR5vwqYB4ZQBB
         1Y5kuNNQYfXZFBGfZxoHM4S0EzL/MnO44ilXQYiR9rHPTgwGP4Gx0Op3siWRb2KdQte7
         qNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501209; x=1694106009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sR+D5V6w6Qq1SltI9MYKs11ulmOe+c77VyqwFo26gw4=;
        b=a5cZnwTj+Dw0VjSXu5Lbx1hYGzwjkGDXQe0sPvJI9uwJVeuvL4AT4xMz1RIKNcQk0e
         1IF6c3hd22IjmURsvH1DGfvbLdThlZreDgxBzQAvI3+MpYdb892XwmE0bRlaAVBowS6v
         AGVX9hj4AIAX4uhDc/fm7Qc4r/7k+ht6rAD55VRmWEjVie4qXtA4G9pSXTwLcV8STR8C
         9rBVNzW0TZgMKwIE/br9Sl3hmlvXD4H6vREPxmzq+9ETdXn+H742Kqzm6Yo/4fen1DMO
         snqnyfxdxutTyxwjMDSDi9WgnSuxQeufQtx1bJTh+8Wq/VkK5MI3j6yPq6cqlGaShXLu
         UCIw==
X-Gm-Message-State: AOJu0YwqspKHLcJGdVeTlHwr12shKoflsn2tRJVWTs7uCKhEUiwwB1zn
        ZGra13h3Fi+kOnDUrbARlnM0Cg==
X-Google-Smtp-Source: AGHT+IEvKIttARFVP4pBsvUJoQGBw1JJfcNIAwQYPGUxYEUx7aTWFgQgAQR/XqHVNGZ42CgljaLRiA==
X-Received: by 2002:a17:906:530c:b0:9a2:16e2:35c with SMTP id h12-20020a170906530c00b009a216e2035cmr4168284ejo.31.1693501209084;
        Thu, 31 Aug 2023 10:00:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b009a198078c53sm934928ejr.214.2023.08.31.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:00:08 -0700 (PDT)
Date:   Thu, 31 Aug 2023 19:00:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     "Wang, Xiao W" <xiao.w.wang@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
Message-ID: <20230831-f0f847c5703875f1e67635c1@orel>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy>
 <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 31, 2023 at 09:37:30PM +0530, Anup Patel wrote:
> +Andrew
> 
> On Thu, Aug 31, 2023 at 9:29 PM Wang, Xiao W <xiao.w.wang@intel.com> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > Sent: Wednesday, August 30, 2023 2:59 PM
> > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > Cc: Anup Patel <anup@brainfault.org>; paul.walmsley@sifive.com;
> > > palmer@dabbelt.com; aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haicheng
> > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > >
> > > On Wed, Aug 30, 2023 at 06:14:12AM +0000, Wang, Xiao W wrote:
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Anup Patel <anup@brainfault.org>
> > > > > Sent: Tuesday, August 29, 2023 7:08 PM
> > > > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > > > aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haicheng
> > > > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > > > >
> > > > > On Sun, Aug 6, 2023 at 8:09 AM Xiao Wang <xiao.w.wang@intel.com>
> > > wrote:
> > > > > >
> > > > > > This patch leverages the alternative mechanism to dynamically optimize
> > > > > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > > > > > Zbb ext is not supported by the runtime CPU, legacy implementation is
> > > > > > used. If Zbb is supported, then the optimized variants will be selected
> > > > > > via alternative patching.
> > > > > >
> > > > > > The legacy bitops support is taken from the generic C implementation as
> > > > > > fallback.
> > > > > >
> > > > > > If the parameter is a build-time constant, we leverage compiler builtin to
> > > > > > calculate the result directly, this approach is inspired by x86 bitops
> > > > > > implementation.
> > > > > >
> > > > > > EFI stub runs before the kernel, so alternative mechanism should not be
> > > > > > used there, this patch introduces a macro EFI_NO_ALTERNATIVE for this
> > > > > > purpose.
> > > > >
> > > > > I am getting the following compile error with this patch:
> > > > >
> > > > >   GEN     Makefile
> > > > >   UPD     include/config/kernel.release
> > > > >   UPD     include/generated/utsrelease.h
> > > > >   CC      kernel/bounds.s
> > > > > In file included from /home/anup/Work/riscv-
> > > > > test/linux/include/linux/bitmap.h:9,
> > > > >                  from
> > > > > /home/anup/Work/riscv-
> > > test/linux/arch/riscv/include/asm/cpufeature.h:9,
> > > > >                  from
> > > > > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/hwcap.h:90,
> > > >
> > > >
> > > > It looks there's a cyclic header including, which leads to this build error.
> > > > I checked https://github.com/kvm-riscv/linux/tree/master and
> > > > https://github.com/torvalds/linux/tree/master, but I don't see
> > > > "asm/cpufeature.h" is included in asm/hwcap.h:90, maybe I miss
> > > something,
> > > > could you help point me to the repo/branch I should work on?
> > >
> > > From MAINTAINERS:
> > >       RISC-V ARCHITECTURE
> > >       ...
> > >       T:      git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> > >
> > > The for-next branch there is what you should be basing work on top of.
> > > AFAICT, you've made bitops.h include hwcap.h while cpufeature.h includes
> > > both bitops.h (indirectly) and hwcap.h.
> >
> > Thanks for the info, but I can't reproduce Anup's build error with this for-next branch, cpufeature.h is not included by hwcap.h there.
> > Maybe Anup could help double check the test environment?
> 
> I figured that cpufeature.h included in hwcap.h is added by
> Drew's patch "RISC-V: Enable cbo.zero in usermode"

I think we should probably split hwcap.h into two parts. The defines stay
and the rest can move to cpufeature.h

Thanks,
drew

> 
> I had tried this patch on-top-of dev-upstream branch of
> https://github.com/ventanamicro/linux.git
> 
> Regards,
> Anup
> 
> >
> > BRs,
> > Xiao
> >
> >
> > >
> > > Hope that helps,
> > > Conor.
> > >
> > > > >                  from
> > > > > /home/anup/Work/riscv-test/linux/arch/riscv/include/asm/bitops.h:26,
> > > > >                  from
> > > > > /home/anup/Work/riscv-test/linux/include/linux/bitops.h:68,
> > > > >                  from /home/anup/Work/riscv-test/linux/include/linux/log2.h:12,
> > > > >                  from /home/anup/Work/riscv-test/linux/kernel/bounds.c:13:
> > > > > /home/anup/Work/riscv-test/linux/include/linux/find.h: In function
> > > > > 'find_next_bit':
> > > > > /home/anup/Work/riscv-test/linux/include/linux/find.h:64:30: error:
> > > > > implicit declaration of function '__ffs'
> > > > > [-Werror=implicit-function-declaration]
> > > > >    64 |                 return val ? __ffs(val) : size;
> > > > >
> > > > > Regards,
> > > > > Anup
> > > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/bitops.h       | 266
> > > +++++++++++++++++++++++++-
> > > > > >  drivers/firmware/efi/libstub/Makefile |   2 +-
> > > > > >  2 files changed, 264 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/bitops.h
> > > > > b/arch/riscv/include/asm/bitops.h
> > > > > > index 3540b690944b..f727f6489cd5 100644
> > > > > > --- a/arch/riscv/include/asm/bitops.h
> > > > > > +++ b/arch/riscv/include/asm/bitops.h
> > > > > > @@ -15,13 +15,273 @@
> > > > > >  #include <asm/barrier.h>
> > > > > >  #include <asm/bitsperlong.h>
