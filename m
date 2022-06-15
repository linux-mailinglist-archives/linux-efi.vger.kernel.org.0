Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83C54C5AE
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiFOKQQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFOKQP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 06:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF7037BF4;
        Wed, 15 Jun 2022 03:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87DE960C70;
        Wed, 15 Jun 2022 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB11C34115;
        Wed, 15 Jun 2022 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655288174;
        bh=LzuKKmeaKzYyf1F4EGCFzObtFswa551XpejD5PM/0gU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2e4eedCwuT64uSq8EWZIlqOealrKlJhOjYwUPwzUjmJe3h1gZVozcylD0pHKd3xB
         Ak6Oc8tweWPYhMTh9H3oadcrNqf+QiU9LPyAX/6yzLb9dednhlxc8YlZ9ce8PuC1Ja
         NHZaZBVX97va3bcZW8Ev5S8x4pj3H+aSGwSujEXKe2YYokqjbd8o8kqjr+IR6la6s3
         b+BdazS+sViwet2f8F/vjuwIdaqpG4Joh9L6TTujDPf1UclgVXVsul3UoHplJbGy38
         U2r67XkRS9chQDQXsUdeJiHunFShBZ/xGbDIlCLcdCYRVMWuiRl/HXRfVkZxuaPp3H
         f3taqgo3g7DTQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-fe32122311so15874740fac.7;
        Wed, 15 Jun 2022 03:16:13 -0700 (PDT)
X-Gm-Message-State: AJIora+HD5Dw5zsrzOD9yOe2H3eSWf8FMogwYJhfqJoeB/wpjeY/apXX
        0L4LqohiaEksf3oqP2Cs38MLpxhqC6LnnQOYEro=
X-Google-Smtp-Source: AGRyM1uN/3D1+5Ut4Xt2mabIT0hR6gzAEW7Im9WVGqBeGn3OnhJh0XIUKAqRs97/yUL1cD2/EM5eYL4/9b9oQIafJWE=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr5067969oan.126.1655288162336; Wed, 15
 Jun 2022 03:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220614092156.1972846-1-mawupeng1@huawei.com> <YqmQIpQ8hzxYkMv2@kernel.org>
In-Reply-To: <YqmQIpQ8hzxYkMv2@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jun 2022 12:15:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGytXz7VZh3xR=Vj-Mo7q+Wu3NUsqU9MFhPStm2=c9khw@mail.gmail.com>
Message-ID: <CAMj1kXGytXz7VZh3xR=Vj-Mo7q+Wu3NUsqU9MFhPStm2=c9khw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] introduce mirrored memory support for arm64
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, songmuchun@bytedance.com,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, gpiccoli@igalia.com,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        vijayb@linux.microsoft.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Jun 2022 at 09:54, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Jun 14, 2022 at 05:21:51PM +0800, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Patch #1 introduce mirrored memory support form arm64.
> > Patch #2-#4 fix some bugs for arm64 if memory reliable is enabled.
> > Patch #5 disable mirror feature if kernelcore is not specified.
> >
> > Thanks to Ard Biesheuvel's hard work [1], now kernel will perfer mirrored
> > memory if kaslr is enabled.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com/T/
> >
> >
> > Ma Wupeng (5):
> >   efi: arm64: Introduce ability to find mirrored memory ranges
> >   mm: Ratelimited mirrored memory related warning messages
> >   mm: Limit warning message in vmemmap_verify() to once
> >   arm64: mm: Only remove nomap flag for initrd
> >   memblock: Disable mirror feature if kernelcore is not specified
> >
> >  arch/arm64/mm/init.c            |  2 +-
> >  arch/x86/include/asm/efi.h      |  4 ----
> >  arch/x86/platform/efi/efi.c     | 23 -----------------------
> >  drivers/firmware/efi/efi-init.c |  1 +
> >  drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
> >  include/linux/efi.h             |  3 +++
> >  mm/internal.h                   |  2 ++
> >  mm/memblock.c                   |  7 +++++--
> >  mm/page_alloc.c                 |  2 +-
> >  mm/sparse-vmemmap.c             |  2 +-
> >  10 files changed, 37 insertions(+), 32 deletions(-)
>
> For the series: Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>


Thanks all, I've queued these up now.
