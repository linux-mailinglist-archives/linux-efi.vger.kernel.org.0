Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A34546568
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiFJLVC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiFJLVB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 07:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3A14B67E;
        Fri, 10 Jun 2022 04:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1E0620B0;
        Fri, 10 Jun 2022 11:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7B0C34114;
        Fri, 10 Jun 2022 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654860059;
        bh=xP5iYMV7lF2tEmzcBQ+jmLwPazuiglMxmNPs6b0I0/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpGddpvWv1wRH7zaLOcFreox7kAsZxznDXf1IJ775RtaTYZd85HBrIgC6GCJU7ySu
         YN7fHFfU4id+21vDKbwcQbSHhKrvoS42v04G+2Zvn8i2c9QmdXKskN3Sq0s6Hs4vUY
         kr0CBZgiQU0megrVUCVewzV9GQI/XNCeBP7QsrCS3LfHjX48SulJL+syyFH6zBNIUF
         GLsC9CTF3VjfoK37lQgLWabmb2x5YoRdlVZbk2B9yyhtsdNuWcsjbFZm6KYaXqTTnw
         46qMDgmHAXv0v7eYlxpw2b8yBWGEgrEOCInbmNSKBJsdmrBnqiwXOhKTgMLKR8/2l/
         dqP2E2YzOyTFA==
Received: by mail-yb1-f177.google.com with SMTP id e184so46470056ybf.8;
        Fri, 10 Jun 2022 04:20:59 -0700 (PDT)
X-Gm-Message-State: AOAM5302hhdyYG9hi94dRkS2x7Ui6eIm0a1jwfn97v/FloWLrvK6tIOu
        U/huglNqnjxMhNRq627NGsgDa41Tx6ZwPuvIAmM=
X-Google-Smtp-Source: ABdhPJwW7AgFca3wNHZohnSbkTgJQBw/fxL1AiQUUZkoXlebPze1b83w86K0iW12ZT4jzD5smdkaHxw4868lc9szGl4=
X-Received: by 2002:a05:6830:9c2:b0:606:1e0a:cc8d with SMTP id
 y2-20020a05683009c200b006061e0acc8dmr19092482ott.265.1654860048097; Fri, 10
 Jun 2022 04:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com> <20220607093805.1354256-7-mawupeng1@huawei.com>
In-Reply-To: <20220607093805.1354256-7-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 13:20:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMHn_jsMe2WxWZ-s_QV==1tc5k=xpbNXuDbGp0qF534w@mail.gmail.com>
Message-ID: <CAMj1kXGMHn_jsMe2WxWZ-s_QV==1tc5k=xpbNXuDbGp0qF534w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] efi: Disable mirror feature if kernelcore is not specified
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
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
        Stephen Boyd <swboyd@chromium.org>, wei.liu@kernel.org,
        robin.murphy@arm.com, david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        chenzhou10@huawei.com, vijayb@linux.microsoft.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
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

On Tue, 7 Jun 2022 at 11:16, Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> If system have some mirrored memory and mirrored feature is not specified
> in boot parameter, the basic mirrored feature will be enabled and this will
> lead to the following situations:
>
> - memblock memory allocation prefers mirrored region. This may have some
>   unexpected influence on numa affinity.
>
> - contiguous memory will be split into several parts if parts of them
>   is mirrored memory via memblock_mark_mirror().
>
> To fix this, variable mirrored_kernelcore will be checked before calling
> efi_find_mirror() which will enable basic mirrored feature and this
> variable is true if kernelcore=mirror is added in the kernel parameters.
>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

This seems like the wrong place to do this. If mirrored memory is
irrelevant to memblock, it should ignore the attribute. So I think
this check belongs in mm/memblock.c instead.


> ---
>  drivers/firmware/efi/efi.c | 3 +++
>  include/linux/mm.h         | 2 ++
>  mm/page_alloc.c            | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 79c232e07de7..8a5edcb0dd82 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -454,6 +454,9 @@ void __init efi_find_mirror(void)
>         if (!efi_enabled(EFI_MEMMAP))
>                 return;
>
> +       if (!mirrored_kernelcore)
> +               return;
> +
>         for_each_efi_memory_desc(md) {
>                 unsigned long long start = md->phys_addr;
>                 unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..741ac7d022c3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2540,6 +2540,8 @@ extern void get_pfn_range_for_nid(unsigned int nid,
>                         unsigned long *start_pfn, unsigned long *end_pfn);
>  extern unsigned long find_min_pfn_with_active_regions(void);
>
> +extern bool mirrored_kernelcore;
> +
>  #ifndef CONFIG_NUMA
>  static inline int early_pfn_to_nid(unsigned long pfn)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..cf6f70aba787 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -356,7 +356,7 @@ static unsigned long required_kernelcore_percent __initdata;
>  static unsigned long required_movablecore __initdata;
>  static unsigned long required_movablecore_percent __initdata;
>  static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
> -static bool mirrored_kernelcore __meminitdata;
> +bool mirrored_kernelcore __meminitdata;
>
>  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>  int movable_zone;
> --
> 2.25.1
>
