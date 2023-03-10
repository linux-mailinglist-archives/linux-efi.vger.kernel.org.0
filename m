Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5E6B46B7
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjCJOqG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 09:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjCJOpg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 09:45:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8E104918;
        Fri, 10 Mar 2023 06:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 418F6B822C4;
        Fri, 10 Mar 2023 14:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7EFC433AA;
        Fri, 10 Mar 2023 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459533;
        bh=IvPlgC8FNuEawjTiqdqcXG0Vuq2V20WvsE3UoU5IbnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B6LwG1EMbghLwWlgi1hcfkojRvbErW0wN95YI1lETMWrP0cXooU9Ji6GM6sUitU7s
         6KYvzXjJ3nTKJKAkmOulGTr8YzzOf4SUKNMnOtuzNjbVYdFXEzI4Ni7/K8kWYV4AZ4
         DQBydYDUqVZDZJJf0cuFZJZ7x+fk3PO3R2HalJB4o1x4cQLzz6MdNfTRRWKcuxr2pu
         lsimvh8C0zdYTFzJcBX6F+5At80QdoQpnnYh3n5wvDHeoXFTTnhlyglF58Q/XwItKE
         yNpKyeicf8JeB+78R1bZh9x0ECfMvOM4JhJXcwClmoCB6Bx4u0TckCLmdQivonl/+4
         E5Ywjyk6XcO9A==
Received: by mail-lj1-f177.google.com with SMTP id by8so5519773ljb.7;
        Fri, 10 Mar 2023 06:45:32 -0800 (PST)
X-Gm-Message-State: AO0yUKXlp6lX1eQPyoGGNWHACe7TWY4LSisTBEJcjXFxXQ3WnsPIAAsu
        9nZDHt8Q2apwfx36Ao4UhdIDm6Gmf7F63qoYlU4=
X-Google-Smtp-Source: AK7set/dfnjwOSg08q4BbmTlaoIno/ntt6qMLyfs5G2pcn7uWEfEebur3AyHswI1pCKIaNa5c6PrXtvK7tnjuPgZIJI=
X-Received: by 2002:a2e:595:0:b0:298:6d17:eaa7 with SMTP id
 143-20020a2e0595000000b002986d17eaa7mr3307263ljf.2.1678459531122; Fri, 10 Mar
 2023 06:45:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <721b5c42e0e79d307d5bcb08f9c8402f5067ded0.1671098103.git.baskov@ispras.ru>
In-Reply-To: <721b5c42e0e79d307d5bcb08f9c8402f5067ded0.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:45:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEdD8UT5SMU+3RH1qoNGcAOSF7fWnJS=Svy0EUB76FYng@mail.gmail.com>
Message-ID: <CAMj1kXEdD8UT5SMU+3RH1qoNGcAOSF7fWnJS=Svy0EUB76FYng@mail.gmail.com>
Subject: Re: [PATCH v4 02/26] x86/build: Remove RWX sections and align on 4KB
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

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Avoid creating sections simultaneously writable and readable
> to prepare for W^X implementation. Align sections on page size (4KB) to
> allow protecting them in the page tables.
>
> Split init code form ".init" segment into separate R_X ".inittext"
> segment and make ".init" segment non-executable.
>
> Also add these segments to x86_32 architecture for consistency.
> Currently paging is disabled in x86_32 in compressed kernel, so
> protection is not applied anyways, but .init code was incorrectly
> placed in non-executable ".data" segment. This should not change
> anything meaningful in memory layout now, but might be required in case
> memory protection will also be implemented in compressed kernel for
> x86_32.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

One nit: the series modifies both the decompressor linker script and
the core kernel one, so please make it very explicit in the commit log
which one is being modified, and why it matters for this particular
context.


> ---
>  arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 2e0ee14229bf..2e56d694c491 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -102,12 +102,11 @@ jiffies = jiffies_64;
>  PHDRS {
>         text PT_LOAD FLAGS(5);          /* R_E */
>         data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>         percpu PT_LOAD FLAGS(6);        /* RW_ */
>  #endif
> -       init PT_LOAD FLAGS(7);          /* RWE */
> -#endif
> +       inittext PT_LOAD FLAGS(5);      /* R_E */
> +       init PT_LOAD FLAGS(6);          /* RW_ */
>         note PT_NOTE FLAGS(0);          /* ___ */
>  }
>
> @@ -227,9 +226,10 @@ SECTIONS
>  #endif
>
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -       :init
> -#endif
> +       :inittext
> +
> +       . = ALIGN(PAGE_SIZE);
> +
>
>         /*
>          * Section for code used exclusively before alternatives are run. All
> @@ -241,6 +241,7 @@ SECTIONS
>         .altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>                 *(.altinstr_aux)
>         }
> +       :init
>
>         INIT_DATA_SECTION(16)
>
> --
> 2.37.4
>
