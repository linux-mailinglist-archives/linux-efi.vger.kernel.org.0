Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894A0546281
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiFJJfO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbiFJJfN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:35:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C2BFD3B;
        Fri, 10 Jun 2022 02:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCEEDB83310;
        Fri, 10 Jun 2022 09:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B32C34114;
        Fri, 10 Jun 2022 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654853709;
        bh=zLrmMpmoA8CObQY3AeLB7ra8RuQzI8MOQWc6jjj9U3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ly5hAIkgez3ocC+l+mQGgX4lzFeu4ZoxAtzBiJYdYYFXw+AchwN1lMwZlqgzok9sE
         DWVxhIPCrQRsiAp2gVDgqOaEBbC0cu4gFIGWjikw+zzzn9gJZra78AO16jpt9EvKkd
         yNXNqU1PuYG8MkqBBfBVTEsi/sxdmHA/t/AgqzJqugBnQtP+4TVNfRYumbPzXbapDL
         eFp6tWtErp/kO8gHnkEH7IRnrI0a7wcl0v/y+JrFnSIrV+QGrZ2YLYOpKXOPfWtGNx
         2mqImN+ln400cLTRHVbAGhyMeAalLmSrg+FeprjezxMT3j3t0mPseCjrmzeRdH2MLq
         7bze2SH3fykOg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-100eb6f7782so900767fac.2;
        Fri, 10 Jun 2022 02:35:09 -0700 (PDT)
X-Gm-Message-State: AOAM533rM2A0f/OvGRhDQWoKNtYvR3YOHMaCsvSQlEaGmlMs75JPVp83
        U8FwTho89tYM+8aK2jX6OhP79BoAX8IEy8ZkVY8=
X-Google-Smtp-Source: ABdhPJwtUww0eZw3o6xn5UGKNTcbExnHhigXRS8/EaLgckNAAkrH62R+XKUB/ZgL6kPVZjHCyNbogaEQ+dpljNgoFYo=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr4199738oan.126.1654853698407; Fri, 10
 Jun 2022 02:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-3-mawupeng1@huawei.com> <bfa0b919-fbc1-056c-4ed9-e940edfb6125@huawei.com>
In-Reply-To: <bfa0b919-fbc1-056c-4ed9-e940edfb6125@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 11:34:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGku3Y5d6Z+AAFkEauMWFY6LYpQAybqkXiQdRCMpS5tbw@mail.gmail.com>
Message-ID: <CAMj1kXGku3Y5d6Z+AAFkEauMWFY6LYpQAybqkXiQdRCMpS5tbw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] arm64/mirror: arm64 enabling - find mirrored
 memory ranges
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
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
        Zhen Lei <thunder.leizhen@huawei.com>, gpiccoli@igalia.com,
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

On Fri, 10 Jun 2022 at 11:27, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2022/6/7 17:38, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> > introduced mirrored memory support for x86 and this could be used on arm64.
> >
> > Since we only support this feature on arm64, efi_find_mirror() won't be placed
> > into efi_init(), which is used by riscv/arm/arm64, it is added in setup_arch()
> > to scan the memory map and mark mirrored memory in memblock.
>
> Move into efi_init() looks better, it won't bring negative effects on
> arm/riscv.
>
> but let's maintainer to make a decision.
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>

I don't disagree with that in principle, but x86 calls the efi fake
memmap stuff between efi_init() and efi_find_mirror(), and I already
indicated that I don't want to enable fake memmap on !X86.

But I do think there is some room for improvement here: we could move
things like efi_mokvar_table_init() and efi_esrt_init() into
efi_init() as well, and make efi_fake_memmap() do nothing on !X86 so
we can move it into efi_init() too.

> >
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >   arch/arm64/kernel/setup.c                       | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 8090130b544b..e3537646b6f7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2301,7 +2301,7 @@
> >
> >       keepinitrd      [HW,ARM]
> >
> > -     kernelcore=     [KNL,X86,IA-64,PPC]
> > +     kernelcore=     [KNL,X86,IA-64,PPC,ARM64]
> >                       Format: nn[KMGTPE] | nn% | "mirror"
> >                       This parameter specifies the amount of memory usable by
> >                       the kernel for non-movable allocations.  The requested
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index cf3a759f10d4..6e9acd7ecf0f 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -328,6 +328,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >
> >       xen_early_init();
> >       efi_init();
> > +     efi_find_mirror();
> >
> >       if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
> >            pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
