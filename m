Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71267054F4
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjEPR0O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjEPR0N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 13:26:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671FD052;
        Tue, 16 May 2023 10:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9958C63D23;
        Tue, 16 May 2023 17:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043B9C433A8;
        Tue, 16 May 2023 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684257965;
        bh=vhh5+rlNKvpvY+IhdH8zTHvseXPWY4NQ5GWC/3H1Ha8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V+LbGn4//M8ZY7FQfVgEWR/RrWpvjJHCyUQ8N1CSkblyO3OHUzL7ySMjqXkT54ZtS
         nA2RhSFMmQc74B3l7jwJkrRjF3IHnA+OGSpBebntP+cnZn8Ad4opWArFDnyEhXxfxE
         EAAo2GuS6VskfmVrV44sH7wOixCVhcaQhUo1/Qtdke3Yzpf+g+cRaby/IrmpJkuvCu
         oGH4Axji6wJSujuY59rV66LGZT5HZgHig7PLcXD7NChUkkv+oVNTQ6iOFb0qf++QlP
         x/Zoel3jg9bfnPxvMn2iklpWIeSH8HpnmHJdD19GPzWHWauPksoEeKl0jzz0nCmOZK
         2uCpdgPBH0gOw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso16617132e87.0;
        Tue, 16 May 2023 10:26:04 -0700 (PDT)
X-Gm-Message-State: AC+VfDxcvAvwKTGqxMc47tDhCTbaJis0hh3puXO9phbAJ6fs/3G5P70v
        bdABubuOvYVPER7pdXuW7xMEwuhps7q3p1F/iZs=
X-Google-Smtp-Source: ACHHUZ68392EzdrHBxMjGqK9AsHaMDbtCxkMHH0Nv2HSFYBZ6ovtUSvAqldIOG0F59AqXA8iH4TPr7YpO19SRqXCsuA=
X-Received: by 2002:a19:7008:0:b0:4f2:7a54:346e with SMTP id
 h8-20020a197008000000b004f27a54346emr4509573lfc.44.1684257962958; Tue, 16 May
 2023 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230513220418.19357-6-kirill.shutemov@linux.intel.com> <20230516120646.31195-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230516120646.31195-1-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:25:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFoNTe3bPg6XHydJk8izcTrofEhH7Wpar1VwgpboEobmw@mail.gmail.com>
Message-ID: <CAMj1kXFoNTe3bPg6XHydJk8izcTrofEhH7Wpar1VwgpboEobmw@mail.gmail.com>
Subject: Re: [PATCHv11.1 5/9] efi: Add unaccepted memory support
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@intel.com, david@redhat.com,
        dfaggioli@suse.com, jroedel@suse.de, khalid.elmously@canonical.com,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        marcelo.cerri@canonical.com, mgorman@techsingularity.net,
        mingo@redhat.com, pbonzini@redhat.com, peterx@redhat.com,
        peterz@infradead.org, philip.cox@canonical.com,
        rientjes@google.com, rppt@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        tim.gardner@canonical.com, vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 May 2023 at 14:07, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> efi_config_parse_tables() reserves memory that holds unaccepted memory
