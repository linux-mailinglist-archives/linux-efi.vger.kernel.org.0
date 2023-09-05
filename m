Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4839792A52
	for <lists+linux-efi@lfdr.de>; Tue,  5 Sep 2023 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjIEQev (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Sep 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354281AbjIEKbv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Sep 2023 06:31:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD82E8
        for <linux-efi@vger.kernel.org>; Tue,  5 Sep 2023 03:31:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9a21b6d105cso338517866b.3
        for <linux-efi@vger.kernel.org>; Tue, 05 Sep 2023 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693909906; x=1694514706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S35RjLtTeUiL0oK4WaMu3773GIHLmxuJ99VNH62qR3I=;
        b=QrzMNPFUg9LSi8GQnuGc0hR4eANbZzNr3iUKsbWQ4Txo5WCMstfky91Br/5+QJV7CE
         WRCktZidvpTLsLDxTimIew5iG5LXE6uNts1MM+zAnkvPMkXhuK+8uCiTgJRTZ1DneP1u
         UNvf2h/V8eMTww+QYCM/9YeZu2ppURyR65XzWYu65pul+uJODHDraWkxwRbsx0+Vu1OP
         ixhiBjPQvv5qV6IDanq+n9lgvjn0BuD7npJ0AgPRXLlCYeyunW4mjeVJ3me6ESNs1P+E
         PEXORthZ9ZncD7NJXw+2ycZYYX9MMyPlLeXVTb7rXonLAllWC4T/g6U3eumrahBH0vvs
         tVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693909906; x=1694514706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S35RjLtTeUiL0oK4WaMu3773GIHLmxuJ99VNH62qR3I=;
        b=Nd7Fco7/XJ86rjAc8z+PmKcyYbR+IPfqmWOX6iHNreEpmXl9cpbUUC4bsRcYaysOJQ
         b4mbAnYtpl40sE40DpiPqSFhX6PPQcjLT3boWr3ZQDb8Yi6rUSzGjTvr/yXSkV9RXovx
         oFRL7vKTvnv6JJb0vLWCbE45aCSAOKkHrE7yhsTQTQr1o+WLQeJGl0xOWc2DBrDzYcVF
         jr5o7cwd6Z7EIBYgZFyOCc6JBwknTNenEpMk76eZSl6feeua1UE9T9pysrF1cMhk4sAu
         15HYbR4AyiVzR2vBHMTeEJlPpLJtQrZ93AzTRCwPhfitESQ/Hep1sxJj41A3bOsBtKY1
         zOGA==
X-Gm-Message-State: AOJu0Yx64bkJmeGiZ3TjpuSULOwjNUNVqDnJNKKmK6GkqVha3XQ1MgQk
        LPcbE/JCc8T9rakUgdjg07tcATOon5X466KmbcF8aNRg
X-Google-Smtp-Source: AGHT+IHXiMYQ0dzTcFvGucvEc9/hoAyHyfOVwPGQSUHueN8hnJX8qAOgE5kuEmsUExIqJ9+lbjSNqw==
X-Received: by 2002:a17:906:319b:b0:9a1:fcd7:b825 with SMTP id 27-20020a170906319b00b009a1fcd7b825mr9273316ejy.71.1693909905990;
        Tue, 05 Sep 2023 03:31:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906850700b00993664a9987sm7371811ejx.103.2023.09.05.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:31:44 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:31:42 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
Message-ID: <20230905-d4d7b1944ac3487156ce4f5c@orel>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy>
 <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
 <20230831-f0f847c5703875f1e67635c1@orel>
 <DM8PR11MB5751CDA12CB037C678F1B829B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5751CDA12CB037C678F1B829B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hi Xiao,

On Tue, Sep 05, 2023 at 09:46:20AM +0000, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Friday, September 1, 2023 1:00 AM
> > To: Anup Patel <apatel@ventanamicro.com>
> > Cc: Wang, Xiao W <xiao.w.wang@intel.com>; Conor Dooley
> > <conor.dooley@microchip.com>; Anup Patel <anup@brainfault.org>;
> > paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> > ardb@kernel.org; Li, Haicheng <haicheng.li@intel.com>; linux-
> > riscv@lists.infradead.org; linux-efi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > 
> > On Thu, Aug 31, 2023 at 09:37:30PM +0530, Anup Patel wrote:
> > > +Andrew
> > >
> > > On Thu, Aug 31, 2023 at 9:29 PM Wang, Xiao W <xiao.w.wang@intel.com>
> > wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > > > Sent: Wednesday, August 30, 2023 2:59 PM
> > > > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > > > Cc: Anup Patel <anup@brainfault.org>; paul.walmsley@sifive.com;
> > > > > palmer@dabbelt.com; aou@eecs.berkeley.edu; ardb@kernel.org; Li,
> > Haicheng
> > > > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > > > >
> > > > > On Wed, Aug 30, 2023 at 06:14:12AM +0000, Wang, Xiao W wrote:
> > > > > > Hi,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Anup Patel <anup@brainfault.org>
> > > > > > > Sent: Tuesday, August 29, 2023 7:08 PM
> > > > > > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > > > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > > > > > aou@eecs.berkeley.edu; ardb@kernel.org; Li, Haicheng
> > > > > > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > > > > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > > > > > >
> > > > > > > On Sun, Aug 6, 2023 at 8:09 AM Xiao Wang
> > <xiao.w.wang@intel.com>
> > > > > wrote:
> > > > > > > >
> > > > > > > > This patch leverages the alternative mechanism to dynamically
> > optimize
> > > > > > > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > > > > > > > Zbb ext is not supported by the runtime CPU, legacy implementation
> > is
> > > > > > > > used. If Zbb is supported, then the optimized variants will be
> > selected
> > > > > > > > via alternative patching.
> > > > > > > >
> > > > > > > > The legacy bitops support is taken from the generic C
> > implementation as
> > > > > > > > fallback.
> > > > > > > >
> > > > > > > > If the parameter is a build-time constant, we leverage compiler
> > builtin to
> > > > > > > > calculate the result directly, this approach is inspired by x86 bitops
> > > > > > > > implementation.
> > > > > > > >
> > > > > > > > EFI stub runs before the kernel, so alternative mechanism should not
> > be
> > > > > > > > used there, this patch introduces a macro EFI_NO_ALTERNATIVE for
> > this
> > > > > > > > purpose.
> > > > > > >
> > > > > > > I am getting the following compile error with this patch:
> > > > > > >
> > > > > > >   GEN     Makefile
> > > > > > >   UPD     include/config/kernel.release
> > > > > > >   UPD     include/generated/utsrelease.h
> > > > > > >   CC      kernel/bounds.s
> > > > > > > In file included from /home/anup/Work/riscv-
> > > > > > > test/linux/include/linux/bitmap.h:9,
> > > > > > >                  from
> > > > > > > /home/anup/Work/riscv-
> > > > > test/linux/arch/riscv/include/asm/cpufeature.h:9,
> > > > > > >                  from
> > > > > > > /home/anup/Work/riscv-
> > test/linux/arch/riscv/include/asm/hwcap.h:90,
> > > > > >
> > > > > >
> > > > > > It looks there's a cyclic header including, which leads to this build error.
> > > > > > I checked https://github.com/kvm-riscv/linux/tree/master and
> > > > > > https://github.com/torvalds/linux/tree/master, but I don't see
> > > > > > "asm/cpufeature.h" is included in asm/hwcap.h:90, maybe I miss
> > > > > something,
> > > > > > could you help point me to the repo/branch I should work on?
> > > > >
> > > > > From MAINTAINERS:
> > > > >       RISC-V ARCHITECTURE
> > > > >       ...
> > > > >       T:      git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> > > > >
> > > > > The for-next branch there is what you should be basing work on top of.
> > > > > AFAICT, you've made bitops.h include hwcap.h while cpufeature.h
> > includes
> > > > > both bitops.h (indirectly) and hwcap.h.
> > > >
> > > > Thanks for the info, but I can't reproduce Anup's build error with this for-
> > next branch, cpufeature.h is not included by hwcap.h there.
> > > > Maybe Anup could help double check the test environment?
> > >
> > > I figured that cpufeature.h included in hwcap.h is added by
> > > Drew's patch "RISC-V: Enable cbo.zero in usermode"
> > 
> > I think we should probably split hwcap.h into two parts. The defines stay
> > and the rest can move to cpufeature.h
> 
> OK, I will base on your cbo.zero enabling patch series to make a new version. Will move some contents from hwcap.h into cpufeature.h so that we can remove the including of cpufeature.h in hwcap.h.
> 

I just realized I forgot to CC you on my v3 posting of the cbo.zero
series[1] yesterday. Sorry about that.

[1] https://lore.kernel.org/all/20230904170220.167816-8-ajones@ventanamicro.com/

Thanks,
drew
