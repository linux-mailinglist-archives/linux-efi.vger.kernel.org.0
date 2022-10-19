Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8E603ADA
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJSHmt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSHms (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375A4F66A;
        Wed, 19 Oct 2022 00:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D47617A8;
        Wed, 19 Oct 2022 07:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70670C43470;
        Wed, 19 Oct 2022 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666165365;
        bh=14m9TnMdIamI7NRowRSrQHq987dQEEQNdsOMZoawFWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HClf0ncR3egbSc+Xcsue8EAwnK72ibfndgBCNLmhg3Z7OascqnmOL6vu5KprByuKG
         AStwREksRj3fInDnxgUSioaMyoJ7RO+uZ+R15f5puS6fGnR6VaGhev1K+YNyZ4Tv8e
         oa/etbJhxRQB9oA3ITSxnUoOn41Br4NkZNOKpZPDiKgbUpmmw/Gj+9IaZdwBQBMUQV
         fLPhMq8Nf6qXYj0f4d5mG3BebM89QXwxwti2e+9ZN4KMXOffphm0OPMIDJHs7nrikV
         k2kDrt4fgeQ20oAC5753SKsSWJQLeQZFm5XFXS/PT9Z4daW2+KA09IFaAwueWanGTF
         v4MKDK8a7XgrA==
Received: by mail-lj1-f178.google.com with SMTP id a6so21062578ljq.5;
        Wed, 19 Oct 2022 00:42:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf1szu+wzqgePkodL9i5eMrfm+S5Pu24zHtAv3dmrHv7aIex+iMD
        DlCIwpoGH2kiE8FxPMkygiveu+Ipl3rdGNFQjhk=
X-Google-Smtp-Source: AMsMyM5tlUReT+nKFmwl6ym1vN33SMdT6OsFPCIaILaxjZa8/POU7PbjxCRIZ/2S8kmECig82aDJXOIZDhcXimvBSvA=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr2578764lji.291.1666165363344; Wed, 19
 Oct 2022 00:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
In-Reply-To: <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:42:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvT4kTyMWhb-Qvwq88VuuvCDE94FCDsnAd4JqQEmPWPA@mail.gmail.com>
Message-ID: <CAMj1kXFvT4kTyMWhb-Qvwq88VuuvCDE94FCDsnAd4JqQEmPWPA@mail.gmail.com>
Subject: Re: [PATCH 16/16] efi/libstub: Use memory attribute protocol
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Add EFI_MEMORY_ATTRIBUTE_PROTOCOL as preferred alternative to DXE
> services for changing memory attributes in the EFISTUB.
>
> Use DXE services only as a fallback in case aforementioned protocol
> is not supported by UEFI implementation.
>
> Move DXE services initialization code closer to the place they are used
> to match EFI_MEMORY_ATTRIBUTE_PROTOCOL initialization code.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  drivers/firmware/efi/libstub/mem.c      | 166 ++++++++++++++++++------
>  drivers/firmware/efi/libstub/x86-stub.c |  17 ---
>  2 files changed, 127 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 89ebc8ad2c22..8c8782993b30 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -5,6 +5,9 @@
>
>  #include "efistub.h"
>
> +const efi_dxe_services_table_t *efi_dxe_table;
> +efi_memory_attribute_protocol_t *efi_mem_attrib_proto;
> +
>  static inline bool mmap_has_headroom(unsigned long buff_size,
>                                      unsigned long map_size,
>                                      unsigned long desc_size)
> @@ -131,50 +134,32 @@ void efi_free(unsigned long size, unsigned long addr)
>         efi_bs_call(free_pages, addr, nr_pages);
>  }
>
> -/**
> - * efi_adjust_memory_range_protection() - change memory range protection attributes
> - * @start:     memory range start address
> - * @size:      memory range size
> - *
> - * Actual memory range for which memory attributes are modified is
> - * the smallest ranged with start address and size aligned to EFI_PAGE_SIZE
> - * that includes [start, start + size].
> - *
> - * @return: status code
> - */
> -efi_status_t efi_adjust_memory_range_protection(unsigned long start,
> -                                               unsigned long size,
> -                                               unsigned long attributes)
> +static void retrive_dxe_table(void)