> configuration table so it won't be reused by page allocator.
>
> Core-mm requires few helpers to support unaccepted memory:
>
>  - accept_memory() checks the range of addresses against the bitmap and
>    accept memory if needed.
>
>  - range_contains_unaccepted_memory() checks if anything within the
>    range requires acceptance.
>
> Architectural code has to provide efi_get_unaccepted_table() that
> returns pointer to the unaccepted memory configuration table.
>
> arch_accept_memory() handles arch-specific part of memory acceptance.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> v11.1:
>  - Add missing memblock_reserve() for the unaccepted memory
>    configuration table.
>
> ---
>  drivers/firmware/efi/Makefile            |   1 +
>  drivers/firmware/efi/efi.c               |  25 ++++++
>  drivers/firmware/efi/unaccepted_memory.c | 103 +++++++++++++++++++++++
>  include/linux/efi.h                      |   1 +
>  4 files changed, 130 insertions(+)
>  create mode 100644 drivers/firmware/efi/unaccepted_memory.c
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index b51f2a4c821e..e489fefd23da 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)      += capsule-loader.o
>  obj-$(CONFIG_EFI_EARLYCON)             += earlycon.o
>  obj-$(CONFIG_UEFI_CPER_ARM)            += cper-arm.o
>  obj-$(CONFIG_UEFI_CPER_X86)            += cper-x86.o
> +obj-$(CONFIG_UNACCEPTED_MEMORY)                += unaccepted_memory.o
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7dce06e419c5..d817e7afd266 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
>  #ifdef CONFIG_EFI_COCO_SECRET
>         .coco_secret            = EFI_INVALID_TABLE_ADDR,
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +       .unaccepted             = EFI_INVALID_TABLE_ADDR,
> +#endif
>  };
>  EXPORT_SYMBOL(efi);
>
> @@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>  #ifdef CONFIG_EFI_COCO_SECRET
>         {LINUX_EFI_COCO_SECRET_AREA_GUID,       &efi.coco_secret,       "CocoSecret"    },
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +       {LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,   &efi.unaccepted,        "Unaccepted"    },
> +#endif
>  #ifdef CONFIG_EFI_GENERIC_STUB
>         {LINUX_EFI_SCREEN_INFO_TABLE_GUID,      &screen_info_table                      },
>  #endif
> @@ -759,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> +           efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> +               struct efi_unaccepted_memory *unaccepted;
> +
> +               unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
> +               if (unaccepted) {
> +                       unsigned long size;
> +
> +                       if (unaccepted->version == 1) {
> +                               size = sizeof(*unaccepted) + unaccepted->size;
> +                               memblock_reserve(efi.unaccepted, size);
> +                       } else {
> +                               efi.unaccepted = EFI_INVALID_TABLE_ADDR;
> +                       }
> +
> +                       early_memunmap(unaccepted, sizeof(*unaccepted));
> +               }
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> new file mode 100644
> index 000000000000..bb91c41f76fb
> --- /dev/null
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <linux/memblock.h>
> +#include <linux/spinlock.h>
> +#include <asm/unaccepted_memory.h>
> +
> +/* Protects unaccepted memory bitmap */
> +static DEFINE_SPINLOCK(unaccepted_memory_lock);
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       struct efi_unaccepted_memory *unaccepted;
> +       unsigned long range_start, range_end;
> +       unsigned long flags;
> +       u64 unit_size;
> +
> +       if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
> +               return;
> +
> +       unaccepted = efi_get_unaccepted_table();
> +       if (!unaccepted)
> +               return;
> +
> +       unit_size = unaccepted->unit_size;
> +
> +       /*
> +        * Only care for the part of the range that is represented
> +        * in the bitmap.
> +        */
> +       if (start < unaccepted->phys_base)
> +               start = unaccepted->phys_base;
> +       if (end < unaccepted->phys_base)
> +               return;
> +
> +       /* Translate to offsets from the beginning of the bitmap */
> +       start -= unaccepted->phys_base;
> +       end -= unaccepted->phys_base;
> +
> +       /* Make sure not to overrun the bitmap */
> +       if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +               end = unaccepted->size * unit_size * BITS_PER_BYTE;
> +
> +       range_start = start / unit_size;
> +
> +       spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +       for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> +                                  DIV_ROUND_UP(end, unit_size)) {
> +               unsigned long phys_start, phys_end;
> +               unsigned long len = range_end - range_start;
> +
> +               phys_start = range_start * unit_size + unaccepted->phys_base;
> +               phys_end = range_end * unit_size + unaccepted->phys_base;
> +
> +               arch_accept_memory(phys_start, phys_end);
> +               bitmap_clear(unaccepted->bitmap, range_start, len);
> +       }
> +       spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}
> +
> +bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       struct efi_unaccepted_memory *unaccepted;
> +       unsigned long flags;
> +       bool ret = false;
> +       u64 unit_size;
> +
> +       unaccepted = efi_get_unaccepted_table();
> +       if (!unaccepted)
> +               return false;
> +
> +       unit_size = unaccepted->unit_size;
> +
> +       /*
> +        * Only care for the part of the range that is represented
> +        * in the bitmap.
> +        */
> +       if (start < unaccepted->phys_base)
> +               start = unaccepted->phys_base;
> +       if (end < unaccepted->phys_base)
> +               return false;
> +
> +       /* Translate to offsets from the beginning of the bitmap */
> +       start -= unaccepted->phys_base;
> +       end -= unaccepted->phys_base;
> +
> +       /* Make sure not to overrun the bitmap */
> +       if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +               end = unaccepted->size * unit_size * BITS_PER_BYTE;
> +
> +       spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +       while (start < end) {
> +               if (test_bit(start / unit_size, unaccepted->bitmap)) {
> +                       ret = true;
> +                       break;
> +               }
> +
> +               start += unit_size;
> +       }
> +       spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +       return ret;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 29cc622910da..9864f9c00da2 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -646,6 +646,7 @@ extern struct efi {
>         unsigned long                   tpm_final_log;          /* TPM2 Final Events Log table */
>         unsigned long                   mokvar_table;           /* MOK variable config table */
>         unsigned long                   coco_secret;            /* Confidential computing secret table */
> +       unsigned long                   unaccepted;             /* Unaccepted memory table */
>
>         efi_get_time_t                  *get_time;
>         efi_set_time_t                  *set_time;
> --
> 2.39.3
>
