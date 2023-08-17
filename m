Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1477FEFC
	for <lists+linux-efi@lfdr.de>; Thu, 17 Aug 2023 22:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbjHQU0j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Aug 2023 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbjHQU0L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Aug 2023 16:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF6B35A6
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 13:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C96160B82
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD58C433C8
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692303969;
        bh=CB5O5P14QpxGS1mIm6pZ/Je2n3KuS72yRqN7u/EX7mU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B+WbcjxkGfOfq3Z52tmSr+3BcE4aiKFRRl2bdfXWKepg8laLqtsGbJGhzYMQwZDhH
         +5UrkhOdF/TXIR4QgvepUoY18MLnxfJ475HaXVYeMGGjlwWs5JI4Rx/qSy+/xNmEj7
         2e3c+HskT0mnGfAH8saqHgS9s2mo2n2fQ6UYExa+XXhD5n+ZnZ7cma75c+jnndvz2E
         lYxaSwB13Te8uuZTl9s8TytWO2HdFo16eygz6hf93FaP0TvyrzHuFfNNvVl3Lj0ocv
         /Aljs12spYpy9iV7RhxNYUG4wwj2VrEgpu/MbCkDiVx3QczZ8Ow9KGnYFXUmEy+IyL
         KAOGsGdKaqjcw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so184526e87.2
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 13:26:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw130lJ9EFtPbcpDA4NqSEACETqLjHUVIZtWknKnHyB4SWDDAXX
        1I4d0QPZfc4LX9S6Qq6FZjBZKAWonTr4cZtJzF4=
X-Google-Smtp-Source: AGHT+IGmo65ldvaxOuKOqZxlDv0lUcBKcIA3Q/+OzcYJ/wD7I5NYiTCahKikBvJ0dtA9c/KrRXQZu3at0ygLbITI1/8=
X-Received: by 2002:ac2:4425:0:b0:4ff:80d4:e12f with SMTP id
 w5-20020ac24425000000b004ff80d4e12fmr222303lfl.60.1692303967414; Thu, 17 Aug
 2023 13:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Aug 2023 22:25:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
Message-ID: <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> things, guides where direct mapping ends. Any memory above max_pfn is
> not going to be present in the direct mapping.
>
> e820__end_of_ram_pfn() finds the end of the ram based on the highest
> E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> calculation.
>
> Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> tables and might be required by kernel to function properly.
>
> Usually the problem is hidden because there is some E820_TYPE_RAM memory
> above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> can fit under the last E820_TYPE_ACPI range.
>
> Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> E820_TYPE_ACPI memory.
>
> The problem was discovered during debugging kexec for TDX guest. TDX
> guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> it between the kernels on kexec.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

No objections to this, but we might also simply drop E820_TYPE_ACPI
altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
memory that can be used by the OS as ordinary RAM if it is not
interested in the contents (or has already consumed them). So this
could arguably be classified as E820_TYPE_RAM too.

> ---
>  arch/x86/kernel/e820.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index fb8cf953380d..99c80680dc9e 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -827,7 +827,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
>  /*
>   * Find the highest page frame number we have available
>   */
> -static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type type)
> +static unsigned long __init e820_end_ram_pfn(unsigned long limit_pfn)
>  {
>         int i;
>         unsigned long last_pfn = 0;
> @@ -838,7 +838,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
>                 unsigned long start_pfn;
>                 unsigned long end_pfn;
>
> -               if (entry->type != type)
> +               if (entry->type != E820_TYPE_RAM &&
> +                   entry->type != E820_TYPE_ACPI)
>                         continue;
>
>                 start_pfn = entry->addr >> PAGE_SHIFT;
> @@ -864,12 +865,12 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
>
>  unsigned long __init e820__end_of_ram_pfn(void)
>  {
> -       return e820_end_pfn(MAX_ARCH_PFN, E820_TYPE_RAM);
> +       return e820_end_ram_pfn(MAX_ARCH_PFN);
>  }
>
>  unsigned long __init e820__end_of_low_ram_pfn(void)
>  {
> -       return e820_end_pfn(1UL << (32 - PAGE_SHIFT), E820_TYPE_RAM);
> +       return e820_end_ram_pfn(1UL << (32 - PAGE_SHIFT));
>  }
>
>  static void __init early_panic(char *msg)
> --
> 2.41.0
>
