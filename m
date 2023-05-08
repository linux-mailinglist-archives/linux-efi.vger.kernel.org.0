Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48E6FA0DA
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjEHHT7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjEHHTy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A55E56;
        Mon,  8 May 2023 00:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323FD61FED;
        Mon,  8 May 2023 07:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E252C43444;
        Mon,  8 May 2023 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683530391;
        bh=6rOQ5NbJZcxzZSxkaCY+XurJ69PAlQjGw84WzWS8G1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AVS+L7/pJIeUn0n9W87kFXUcETAPzGxN1m4r3j+rxHh93FZ+1kjOn8qxRwvpgwW4D
         kQdYGkurJwrrrIlYczUphQq37LlzvhJp/N5CMEzYZVmiGUkfe7q0l6C0xEH5dUlpl1
         kPrXbyapvWYUWgJwTrrcklDJEpiQseQNMtwdBv/tFCepoMTAUIsBZpGAs1/2BF8wQO
         ACqilnqVQBBkMBURdaWjbNl7U32u7zfWQlyHqe2MBNzNg79/030jTKztqI9qQz3+jt
         TVK8xaCXS/KfhhE2LChb/9+HDLoIrXSJuwkeNIDEa2rR5XEQLkHHFKMVTozoFdzN6C
         F0mWb9E/MAZ7Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4ec8149907aso4782500e87.1;
        Mon, 08 May 2023 00:19:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDz2PZELH03i0EN5RAdrfSSNtuxuXi09EEZ0cSMNdxQ01VaX2+7g
        6wJDU8N1lBQxDmvNfboXfXYEc5YQJRcfdO97p5Y=
X-Google-Smtp-Source: ACHHUZ6Lr2KTv0yM1wNOHpOdrJL0IajT8cMul1NTtl5PaGquY5kQh44lWRaZjtVgvX94CbeoAVX2DSx6ApFYn5Q9v1Q=
X-Received: by 2002:ac2:511d:0:b0:4f1:4040:8143 with SMTP id
 q29-20020ac2511d000000b004f140408143mr2574670lfb.60.1683530389163; Mon, 08
 May 2023 00:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com> <20230507234618.18067-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230507234618.18067-3-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 May 2023 09:19:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFNXMmAsnQovWq18LrOnNL4=3Puamvz7p1ufynJfVEOug@mail.gmail.com>
Message-ID: <CAMj1kXFNXMmAsnQovWq18LrOnNL4=3Puamvz7p1ufynJfVEOug@mail.gmail.com>
Subject: Re: [PATCHv10 02/11] efi/x86: Get full memory map in allocate_e820()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 8 May 2023 at 01:46, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Currently allocate_e820() is only interested in the size of map and size
> of memory descriptor to determine how many e820 entries the kernel
> needs.
>
> UEFI Specification version 2.9 introduces a new memory type --
> unaccepted memory. To track unaccepted memory kernel needs to allocate
> a bitmap. The size of the bitmap is dependent on the maximum physical
> address present in the system. A full memory map is required to find
> the maximum address.
>
> Modify allocate_e820() to get a full memory map.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 26 +++++++++++--------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba..fff81843169c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -681,28 +681,24 @@ static efi_status_t allocate_e820(struct boot_params *params,
>                                   struct setup_data **e820ext,
>                                   u32 *e820ext_size)
>  {
> -       unsigned long map_size, desc_size, map_key;
> +       struct efi_boot_memmap *map;
>         efi_status_t status;
> -       __u32 nr_desc, desc_version;
> +       __u32 nr_desc;
>
> -       /* Only need the size of the mem map and size of each mem descriptor */
> -       map_size = 0;
> -       status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> -                            &desc_size, &desc_version);
> -       if (status != EFI_BUFFER_TOO_SMALL)
> -               return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> +       status = efi_get_memory_map(&map, false);
> +       if (status != EFI_SUCCESS)
> +               return status;
>
> -       nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> -
> -       if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> -               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> +       nr_desc = map->map_size / map->desc_size;
> +       if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> +               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> +                       EFI_MMAP_NR_SLACK_SLOTS;
>
>                 status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> -               if (status != EFI_SUCCESS)
> -                       return status;
>         }
>
> -       return EFI_SUCCESS;
> +       efi_bs_call(free_pool, map);
> +       return status;
>  }
>
>  struct exit_boot_struct {
> --
> 2.39.3
>
