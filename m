Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF437A41B2
	for <lists+linux-efi@lfdr.de>; Mon, 18 Sep 2023 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjIRHCB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbjIRHBq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 03:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3905BA
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 00:01:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E4CC433C7
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 07:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695020500;
        bh=wj5Q0J4C7ksWt+3rizBSAh3P7DwftCb8k3vGZlZ6Z2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/AH/RPbEwD5ykGqenk715glUqn4/fDnU7AwE53Joi1mqnaT5VOSZ0SVQTaEoSGW6
         gqoLTuRLefvURzVD0UpvZ0NQV5E/scCq38kImGgU1qLt5H3koEaEGdWjjLjCsh+szm
         BFt/VqkPTKK/xFCZYjkG0eyZJq5i+nGjrt1ycGwSLF1uVwVPZTHYy+v2JnWaZbt7jD
         N99SsbJIH3yuvcZjRN6sT3B0/7ooOnL3XX7fSszQ2aL4bnwPUM8cvXjYHqsMTke9u5
         74t+fNefajVdaA0pCNFDSlPkXQo+zcwn2O6tA0CWoto0TfR0+yqjgc0dkJ/rIvXWRu
         mq9DZNtF/EFIQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so11899601fa.1
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 00:01:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+36uZk18PPIOaMq+upV4hRDSBst1ZDbEd16tD1Z1XBtOqCrON
        mmAsaVmvNB3lq5WDaR6umqWQgPcFMwCQRw/x/8M=
X-Google-Smtp-Source: AGHT+IFb0v4QILjwy6+GObECtE6ZayzVmEpbXx8B1XIo8kR7vJP3nNxOKSCr19XfMzHkAF0YrHh84MZh5+QEME+s1JQ=
X-Received: by 2002:a2e:84d5:0:b0:2bc:b884:c9be with SMTP id
 q21-20020a2e84d5000000b002bcb884c9bemr7001565ljh.30.1695020498580; Mon, 18
 Sep 2023 00:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
 <20230818151628.d7srn5k73vms7dcf@box.shutemov.name> <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
 <20230907104914.a4nt23yuronohivo@box.shutemov.name> <20230917170629.d35gnwb6o54bdrhl@box.shutemov.name>
In-Reply-To: <20230917170629.d35gnwb6o54bdrhl@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 18 Sep 2023 09:01:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF3BgEpZDpzfLm0=1cdSUy0ovb6Uog17em58=YLHaADug@mail.gmail.com>
Message-ID: <CAMj1kXF3BgEpZDpzfLm0=1cdSUy0ovb6Uog17em58=YLHaADug@mail.gmail.com>
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

On Sun, 17 Sept 2023 at 19:06, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Sep 07, 2023 at 01:49:14PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 06, 2023 at 11:17:12AM +0200, Ard Biesheuvel wrote:
> > > On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > > > > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > >
> > > > > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > > > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > > > > not going to be present in the direct mapping.
> > > > > >
> > > > > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > > > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > > > > calculation.
> > > > > >
> > > > > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > > > > tables and might be required by kernel to function properly.
> > > > > >
> > > > > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > > > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > > > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > > > > can fit under the last E820_TYPE_ACPI range.
> > > > > >
> > > > > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > > > > E820_TYPE_ACPI memory.
> > > > > >
> > > > > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > > > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > > > > it between the kernels on kexec.
> > > > > >
> > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > >
> > > > > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > > > > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > > > > memory that can be used by the OS as ordinary RAM if it is not
> > > > > interested in the contents (or has already consumed them). So this
> > > > > could arguably be classified as E820_TYPE_RAM too.
> > > >
> > > > Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> > > > IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> > > > kexec, regardless if it is crash kernel or not. I'm not sure we would not
> > > > break anything.
> > > >
> > >
> > > Yeah, you're right. So this patch is necessary in any case.
> > >
> > > Do we also need the EFI side patch then?
> >
> > Yes, we need it to get it mapped into the crashkernel direct mapping.
>
> Ughh. The patch alone causes crash as EFI_ACPI_RELACLAIM_MEMORY is not
> mapped into direct mapping during memory init.
>

It would be good if this boot path could be covered by lkp@ as well -
currently, you are the only person testing this manually. The same
applies to SEV-SNP by the way - there is zero coverage except for the
manual testing that Boris or Tom Lendacky might do.

> The patch below fixes the issue.
>
> I should have noticed it before, but I had essentially the same patch in
> my tree for a different reason. Sorry for that :/
>

No worries - it shouldn't be only up to you to test this stuff. I
would have tested it myself if I had access to TDX hardware.

> Please apply the patch below.
>

OK, queued up now.



> From b5d1faf9e515195c58cc5e34132284894fca17f2 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Mon, 14 Aug 2023 19:12:47 +0300
> Subject: [PATCH] efi/unaccepted: Make sure unaccepted table is mapped in
>  crashkernel case
>
> Unaccepted table is now allocated from EFI_ACPI_RELACLAIM_MEMORY. It
> translates into E820_TYPE_ACPI, which is not added to memblock and
> therefore not mapped in the direct mapping.
>
> It causes crash on the first touch of the table.
>
> Use memblock_add() to make sure that the table is mapped in direct
> mapping.
>
> Align the range to the nearest page boarders. Ranges smaller than page
> size are not going to be mapped.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: e7761d827e99 ("efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table")
> ---
>  drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 1599f1176842..4f409652b3c6 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -623,6 +623,34 @@ static __init int match_config_table(const efi_guid_t *guid,
>         return 0;
>  }
>
> +/**
> + * reserve_unaccepted - Map and reserve unaccepted configuration table
> + * @unaccepted: Pointer to unaccepted memory table
> + *
> + * memblock_add() makes sure that the table is mapped in direct mapping. During
> + * normal boot it happens automatically because the table is allocated from
> + * usable memory. But during crashkernel boot only memory specifically
> + * reserved for crash scenario is mapped. memblock_add() forces the table to be
> + * mapped in crashkernel case.
> + *
> + * Align the range to the nearest page boarders. Ranges smaller than page size
> + * are not going to be mapped.
> + *
> + * memblock_reserve() makes sure that future allocations will not touch the
> + * table.
> + */
> +
> +static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
> +{
> +       phys_addr_t start, size;
> +
> +       start = PAGE_ALIGN_DOWN(efi.unaccepted);
> +       size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
> +
> +       memblock_add(start, size);
> +       memblock_reserve(start, size);
> +}
> +
>  int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                                    int count,
>                                    const efi_config_table_type_t *arch_tables)
> @@ -751,11 +779,9 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>
>                 unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
>                 if (unaccepted) {
> -                       unsigned long size;
>
>                         if (unaccepted->version == 1) {
> -                               size = sizeof(*unaccepted) + unaccepted->size;
> -                               memblock_reserve(efi.unaccepted, size);
> +                               reserve_unaccepted(unaccepted);
>                         } else {
>                                 efi.unaccepted = EFI_INVALID_TABLE_ADDR;
>                         }
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
