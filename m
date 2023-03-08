Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B56B02DA
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCHJZf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCHJZI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 04:25:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE7AF2A2;
        Wed,  8 Mar 2023 01:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B455CB81C0B;
        Wed,  8 Mar 2023 09:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78991C433A8;
        Wed,  8 Mar 2023 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678267480;
        bh=i1sJ8zVY63SmSs6HOnkgI05wl57CXOVsfeHlIdvQIBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NrT5GmpCzsvy102yzX43IVPfE4if+ku299wG6Ehq/DJUxN2oto+BHubGa8FnKBj7x
         EYUHLAxWRH/aH8MmKp2WnbmfeNxAhh2Z9WNoZSyUY8McNA4aiCOCF3pLVNf+HPtB8b
         v4j/sdkeoRPmORxaUKLFUL7SptwC60pUxC3rsH/E9/LT0Je5hUV2vuHM+Ty7f/AlOO
         rDrChrzXq+phj1auyuRZQtKyxQUDOdQDu7HPLRYf7MdePbjrqPZFaqr4nKN9WQrzD9
         pNOstc7+t4IWHb4JM8a8ORFxeG2rotVEFYORlm1laoXDVaRlM741Ga3zzycEbA01Ij
         yxz2L1gSvtBsQ==
Received: by mail-lf1-f45.google.com with SMTP id bi9so20511856lfb.2;
        Wed, 08 Mar 2023 01:24:40 -0800 (PST)
X-Gm-Message-State: AO0yUKXXEOo+sTdr6na+l+0w+1weqAj9wwSNKqtu19ZL3j0TG9fj+NNT
        xnldbPpkyekatAj4+xLf7KS6i4A/BOf9eE7p/ak=
X-Google-Smtp-Source: AK7set/TDAJY8aPr63jhFnX80GRWQqOYpNKie97V2chZtU4ly8olN5Fb9gqHDWWBVsJJJkmQ1EXRFDQ3mdHYXY4ZWCQ=
X-Received: by 2002:ac2:5de1:0:b0:4dd:af74:fe17 with SMTP id
 z1-20020ac25de1000000b004ddaf74fe17mr5356537lfq.7.1678267478431; Wed, 08 Mar
 2023 01:24:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <71444a474b94ed69dbc4bc6b1592b10fad4e42a5.1671098103.git.baskov@ispras.ru>
In-Reply-To: <71444a474b94ed69dbc4bc6b1592b10fad4e42a5.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 10:24:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE9CcDRVt6U7xXeVozuj9Fjc00xN+ne0aYMMS-wxYPgxQ@mail.gmail.com>
Message-ID: <CAMj1kXE9CcDRVt6U7xXeVozuj9Fjc00xN+ne0aYMMS-wxYPgxQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/26] x86/boot: Increase boot page table size
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
> Previous upper limit ignored pages implicitly mapped from #PF handler
> by code accessing ACPI tables (boot/compressed/{acpi.c,efi.c}),
> so theoretical upper limit is higher than it was set.
>
> Using 4KB pages is desirable for better memory protection granularity.
> Approximately twice as much memory is required for those.
>
> Increase initial page table size to 64 4KB page tables.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/include/asm/boot.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index 9191280d9ea3..024d972c248e 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -41,22 +41,24 @@
>  # define BOOT_STACK_SIZE       0x4000
>
>  # define BOOT_INIT_PGT_SIZE    (6*4096)
> -# ifdef CONFIG_RANDOMIZE_BASE
>  /*
>   * Assuming all cross the 512GB boundary:
>   * 1 page for level4
> - * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
> - * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
> - * Total is 19 pages.
> + * (3+3)*2 pages for param and cmd_line
> + * (2+2+S)*2 pages for kernel and randomized kernel, where S is total number
> + *     of sections of kernel. Explanation: 2+2 are upper level page tables.
> + *     We can have only S unaligned parts of section: 1 at the end of the kernel
> + *     and (S-1) at the section borders. The start address of the kernel is
> + *     aligned, so an extra page table. There are at most S=6 sections in
> + *     vmlinux ELF image.
> + * 3 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
> + * Total is 36 pages.
> + *
> + * Some pages are also required for UEFI memory map and
> + * ACPI table mappings, so we need to add extra space.
> + * FIXME: Figure out exact amount of pages.

So you are rounding up 36 to 64 to account for these pages, right?

So we should either drop the FIXME and explain that this is fine, or
fix it - we cannot merge it like this.

Thanks,
Ard.

>   */
> -#  ifdef CONFIG_X86_VERBOSE_BOOTUP
> -#   define BOOT_PGT_SIZE       (19*4096)
> -#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
> -#   define BOOT_PGT_SIZE       (17*4096)
> -#  endif
> -# else /* !CONFIG_RANDOMIZE_BASE */
> -#  define BOOT_PGT_SIZE                BOOT_INIT_PGT_SIZE
> -# endif
> +# define BOOT_PGT_SIZE         (64*4096)
>
>  #else /* !CONFIG_X86_64 */
>  # define BOOT_STACK_SIZE       0x1000
> --
> 2.37.4
>
