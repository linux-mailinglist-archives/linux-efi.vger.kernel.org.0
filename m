Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0D6B488E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjCJPDv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjCJPD2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:03:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE88139D2B;
        Fri, 10 Mar 2023 06:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7926961AC7;
        Fri, 10 Mar 2023 14:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2941C43332;
        Fri, 10 Mar 2023 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460193;
        bh=LleL3ZMXiz6vH6iyiFcxIHPqX8IjYxOLu8x8GMkkT7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuWvsAU+a12lUfhJbnBW+P3PNpOH9VY0rIWEmm5u3aWK4mliuT/TlnGh7ei4DVNIJ
         TRVb2BstxCKmpcymXYt1pTfSaGNzmqIOebcmvjcRIiT1cRbF8Zf9HoFpHw82wpNCra
         qfmnBBWvI3IKkueewMBJK8OTs3PGIMQgLOXXc4q+xgpPKl2k568Mm/z+6A6gPtgMti
         s6UN099qShgREiXrzbwW6fvh91prEw76Igx8rFrbw3cgZuFmtAAAqDP1pYrMRN/AF/
         KOFDoFd7H62nfzLJu0IjLj0q/LFl4wHrj2Di9d2DbB5yUwCogcCSyEAepNw9l4ph27
         qBKZr+tG/hIpg==
Received: by mail-lf1-f47.google.com with SMTP id s22so6928683lfi.9;
        Fri, 10 Mar 2023 06:56:33 -0800 (PST)
X-Gm-Message-State: AO0yUKW1Zk0hepVdv4fWpCbMkIoH1/OxLVkqgY+4BaC8YlTtm2+MNnXS
        2f/dx+LjAzKaxAyjpeZd1hTgzJBy0s8m5DmXLUY=
X-Google-Smtp-Source: AK7set/c34H7Dc7A+yycPZXF9xoTl+7Ldp/o9O9FJu/BBI76ZVV1kgmUBFPFFsudSyDcbCI+btxbo3AqcAvjcJ9qDsw=
X-Received: by 2002:ac2:5e99:0:b0:4db:37ff:f5d0 with SMTP id
 b25-20020ac25e99000000b004db37fff5d0mr918242lfq.1.1678460191959; Fri, 10 Mar
 2023 06:56:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <9f951d6332eea6e46ebd46ca919ed5b1b85c0ba3.1671098103.git.baskov@ispras.ru>
In-Reply-To: <9f951d6332eea6e46ebd46ca919ed5b1b85c0ba3.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:56:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwaX8nGJdRM3==thO=KfXb3UwbF2jJhrqiZK-RcM+QLw@mail.gmail.com>
Message-ID: <CAMj1kXGwaX8nGJdRM3==thO=KfXb3UwbF2jJhrqiZK-RcM+QLw@mail.gmail.com>
Subject: Re: [PATCH v4 13/26] x86/boot: Split trampoline and pt init code
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> When allocating trampoline from libstub trampoline allocation is
> performed separately, so it needs to be skipped.
>
> Split trampoline initialization and allocation code into two
> functions to make them invokable separately.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/pgtable_64.c | 73 +++++++++++++++++----------
>  1 file changed, 46 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index c7cf5a1059a8..1f7169248612 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -106,12 +106,8 @@ static unsigned long find_trampoline_placement(void)
>         return bios_start - TRAMPOLINE_32BIT_SIZE;
>  }
>
> -struct paging_config paging_prepare(void *rmode)
> +bool trampoline_pgtable_init(struct boot_params *boot_params)
>  {
> -       struct paging_config paging_config = {};
> -
> -       /* Initialize boot_params. Required for cmdline_find_option_bool(). */
> -       boot_params = rmode;
>
>         /*
>          * Check if LA57 is desired and supported.
> @@ -125,26 +121,10 @@ struct paging_config paging_prepare(void *rmode)
>          *
>          * That's substitute for boot_cpu_has() in early boot code.
>          */
> -       if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
> -                       !cmdline_find_option_bool("no5lvl") &&
> -                       native_cpuid_eax(0) >= 7 &&
> -                       (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
> -               paging_config.l5_required = 1;
> -       }
> -
> -       paging_config.trampoline_start = find_trampoline_placement();
> -
> -       trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
> -
> -       /* Preserve trampoline memory */
> -       memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
> -
> -       /* Clear trampoline memory first */
> -       memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
> -
> -       /* Copy trampoline code in place */
> -       memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
> -                       &trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
> +       bool l5_required = IS_ENABLED(CONFIG_X86_5LEVEL) &&
> +                          !cmdline_find_option_bool("no5lvl") &&
> +                          native_cpuid_eax(0) >= 7 &&
> +                          (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)));
>
>         /*
>          * The code below prepares page table in trampoline memory.
> @@ -160,10 +140,10 @@ struct paging_config paging_prepare(void *rmode)
>          * We are not going to use the page table in trampoline memory if we
>          * are already in the desired paging mode.
>          */
> -       if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
> +       if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
>                 goto out;
>
> -       if (paging_config.l5_required) {
> +       if (l5_required) {
>                 /*
>                  * For 4- to 5-level paging transition, set up current CR3 as
>                  * the first and the only entry in a new top-level page table.
> @@ -185,6 +165,45 @@ struct paging_config paging_prepare(void *rmode)
>                        (void *)src, PAGE_SIZE);
>         }
>
> +out:
> +       return l5_required;
> +}
> +
> +struct paging_config paging_prepare(void *rmode)
> +{
> +       struct paging_config paging_config = {};
> +       bool early_trampoline_alloc = 0;

false

> +
> +       /* Initialize boot_params. Required for cmdline_find_option_bool(). */
> +       boot_params = rmode;
> +
> +       /*
> +        * We only need to find trampoline placement, if we have
> +        * not already done it from libstub.
> +        */
> +
> +       paging_config.trampoline_start = find_trampoline_placement();
> +       trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
> +       early_trampoline_alloc = 0;
> +

false again

And it never becomes true, nor is it used anywhere else. Can we get rid of it?

> +       /*
> +        * Preserve trampoline memory.
> +        * When trampoline is located in memory
> +        * owned by us, i.e. allocated in EFISTUB,
> +        * we don't care about previous contents
> +        * of this memory so copying can also be skipped.

Can you please reflow comments so they takes up fewer lines?

> +        */
> +       memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
> +
> +       /* Clear trampoline memory first */
> +       memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
> +
> +       /* Copy trampoline code in place */
> +       memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
> +                       &trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
> +
> +       paging_config.l5_required = trampoline_pgtable_init(boot_params);
> +
>  out:
>         return paging_config;
>  }
> --
> 2.37.4
>