retrieve

> +{
> +       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> +       if (efi_dxe_table &&
> +           efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
> +               efi_warn("Ignoring DXE services table: invalid signature\n");
> +               efi_dxe_table = NULL;
> +       }
> +}
> +
> +static efi_status_t adjust_mem_attrib_dxe(efi_physical_addr_t rounded_start,
> +                                         efi_physical_addr_t rounded_end,
> +                                         unsigned long attributes)
>  {
>         efi_status_t status;
>         efi_gcd_memory_space_desc_t desc;
> -       efi_physical_addr_t end, next;
> -       efi_physical_addr_t rounded_start, rounded_end;
> +       efi_physical_addr_t end, next, start;
>         efi_physical_addr_t unprotect_start, unprotect_size;
>         int has_system_memory = 0;
>
> -       if (efi_dxe_table == NULL)
> -               return EFI_UNSUPPORTED;
> +       if (!efi_dxe_table) {
> +               retrive_dxe_table();

Same here

>
> -       /*
> -        * This function should not be used to modify attributes
> -        * other than writable/executable.
> -        */
> -
> -       if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
> -               return EFI_INVALID_PARAMETER;
> -
> -       /*
> -        * Disallow simultaniously executable and writable memory
> -        * to inforce W^X policy if direct extraction code is enabled.
> -        */
> -
> -       if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0 &&
> -           IS_ENABLED(CONFIG_EFI_STUB_EXTRACT_DIRECT))
> -               return EFI_INVALID_PARAMETER;
> -
> -       rounded_start = rounddown(start, EFI_PAGE_SIZE);
> -       rounded_end = roundup(start + size, EFI_PAGE_SIZE);
> +               if (!efi_dxe_table)
> +                       return EFI_UNSUPPORTED;
> +       }
>
>         /*
>          * Don't modify memory region attributes, they are
> @@ -182,14 +167,15 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>          * encounter firmware bugs.
>          */
>
> -       for (end = start + size; start < end; start = next) {
> +
> +       for (start = rounded_start, end = rounded_end; start < end; start = next) {
>
>                 status = efi_dxe_call(get_memory_space_descriptor,
>                                       start, &desc);
>
>                 if (status != EFI_SUCCESS) {
>                         efi_warn("Unable to get memory descriptor at %lx\n",
> -                                start);
> +                                (unsigned long)start);
>                         return status;
>                 }
>
> @@ -231,3 +217,105 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>
>         return EFI_SUCCESS;
>  }
> +
> +static void retrive_memory_attributes_proto(void)

and here

> +{
> +       efi_status_t status;
> +       efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
> +
> +       status = efi_bs_call(locate_protocol, &guid, NULL,
> +                            (void **)&efi_mem_attrib_proto);
> +       if (status != EFI_SUCCESS)
> +               efi_mem_attrib_proto = NULL;
> +}
> +
> +/**
> + * efi_adjust_memory_range_protection() - change memory range protection attributes
> + * @start:     memory range start address
> + * @size:      memory range size
> + *
> + * Actual memory range for which memory attributes are modified is
> + * the smallest ranged with start address and size aligned to EFI_PAGE_SIZE
> + * that includes [start, start + size].
> + *
> + * This function first attempts to use EFI_MEMORY_ATTRIBUTE_PROTOCOL,
> + * that is a part of UEFI Specification since version 2.10.
> + * If the protocol is unavailable it falls back to DXE services functions.
> + *
> + * @return: status code
> + */
> +efi_status_t efi_adjust_memory_range_protection(unsigned long start,
> +                                               unsigned long size,
> +                                               unsigned long attributes)
> +{
> +       efi_status_t status;
> +       efi_physical_addr_t rounded_start, rounded_end;
> +       unsigned long attr_clear;
> +
> +       /*
> +        * This function should not be used to modify attributes
> +        * other than writable/executable.
> +        */
> +
> +       if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
> +               return EFI_INVALID_PARAMETER;
> +
> +       /*
> +        * Disallow simultaniously executable and writable memory

simultaneously

> +        * to inforce W^X policy if direct extraction code is enabled.

enforce

> +        */
> +
> +       if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0 &&
> +           IS_ENABLED(CONFIG_EFI_STUB_EXTRACT_DIRECT))

