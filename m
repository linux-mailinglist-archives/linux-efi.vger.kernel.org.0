Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14CC5F9C3A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Oct 2022 11:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiJJJr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Oct 2022 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJJJr4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Oct 2022 05:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAC65677;
        Mon, 10 Oct 2022 02:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D69C60EC6;
        Mon, 10 Oct 2022 09:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B8C43142;
        Mon, 10 Oct 2022 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665395272;
        bh=nnihOVmzFGNko4uu8W5MlpFm56PIoC5JLlfqiul6UX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dIZPMQBSM59LVbHMuZsa8iN2YtQWK9VMBxUz0hRqApgTh2d8ZNnaPa/80DtwlB4iq
         AjbFLvk9xrIQmlDBo7QznVAd5LRtkazBhJMeames62y9asN/59EaMD7W9NBZgz5wSU
         euIEhw4afbYiwztp9G0N3NGaQ65DHWuFmxVEsAaobMSdxNnlA5JNtdVyGIVhTawOqD
         TDq2YF8P6gwkDcMSaqlkD0xr1tjxKhNGuy5yyYKsj6W70jI8DoJH33/aYuj5soMxyq
         hFi6T6+sMTpgha2PoINip0Y20J9H2j8TSj9aCdguflx10IZCXCOtNYkj/j9O7aUf+h
         71TLoG2/idx/Q==
Received: by mail-lf1-f52.google.com with SMTP id m19so14429041lfq.9;
        Mon, 10 Oct 2022 02:47:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf3PysNN3oqnihaBPepVSf9Ui78D2aiitneQkIYx0BMyCigq2QNo
        KVd4kSga1+B2ZYa6cznwihkJG4YRSsblSro0t8c=
X-Google-Smtp-Source: AMsMyM6E+wwzD4YPAV0SVevWvvsOtzZQjHw28ihNFr3hy7k/tVL/n+EOPZVBRNmKGLvebk47xyq4bsilxobop+/eY0U=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr3881478lfk.426.1665395270498; Mon, 10
 Oct 2022 02:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220930101024.118394-1-wangkefeng.wang@huawei.com> <28b5713f-6379-ef36-5139-6c3f0cbf27e8@huawei.com>
In-Reply-To: <28b5713f-6379-ef36-5139-6c3f0cbf27e8@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 11:47:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHQLxNR2ADR1A2CHHA3M8CWUnKrKWCMSBNnZOTvZasZg@mail.gmail.com>
Message-ID: <CAMj1kXEHQLxNR2ADR1A2CHHA3M8CWUnKrKWCMSBNnZOTvZasZg@mail.gmail.com>
Subject: Re: [PATCH v2] efi/arm: dump UEFI runtime page tables for ARM
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 8 Oct 2022 at 08:37, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Sorry, forget to Cc Ard and efi maillist, do it now.
>
> On 2022/9/30 18:10, Kefeng Wang wrote:
> > UEFI runtime page tables dump only for ARM64 at present,
> > but ARM support EFI and ARM_PTDUMP_DEBUGFS now. Since
> > ARM could potentially execute with a 1G/3G user/kernel
> > split, choosing 1G as the upper limit for UEFI runtime
> > end, with this, we could enable UEFI runtime page tables.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> > v2: update upper limit for ARM, only build test due to
> >      my qemu without UEFI boot support.

Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>




/ # cat /sys/kernel/debug/efi_page_tables
---[ UEFI runtime start ]---
0x20005000-0x20112000        1076K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x20112000-0x20114000           8K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x20114000-0x20117000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x20117000-0x20118000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x20118000-0x2011b000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x2011b000-0x2011c000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x2011c000-0x2011f000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x2011f000-0x2017c000         372K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x2017c000-0x20183000          28K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x20183000-0x20186000          12K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x20186000-0x20189000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x20189000-0x2018a000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x2018a000-0x2018d000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x2018d000-0x2018e000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x2018e000-0x20191000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x20191000-0x20193000           8K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
0x20193000-0x20195000           8K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
0x201a5000-0x203fd000        2400K PTE KERNEL      RW x  SHD MEM/CACHED/WBWA
0x20400000-0x24400000          64M PGD IO          RW NX SHD
0x24400000-0x24401000           4K PTE IO          RW NX SHD DEV/SHARED
---[ UEFI runtime end ]---

> >   arch/arm/include/asm/ptdump.h      | 1 +
> >   arch/arm64/include/asm/ptdump.h    | 1 +
> >   drivers/firmware/efi/arm-runtime.c | 4 ++--
> >   3 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> > index 0c2d3d0d4cc6..aad1d034136c 100644
> > --- a/arch/arm/include/asm/ptdump.h
> > +++ b/arch/arm/include/asm/ptdump.h
> > @@ -21,6 +21,7 @@ struct ptdump_info {
> >
> >   void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
> >   #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> > +#define EFI_RUNTIME_MAP_END  SZ_1G
> >   void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> >   #else
> >   static inline void ptdump_debugfs_register(struct ptdump_info *info,
> > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > index b1dd7ecff7ef..581caac525b0 100644
> > --- a/arch/arm64/include/asm/ptdump.h
> > +++ b/arch/arm64/include/asm/ptdump.h
> > @@ -23,6 +23,7 @@ struct ptdump_info {
> >
> >   void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
> >   #ifdef CONFIG_PTDUMP_DEBUGFS
> > +#define EFI_RUNTIME_MAP_END  DEFAULT_MAP_WINDOW_64
> >   void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> >   #else
> >   static inline void ptdump_debugfs_register(struct ptdump_info *info,
> > diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> > index 3359ae2adf24..8f8ae479061b 100644
> > --- a/drivers/firmware/efi/arm-runtime.c
> > +++ b/drivers/firmware/efi/arm-runtime.c
> > @@ -25,14 +25,14 @@
> >   #include <asm/mmu.h>
> >   #include <asm/pgalloc.h>
> >
> > -#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
> > +#if defined(CONFIG_PTDUMP_DEBUGFS) || defined(CONFIG_ARM_PTDUMP_DEBUGFS)
> >   #include <asm/ptdump.h>
> >
> >   static struct ptdump_info efi_ptdump_info = {
> >       .mm             = &efi_mm,
> >       .markers        = (struct addr_marker[]){
> >               { 0,                            "UEFI runtime start" },
> > -             { DEFAULT_MAP_WINDOW_64,        "UEFI runtime end" },
> > +             { EFI_RUNTIME_MAP_END,          "UEFI runtime end" },
> >               { -1,                           NULL }
> >       },
> >       .base_addr      = 0,
