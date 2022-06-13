Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46872548350
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiFMJnK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiFMJnJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 05:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D61FD3E;
        Mon, 13 Jun 2022 02:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9765B61381;
        Mon, 13 Jun 2022 09:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049FEC34114;
        Mon, 13 Jun 2022 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655113388;
        bh=ulBYdazc2wFX860EwjmZxCF5MO+a9+ET23gEIOuI9uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tsoF5PUgEdm+pCcqk1wEO/j63pF1rIMskWsdXvKiw9oelaPCL63JkGSUZBVCW+Up8
         OdU4GgnikAs86gCW772iq2GdT/k7Lw+tK0SF9qk5BpHuIEaEFUzwMfJZkEeMuabWWC
         23ktv6pcWgBceNYn0HIZowp9HjxC3oKlMAX9/XsQ1JxxQXpaOZ4Yxdc/d8yBv+Flew
         vBwy+eYVEmw4iXocJ6jhRQd+xEfLUKwyl2ToUDONmUKCOX4odS9gvX9y1u0vN7Lr9F
         F28Txo+thuVrxRbkDkQXaIUYDC+KI6tPhQhBsX1pIERKoIU28SNqeSzj+8kzUA1+32
         kWU82zQ+k1m+w==
Received: by mail-yb1-f173.google.com with SMTP id r82so8886411ybc.13;
        Mon, 13 Jun 2022 02:43:07 -0700 (PDT)
X-Gm-Message-State: AOAM533GFsvjR/HbyF8YhyZkTVf7bUMyMmW4NfAD5z74g2rmb8oS4IMZ
        FMedLNfA44MMaUE2fod0jAUZtC1Ax2Pnn9FXUlo=
X-Google-Smtp-Source: ABdhPJzmP9blBBv2mg91KpFnNjYRBYxTtwemJ3QI215u5foHBkyL5k8czGe5M8VE60LXBByru/7LVHtt6lQCMWUK07g=
X-Received: by 2002:a05:6820:1501:b0:41b:d535:325c with SMTP id
 ay1-20020a056820150100b0041bd535325cmr5522819oob.60.1655113376804; Mon, 13
 Jun 2022 02:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613082147.183145-1-mawupeng1@huawei.com> <20220613082147.183145-6-mawupeng1@huawei.com>
In-Reply-To: <20220613082147.183145-6-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 11:42:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFn_FKt2jLJOntvT0FBtL9b=VWZdrBFpn48LBMDLy1WBQ@mail.gmail.com>
Message-ID: <CAMj1kXFn_FKt2jLJOntvT0FBtL9b=VWZdrBFpn48LBMDLy1WBQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: Only remove nomap flag for initrd
To:     Wupeng Ma <mawupeng1@huawei.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, paulmck@kernel.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, swboyd@chromium.org,
        wei.liu@kernel.org, robin.murphy@arm.com, david@redhat.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
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

On Mon, 13 Jun 2022 at 10:00, Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> Commit 177e15f0c144 ("arm64: add the initrd region to the linear mapping explicitly")
> remove all the flags of the memory used by initrd. This is fine since
> MEMBLOCK_MIRROR is not used in arm64.
>
> However with mirrored feature introduced to arm64, this will clear the mirrored
> flag used by initrd, which will lead to error log printed by
> find_zone_movable_pfns_for_nodes() if the lower 4G range has some non-mirrored
> memory.
>
> To solve this problem, only MEMBLOCK_NOMAP flag will be removed via
> memblock_clear_nomap().
>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

This needs and ack from the arm64 maintainers, please?
And also please fix the subject to include 'arm64'


> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61..8456dbae9441 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -350,8 +350,8 @@ void __init arm64_memblock_init(void)
>                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>                         phys_initrd_size = 0;
>                 } else {
> -                       memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>                         memblock_add(base, size);
> +                       memblock_clear_nomap(base, size);
>                         memblock_reserve(base, size);
>                 }
>         }
> --
> 2.25.1
>
