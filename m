Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7178AB28
	for <lists+linux-efi@lfdr.de>; Mon, 28 Aug 2023 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjH1K2g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Aug 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjH1K2b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Aug 2023 06:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3119A;
        Mon, 28 Aug 2023 03:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3609563BC7;
        Mon, 28 Aug 2023 10:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B186C433C9;
        Mon, 28 Aug 2023 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693218503;
        bh=n4XE7nxHzlz8l0Qrwy0GwtxS3jAaS4ZgOwDJ7QBRvMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ET27Az6rATIIp9xTqGzMsJiDJ4oiH1GvmgM9gOR9s7J7H7cSv76GEx9ldL7/JMQeO
         ExJldwFcv2I95wkwSkTCX7rer3fUFVuTfJjpM+pfFx+kA+W49ib0+hEQ/xRSA1uiSN
         IFBsegGUQAfMXrsI1hRWSquPpQ1JvwD6v4bQ1Vn3S7tut/kKpRC/MSCC74Q5Afa18o
         V2XtmMvpkRswzCkC0T4THDncHwjfqCM61zy7StNNcVmkyqZ5a434c6oeXOBFge5W24
         //TQnh34uEheMdhBvcx38ooqHUscmeT6YfANwhePuUO8jKgXABX5PMtVHRElaHRdOd
         Deq/GSrJUlr5A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50078eba7afso4780914e87.0;
        Mon, 28 Aug 2023 03:28:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTaGGCGaHqewRXHdP8J42pUJ0fCWG6NRu/UaQhskAePfJ1bxlH
        UQLC9Vp48xc/4RSW1j7a7ElLOioxUAKRBHBm+U0=
X-Google-Smtp-Source: AGHT+IFkiw41hE2snmkem3YKEjAH2DwCq9IQe+ZWejBMSWZ61AhN8HbfynocOGTt6GHuZjv5/B8zMOj3BCjAwiJPErw=
X-Received: by 2002:a05:6512:220c:b0:4f4:b13a:d683 with SMTP id
 h12-20020a056512220c00b004f4b13ad683mr22435552lfu.69.1693218501656; Mon, 28
 Aug 2023 03:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAMj1kXHicVpT7PDSB=BgYEuhBxgufHqd9X8ZCg19k0_U+rjvEg@mail.gmail.com>
 <DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <DM8PR11MB575198187CB962EBE663B7F0B8E1A@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB575198187CB962EBE663B7F0B8E1A@DM8PR11MB5751.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Aug 2023 12:28:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCGVhA=bc+2gNZwb7s_H4K6yk54J04pUQ1XPW+8-2COA@mail.gmail.com>
Message-ID: <CAMj1kXGCGVhA=bc+2gNZwb7s_H4K6yk54J04pUQ1XPW+8-2COA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 27 Aug 2023 at 11:26, Wang, Xiao W <xiao.w.wang@intel.com> wrote:
>
> Hi,
>
> A gentle ping.
> Any other comments or suggestions for this patch? Or maybe we would review it in the Linux 6.7 development cycle?
>

This is going to be 6.7 material at the earliest in any case.

I am fine with the change as far as the EFI code is concerned, but I'd
suggest dropping EFI_ from the macro name, as it could be #define'd
for other reasons too.


>
> > -----Original Message-----
> > From: Wang, Xiao W
> > Sent: Sunday, August 6, 2023 6:24 PM
> > To: Ard Biesheuvel <ardb@kernel.org>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; anup@brainfault.org; Li, Haicheng
> > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] RISC-V: Optimize bitops with Zbb extension
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Sunday, August 6, 2023 5:39 PM
> > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > aou@eecs.berkeley.edu; anup@brainfault.org; Li, Haicheng
> > > <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] RISC-V: Optimize bitops with Zbb extension
> > >
> > > On Sun, 6 Aug 2023 at 04:39, Xiao Wang <xiao.w.wang@intel.com> wrote:
> > > >
> > > > This patch leverages the alternative mechanism to dynamically optimize
> > > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > > > Zbb ext is not supported by the runtime CPU, legacy implementation is
> > > > used. If Zbb is supported, then the optimized variants will be selected
> > > > via alternative patching.
> > > >
> > > > The legacy bitops support is taken from the generic C implementation as
> > > > fallback.
> > > >
> > > > If the parameter is a build-time constant, we leverage compiler builtin to
> > > > calculate the result directly, this approach is inspired by x86 bitops
> > > > implementation.
> > > >
> > > > EFI stub runs before the kernel, so alternative mechanism should not be
> > > > used there, this patch introduces a macro EFI_NO_ALTERNATIVE for this
> > > > purpose.
> > > >
> > >
> > > Why? The unpatched sequences work fine, no?
> >
> > It works. But there would be build warning: orphan section `.init.alternative'
> > from `./drivers/firmware/efi/libstub/gop.stub.o' being placed in section
> > `.init.alternative'. Besides, w/o this MACRO, the optimized variant would
> > never be used at runtime, so this patch choose to disable alternative.
> >
> > BRs,
> > Xiao
> >
> > >
> > >
> > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > ---
> > > >  arch/riscv/include/asm/bitops.h       | 266
> > +++++++++++++++++++++++++-
> > > >  drivers/firmware/efi/libstub/Makefile |   2 +-
> > > >  2 files changed, 264 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/bitops.h
> > > b/arch/riscv/include/asm/bitops.h
> > > > index 3540b690944b..f727f6489cd5 100644
> > > > --- a/arch/riscv/include/asm/bitops.h
> > > > +++ b/arch/riscv/include/asm/bitops.h
> > > > @@ -15,13 +15,273 @@
> > > >  #include <asm/barrier.h>
> > > >  #include <asm/bitsperlong.h>
> > > >
> > > > +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(EFI_NO_ALTERNATIVE)
> > > >  #include <asm-generic/bitops/__ffs.h>
> > > > -#include <asm-generic/bitops/ffz.h>
> > > > -#include <asm-generic/bitops/fls.h>
> > > >  #include <asm-generic/bitops/__fls.h>
> > > > +#include <asm-generic/bitops/ffs.h>
> > > > +#include <asm-generic/bitops/fls.h>
> > > > +
> > > > +#else
> > > > +#include <asm/alternative-macros.h>
> > > > +#include <asm/hwcap.h>
> > > > +
> > > > +#if (BITS_PER_LONG == 64)
> > > > +#define CTZW   "ctzw "
> > > > +#define CLZW   "clzw "
> > > > +#elif (BITS_PER_LONG == 32)
> > > > +#define CTZW   "ctz "
> > > > +#define CLZW   "clz "
> > > > +#else
> > > > +#error "Unexpected BITS_PER_LONG"
> > > > +#endif
> > [...]
