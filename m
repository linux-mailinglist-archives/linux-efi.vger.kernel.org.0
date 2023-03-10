Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEE6B4830
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjCJPAW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjCJO74 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 09:59:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55212B02A;
        Fri, 10 Mar 2023 06:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F69B82314;
        Fri, 10 Mar 2023 14:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183ACC433AA;
        Fri, 10 Mar 2023 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459985;
        bh=1U3ZGoxMVWmjPucnPpBAP/Pp5NuMyMLxskxUDpQAahI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i/yeV+Zb6roRkp4hdufvESXq2SYqYvYRO/h+YE+WGVAV8SBfvjVgPCcwGN/iCz3rq
         rsixtQmshaxwAcTRcoslV/kr/068ZuWsFVoQ97ju/2ARbAuhEn55xdaz4UGUDuLAU+
         IcZEO/V4Tj+N//IAXAOCOEG+5x4vwaE4pA1If28GjnL+SzgzASQPArQDMDXeMWpi9/
         +VJwo3fi2mH4C/3ZPqvbOtsYRS/9zsavEilo6m1aVYwHDEs+ZEnXtWKC8eqcpcYXNG
         Y3PppAdyKVK1Y64gYQTHaVsWm2mr/UfH90jhioBstTr9SMk0krigovXeXywCZXNv+V
         6vcpMjtHkEwgw==
Received: by mail-lj1-f177.google.com with SMTP id a32so5543294ljr.9;
        Fri, 10 Mar 2023 06:53:05 -0800 (PST)
X-Gm-Message-State: AO0yUKWKSfw71Od6AZQTVmDAv192A77fdIa7m/HrGzvohL3EFVIvl9tE
        g5qgQ5eb9UxQCxIB2gfMR60XjZvRWaOS1SDIddg=
X-Google-Smtp-Source: AK7set92uO/ZIaujKuol6kgCT0IK0ijm8dq2HYhWO2YoU9AsIHslUiUioFlCWcMaKWTMA7mjBB9jZZrRQioRZ45lAJs=
X-Received: by 2002:a05:651c:1725:b0:295:8ef2:8707 with SMTP id
 be37-20020a05651c172500b002958ef28707mr8028412ljb.2.1678459983160; Fri, 10
 Mar 2023 06:53:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <2ebefd395ecadb2b2605bc52a8ac223392c0c153.1671098103.git.baskov@ispras.ru>
In-Reply-To: <2ebefd395ecadb2b2605bc52a8ac223392c0c153.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:52:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHY045xxhbC_+JRhwy-vObfKGFA8YnZr7anh6Khuk-HAA@mail.gmail.com>
Message-ID: <CAMj1kXHY045xxhbC_+JRhwy-vObfKGFA8YnZr7anh6Khuk-HAA@mail.gmail.com>
Subject: Re: [PATCH v4 12/26] x86/boot: Make kernel_add_identity_map() a pointer
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Convert kernel_add_identity_map() into a function pointer to be able
> to provide alternative implementations of this function. Required
> to enable calling the code using this function from EFI environment.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/ident_map_64.c |  7 ++++---
>  arch/x86/boot/compressed/misc.c         | 24 ++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h         | 15 +++------------
>  3 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index ba5108c58a4e..1aee524d3c2b 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -92,9 +92,9 @@ bool has_nx; /* set in head_64.S */
>  /*
>   * Adds the specified range to the identity mappings.
>   */
> -unsigned long kernel_add_identity_map(unsigned long start,
> -                                     unsigned long end,
> -                                     unsigned int flags)
> +unsigned long kernel_add_identity_map_(unsigned long start,

Please use a more discriminating name here - the trailing _ is rather
hard to spot.

> +                                      unsigned long end,
> +                                      unsigned int flags)
>  {
>         int ret;
>
> @@ -142,6 +142,7 @@ void initialize_identity_maps(void *rmode)
>         struct setup_data *sd;
>
>         boot_params = rmode;
> +       kernel_add_identity_map = kernel_add_identity_map_;
>
>         /* Exclude the encryption mask from __PHYSICAL_MASK */
>         physical_mask &= ~sme_me_mask;
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index aa4a22bc9cf9..c9c235d65d16 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -275,6 +275,22 @@ static void parse_elf(void *output, unsigned long output_len,
>         free(phdrs);
>  }
>
> +/*
> + * This points to actual implementation of mapping function
> + * for current environment: either EFI API wrapper,
> + * own implementation or dummy implementation below.
> + */
> +unsigned long (*kernel_add_identity_map)(unsigned long start,
> +                                        unsigned long end,
> +                                        unsigned int flags);
> +
> +static inline unsigned long kernel_add_identity_map_dummy(unsigned long start,

This function is never called, it only has its address taken, so the
'inline' makes no sense here.

> +                                                         unsigned long end,
> +                                                         unsigned int flags)
> +{
> +       return start;
> +}
> +
>  /*
>   * The compressed kernel image (ZO), has been moved so that its position
>   * is against the end of the buffer used to hold the uncompressed kernel
> @@ -312,6 +328,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>
>         init_default_io_ops();
>
> +       /*
> +        * On 64-bit this pointer is set during page table uninitialization,

initialization

> +        * but on 32-bit it remains uninitialized, since paging is disabled.
> +        */
> +       if (IS_ENABLED(CONFIG_X86_32))
> +               kernel_add_identity_map = kernel_add_identity_map_dummy;
> +
> +
>         /*
>          * Detect TDX guest environment.
>          *
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 38d31bec062d..0076b2845b4b 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -180,18 +180,9 @@ static inline int count_immovable_mem_regions(void) { return 0; }
>  #ifdef CONFIG_X86_5LEVEL
>  extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
>  #endif
> -#ifdef CONFIG_X86_64
> -extern unsigned long kernel_add_identity_map(unsigned long start,
> -                                            unsigned long end,
> -                                            unsigned int flags);
> -#else
> -static inline unsigned long kernel_add_identity_map(unsigned long start,
> -                                                   unsigned long end,
> -                                                   unsigned int flags)
> -{
> -       return start;
> -}
> -#endif
> +extern unsigned long (*kernel_add_identity_map)(unsigned long start,
> +                                               unsigned long end,
> +                                               unsigned int flags);
>  /* Used by PAGE_KERN* macros: */
>  extern pteval_t __default_kernel_pte_mask;
>
> --
> 2.37.4
>
