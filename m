Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFE54839B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiFMJlq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbiFMJlp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 05:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65842183BD;
        Mon, 13 Jun 2022 02:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A7161389;
        Mon, 13 Jun 2022 09:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C43C3411E;
        Mon, 13 Jun 2022 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655113301;
        bh=3puFac3kf4giRZYoO/LUKKimJuAXXCEnp+VaAFnVp0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EI79bY9mlA9e+vYEx3uUUMNO6sq8+/PDdG2zOjbwdzhpBT5leidQSOyGozcRT3Ghb
         o5ssxRmDK/wronkeLdXsP/EtgKSNYhpVUDSKuo+aULIi8qsZpvwOQvf4MJXUvkqCRP
         2KwNLhRCBMaFJW2XwbGPwj7v0j7/aRmSzBjskTIl1fT+5riJV9/6hkIB2hDoidLE8h
         3tYi0lftDAzhGMOosxrgU8tJZer3KygMzLqjr8gJ5irMmV4lVlj9kDhRX2evUc0fXk
         LbGk1oFBMga+929A47QJVIYO6FMcnq0H8XwAGKBcYv4mpD8mSp69g9yTmqlumu7DG2
         oy3cQxwTwh6fw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso7720993fac.3;
        Mon, 13 Jun 2022 02:41:41 -0700 (PDT)
X-Gm-Message-State: AOAM530KsL050976LyuIWh1WxMoZYMWd1Fom5jJ2A6Dy4pcYmR8kNMtu
        jphEtEYwwU9YfuHkBUPGuprUOxL6InAAxddRZX8=
X-Google-Smtp-Source: ABdhPJzJUE5eQIFQw1wDEuVAU3BsFccZwzLeam8ZSG5GUbrm7+bJ19w2hvDgq/MdVlhPhpH4bgTqWjWDxk7foXjlYlM=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr7222252oan.126.1655113289866; Mon, 13
 Jun 2022 02:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220613082147.183145-1-mawupeng1@huawei.com> <20220613082147.183145-3-mawupeng1@huawei.com>
In-Reply-To: <20220613082147.183145-3-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 11:41:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWRXKZdLz3C2MofKXgx6yadSOQru979brm3r_sgBdMgw@mail.gmail.com>
Message-ID: <CAMj1kXEWRXKZdLz3C2MofKXgx6yadSOQru979brm3r_sgBdMgw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64/mirror: arm64 enabling - find mirrored
 memory ranges
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     corbet@lwn.net, will@kernel.org, catalin.marinas@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
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
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> introduced mirrored memory support for x86 and this could be used on arm64.
>
> Since we only support this feature on arm64, efi_find_mirror() won't be placed
> into efi_init(), which is used by riscv/arm/arm64, it is added in setup_arch()
> to scan the memory map and mark mirrored memory in memblock.
>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/kernel/setup.c                       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8090130b544b..e3537646b6f7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2301,7 +2301,7 @@
>
>         keepinitrd      [HW,ARM]
>
> -       kernelcore=     [KNL,X86,IA-64,PPC]
> +       kernelcore=     [KNL,X86,IA-64,PPC,ARM64]
>                         Format: nn[KMGTPE] | nn% | "mirror"
>                         This parameter specifies the amount of memory usable by
>                         the kernel for non-movable allocations.  The requested
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index cf3a759f10d4..6e9acd7ecf0f 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -328,6 +328,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>
>         xen_early_init();
>         efi_init();
> +       efi_find_mirror();
>
>         if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
>              pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");

As suggested by Kefeng Wang, I think this call needs to be moved into
efi_init() [the generic version]

Please drop this hunk, and add this call to efi_init() in patch #1.