efi_adjust_memory_range_protection() is a generic routine, but here it
depends on a x86-specific Kconfig symbol. Is that really necessary?

> +               return EFI_INVALID_PARAMETER;
> +
> +       rounded_start = rounddown(start, EFI_PAGE_SIZE);
> +       rounded_end = roundup(start + size, EFI_PAGE_SIZE);
> +
> +       if (!efi_mem_attrib_proto) {
> +               retrive_memory_attributes_proto();

retrieve

> +
> +               /* Fall back to DXE services if unsupported */
> +               if (!efi_mem_attrib_proto) {
> +                       return adjust_mem_attrib_dxe(rounded_start,
> +                                                    rounded_end,
> +                                                    attributes);
> +               }
> +       }
> +
> +       /*
> +        * Unlike DXE services functions, EFI_MEMORY_ATTRIBUTE_PROTOCOL
> +        * does not clear unset protection bit, so it needs to be cleared
> +        * explcitly
> +        */
> +
> +       attr_clear = ~attributes &
> +                    (EFI_MEMORY_RO | EFI_MEMORY_XP | EFI_MEMORY_RP);
> +
> +       status = efi_call_proto(efi_mem_attrib_proto,
> +                               clear_memory_attributes,
> +                               rounded_start,
> +                               rounded_end - rounded_start,
> +                               attr_clear);
> +       if (status != EFI_SUCCESS) {
> +               efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",

Need \n at the end here

> +                        (unsigned long)rounded_start,
> +                        (unsigned long)rounded_end,
> +                        status);
> +               return status;
> +       }
> +
> +       status = efi_call_proto(efi_mem_attrib_proto,
> +                               set_memory_attributes,
> +                               rounded_start,
> +                               rounded_end - rounded_start,
> +                               attributes);
> +       if (status != EFI_SUCCESS) {
> +               efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",

and here

> +                        (unsigned long)rounded_start,
> +                        (unsigned long)rounded_end,
> +                        status);
> +       }
> +
> +       return status;
> +}
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 914106d547a6..dd1e1e663072 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -22,7 +22,6 @@
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>
>  const efi_system_table_t *efi_system_table;
> -const efi_dxe_services_table_t *efi_dxe_table;
>  extern u32 image_offset;
>  static efi_loaded_image_t *image = NULL;
>
> @@ -401,15 +400,6 @@ static void setup_sections_memory_protection(void *image_base,
>                                              unsigned long init_size)
>  {
>  #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
> -       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> -
> -       if (!efi_dxe_table ||
> -           efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
> -               efi_warn("Unable to locate EFI DXE services table\n");
> -               efi_dxe_table = NULL;
> -               return;
> -       }
> -
>         extern char _head[], _ehead[];
>         extern char _compressed[], _ecompressed[];
>         extern char _text[], _etext[];
> @@ -791,13 +781,6 @@ unsigned long efi_main(efi_handle_t handle,
>         if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
>                 efi_exit(handle, EFI_INVALID_PARAMETER);
>
> -       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> -       if (efi_dxe_table &&
> -           efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
> -               efi_warn("Ignoring DXE services table: invalid signature\n");
> -               efi_dxe_table = NULL;
> -       }
> -
>  #ifndef CONFIG_EFI_STUB_EXTRACT_DIRECT
>         /*
>          * If the kernel isn't already loaded at a suitable address,
> --
> 2.35.1
>
