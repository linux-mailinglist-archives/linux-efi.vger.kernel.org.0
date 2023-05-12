Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE770019C
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjELHjw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbjELHjt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 03:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF133C38;
        Fri, 12 May 2023 00:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA44865372;
        Fri, 12 May 2023 07:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E530AC4339C;
        Fri, 12 May 2023 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683877185;
        bh=SOSiG/5UO2Fw3lhsOg/yYj3s5KRC90ttiiE+OeCwIcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qKejPmHIqUx7PwfxIp+i6OSbpENnMkhZw3ZVL+ZXR1anhDlVSfWHnycTN8e0/8uz7
         +RXO8NoWuoC4ebRIkihDDfUMOISJFXlCvfirO5vK81xnY+VyDQ8UebgmOVdWbTndu2
         Fegura6U+f54oGA7cKERxVE9ScdUh/WuDsCvC5+mVieMheTSQt2BhOONy82wDpNfiQ
         ZIP5TYza/lsSZ+QqTqTdpLj8joVIUzAFtxX5lod+rOWKXo6Gb0/+wHF2K5p8r8bDiv
         rSgTC/lNCsAy2k7E+du6ZyEpZD0FqsT9pP+nZzO3zqd8HCyqrr2n7ZWJUD+7DmENF9
         jDYTA2PzhfdOg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so11192787e87.3;
        Fri, 12 May 2023 00:39:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDz201/nVWqgoybvkWblg8iaC0dpuAsJ0yoXSN/OKydaQ9ojiioL
        X8G0LaVNWibUTjZyXC3iwEYo1RJq1SISIFV1qoo=
X-Google-Smtp-Source: ACHHUZ6O9ieQ1Q94U+8VjP3YpYSDkCJhIA/IUCIqhNoBRzc7+nQpYsyCaqrla7yE/zA4/ZKfIINzfAs9J3/xswyYRuw=
X-Received: by 2002:ac2:4a7a:0:b0:4ee:d8f3:1390 with SMTP id
 q26-20020ac24a7a000000b004eed8f31390mr3116067lfp.53.1683877182728; Fri, 12
 May 2023 00:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com> <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name> <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
 <20230509005634.qtuiodpirexbxu2k@box.shutemov.name> <CAMj1kXGZ4j7nShGPoJzTZNa4NDvHnj_arY8XDXzW8cd6G==8Jg@mail.gmail.com>
 <20230512015909.2fj7bmp3ejc3owhs@box.shutemov.name>
In-Reply-To: <20230512015909.2fj7bmp3ejc3owhs@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 09:39:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHY-uWWgWjv-7wLkKoh9pvgCbEkxHiCBbJa1wt53g5wYg@mail.gmail.com>
Message-ID: <CAMj1kXHY-uWWgWjv-7wLkKoh9pvgCbEkxHiCBbJa1wt53g5wYg@mail.gmail.com>
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 12 May 2023 at 03:59, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, May 09, 2023 at 08:47:38AM +0200, Ard Biesheuvel wrote:
> > On Tue, 9 May 2023 at 02:56, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Tue, May 09, 2023 at 12:11:41AM +0200, Ard Biesheuvel wrote:
> > > > > @@ -1324,13 +1325,15 @@ void __init e820__memblock_setup(void)
> > > > >          * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
> > > > >          * used to get correct RAM size.
> > > > >          */
> > > > > -       if (boot_params.unaccepted_memory) {
> > > > > +       if (efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> > > > > +               struct efi_unaccepted_memory *unaccepted;
> > > > >                 unsigned long size;
> > > > >
> > > > > -               /* One bit per 2MB */
> > > > > -               size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > > > > -                                   PMD_SIZE * BITS_PER_BYTE);
> > > > > -               memblock_reserve(boot_params.unaccepted_memory, size);
> > > > > +               unaccepted = __va(efi.unaccepted);
> > > > > +
> > > > > +               size = sizeof(struct efi_unaccepted_memory);
> > > > > +               size += unaccepted->size;
> > > > > +               memblock_reserve(efi.unaccepted, size);
> > > > >         }
> > > > >
> > > >
> > > > This could be moved to generic code (but we'll need to use early_memremap())
> > >
> > > I don't understand why early_memremap() is needed. EFI_LOADER_DATA already
> > > mapped into direct mapping. We only need to reserve the memory so it
> > > could not be reallocated for other things. Hm?
> > >
> >
> > *If* we move this to generic code, we have to ensure that we don't
> > rely on x86 specific semantics. When parsing the EFI configuration
> > tables, other architectures don't have a complete direct map yet, as
> > they receive the memory description from EFI not from a translated
> > E820 map.
> >
> > Note that this is only for getting the size of the reservation. Later
> > on, when we actually consume the contents of the bitmap, generic or
> > non-x86 code will need to use the ordinary memremap() API to map this
> > memory, and this amounts to a __va() call when the memory is already
> > mapped. But I am not suggesting changing that part for this series.
> > And even the hunk above can remain as you suggest - we can revisit it
> > once other architectures gain support for this.
> >
> > The main thing I would like to avoid at this point in time is to add
> > new fields to struct bootparams that loaders such as GRUB may start to
> > populate as well - I don't think there is a very strong case for
> > pseudo-EFI boot [where GRUB calls ExitBootServices()] on confidential
> > VMs (as it prevents the EFI stub and the kernel from accessing the
> > measurement and attestation APIs), but let's not create more struct
> > bootparams based API if we can avoid it.
>
> Below is updated version of the fixup. I believed I addressed all your
> feedback.
>
> I moved most of unaccepted memory code into generic EFI and EFI stub. I
> hope it looks fine.
>

Yes this looks excellent. I left some comments below, primarily about
the use of PMD_SIZE and the version field, but other than that, this
looks ready to go.

> early_memremap() for reservation works fine, but when I tried to use
> memremap() as you suggested to get the mapping of the table instead of
> __va() it failed. I didn't found the root cause. I guess I tried to use
> too early for memremap() to be functional. I made arch provide
> arch-specific way to get the mapping, which is implemented as __va() on
> x86.
>

Fair enough - we'll cross that bridge when we have to.

> While I move code from decompressor to the EFI stub, I removed few headers
> as, it *seems*, EFI stub has different policy about re-using headers from
> the main kernel image.
>
> Borislav, is it okay with you or EFI stub also has to carry own copy of
> the headers?
>

I'd prefer to avoid that - I'm not familiar with the motivation behind
this, but I don't remember any issues with the EFI stub that would
justify this.

> If everything is fine, I will fold the fixup properly and prepare v11 of
> the patchset.
>

That works for me. I'll coordinate with Boris on how to merge this.



>  Documentation/arch/x86/zero-page.rst             |   1 -
>  arch/x86/boot/bitops.h                           |  40 ----
>  arch/x86/boot/compressed/Makefile                |   2 +-
>  arch/x86/boot/compressed/bitmap.c                |  43 -----
>  arch/x86/boot/compressed/bitmap.h                |  49 -----
>  arch/x86/boot/compressed/bits.h                  |  36 ----
>  arch/x86/boot/compressed/find.c                  |  54 ------
>  arch/x86/boot/compressed/find.h                  |  79 --------
>  arch/x86/boot/compressed/math.h                  |  37 ----
>  arch/x86/boot/compressed/mem.c                   |  81 +--------
>  arch/x86/boot/compressed/minmax.h                |  61 -------
>  arch/x86/boot/compressed/misc.c                  |   2 +-
>  arch/x86/include/asm/page.h                      |   2 -
>  arch/x86/include/asm/unaccepted_memory.h         |  24 ++-
>  arch/x86/include/uapi/asm/bootparam.h            |   2 +-
>  arch/x86/kernel/e820.c                           |  17 --
>  arch/x86/mm/Makefile                             |   2 -
>  arch/x86/mm/unaccepted_memory.c                  | 101 -----------
>  drivers/firmware/efi/Makefile                    |   1 +
>  drivers/firmware/efi/efi.c                       |  25 +++
>  drivers/firmware/efi/libstub/Makefile            |   2 +
>  drivers/firmware/efi/libstub/efistub.h           |   6 +
>  drivers/firmware/efi/libstub/find.c              |  43 +++++
>  drivers/firmware/efi/libstub/unaccepted_memory.c | 221 +++++++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c          |  62 +------
>  drivers/firmware/efi/unaccepted_memory.c         | 138 ++++++++++++++
>  include/linux/efi.h                              |  12 ++
>  mm/internal.h                                    |   9 +-
>  28 files changed, 480 insertions(+), 672 deletions(-)
>
...
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
> index 7dce06e419c5..bddb5aeb0d12 100644
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
> +                       if (unaccepted->version == 0) {
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
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 3abb2b357482..a09edfbd7cfc 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -96,6 +96,8 @@ CFLAGS_arm32-stub.o           := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  zboot-obj-$(CONFIG_RISCV)      := lib-clz_ctz.o lib-ashldi3.o
>  lib-$(CONFIG_EFI_ZBOOT)                += zboot.o $(zboot-obj-y)
>
> +lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o find.o
> +
>  extra-y                                := $(lib-y)
>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d5a20802e0..8659a01664b8 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1133,4 +1133,10 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
>  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>                      unsigned long code_size);
>
> +efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> +                                       struct efi_boot_memmap *map);
> +void process_unaccepted_memory(u64 start, u64 end);
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +void arch_accept_memory(phys_addr_t start, phys_addr_t end);
> +
>  #endif
> diff --git a/drivers/firmware/efi/libstub/find.c b/drivers/firmware/efi/libstub/find.c
> new file mode 100644
> index 000000000000..4e7740d28987
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/find.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/bitmap.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +
> +/*
> + * Common helper for find_next_bit() function family
> + * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
> + * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
> + * @size: The bitmap size in bits
> + * @start: The bitnumber to start searching at
> + */
> +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)                               \
> +({                                                                             \
> +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> +                                                                               \
> +       if (unlikely(__start >= sz))                                            \
> +               goto out;                                                       \
> +                                                                               \
> +       mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));                          \
> +       idx = __start / BITS_PER_LONG;                                          \
> +                                                                               \
> +       for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {                       \
> +               if ((idx + 1) * BITS_PER_LONG >= sz)                            \
> +                       goto out;                                               \
> +               idx++;                                                          \
> +       }                                                                       \
> +                                                                               \
> +       sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);                  \
> +out:                                                                           \
> +       sz;                                                                     \
> +})
> +
> +unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
> +{
> +       return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> +}
> +
> +unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
> +                                        unsigned long start)
> +{
> +       return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
> +}
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> new file mode 100644
> index 000000000000..6c19d8fa563e
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include "efistub.h"
> +
> +static struct efi_unaccepted_memory *unaccepted_table;
> +
> +efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> +                                       struct efi_boot_memmap *map)
> +{
> +       efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +       u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
> +       efi_status_t status;
> +       int i;
> +
> +       /* Check if the table is already installed */
> +       unaccepted_table = get_efi_config_table(unaccepted_table_guid);
> +       if (unaccepted_table) {
> +               if (unaccepted_table->version != 0) {
> +                       efi_err("Unknown version of unaccepted memory tatble\n");

Typo ^^^

Also, can we start with version 1 rather than 0? That way, we can spot
the difference between a valid table and memory that has been cleared
inadvertently.


> +                       return EFI_UNSUPPORTED;
> +               }
> +               return EFI_SUCCESS;
> +       }
> +
> +       /* Check if there's any unaccepted memory and find the max address */
> +       for (i = 0; i < nr_desc; i++) {
> +               efi_memory_desc_t *d;
> +               unsigned long m = (unsigned long)map->map;
> +
> +               d = efi_early_memdesc_ptr(m, map->desc_size, i);
> +               if (d->type != EFI_UNACCEPTED_MEMORY)
> +                       continue;
> +
> +               unaccepted_start = min(unaccepted_start, d->phys_addr);
> +               unaccepted_end = max(unaccepted_end,
> +                                    d->phys_addr + d->num_pages * PAGE_SIZE);
> +       }
> +
> +       if (unaccepted_start == ULLONG_MAX)
> +               return EFI_SUCCESS;
> +
> +       unaccepted_start = round_down(unaccepted_start, PMD_SIZE);
> +       unaccepted_end = round_up(unaccepted_end, PMD_SIZE);
> +

Please replace PMD_SIZE with something along the lines of
EFI_UNACCEPTED_UNIT_SIZE and #define it to PMD_SIZE in
arch/x86/include/asm/efi.h.

The comment below about the size of the bitmap vs the size of the
address space should probably move there as well.

> +       /*
> +        * If unaccepted memory is present, allocate a bitmap to track what
> +        * memory has to be accepted before access.
> +        *
> +        * One bit in the bitmap represents 2MiB in the address space:
> +        * A 4k bitmap can track 64GiB of physical address space.
> +        *
> +        * In the worst case scenario -- a huge hole in the middle of the
> +        * address space -- It needs 256MiB to handle 4PiB of the address
> +        * space.
> +        *
> +        * The bitmap will be populated in setup_e820() according to the memory
> +        * map after efi_exit_boot_services().
> +        */
> +       bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
> +                                  PMD_SIZE * BITS_PER_BYTE);

PMD_SIZE ^^^

> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +                            sizeof(*unaccepted_table) + bitmap_size,
> +                            (void **)&unaccepted_table);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to allocate unaccepted memory config table\n");
> +               return status;
> +       }
> +
> +       unaccepted_table->version = 0;
> +       unaccepted_table->unit_size = PMD_SIZE;

And here

> +       unaccepted_table->phys_base = unaccepted_start;
> +       unaccepted_table->size = bitmap_size;
> +       memset(unaccepted_table->bitmap, 0, bitmap_size);
> +
> +       status = efi_bs_call(install_configuration_table,
> +                            &unaccepted_table_guid, unaccepted_table);
> +       if (status != EFI_SUCCESS) {
> +               efi_bs_call(free_pool, unaccepted_table);
> +               efi_err("Failed to install unaccepted memory config table!\n");
> +       }
> +
> +       return status;
> +}
> +
> +/*
> + * The accepted memory bitmap only works at PMD_SIZE granularity.  Take
> + * unaligned start/end addresses and either:
> + *  1. Accepts the memory immediately and in its entirety
> + *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
> + *
> + * The function will never reach the bitmap_set() with zero bits to set.
> + */
> +void process_unaccepted_memory(u64 start, u64 end)
> +{
> +       u64 unit_size = unaccepted_table->unit_size;
> +       u64 unit_mask = unaccepted_table->unit_size - 1;
> +       u64 bitmap_size = unaccepted_table->size;
> +
> +       /*
> +        * Ensure that at least one bit will be set in the bitmap by
> +        * immediately accepting all regions under 2*unit_size.  This is
> +        * imprecise and may immediately accept some areas that could
> +        * have been represented in the bitmap.  But, results in simpler
> +        * code below
> +        *
> +        * Consider case like this (assuming unit_size == 2MB):
> +        *
> +        * | 4k | 2044k |    2048k   |
> +        * ^ 0x0        ^ 2MB        ^ 4MB
> +        *
> +        * Only the first 4k has been accepted. The 0MB->2MB region can not be
> +        * represented in the bitmap. The 2MB->4MB region can be represented in
> +        * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
> +        * immediately accepted in its entirety.
> +        */
> +       if (end - start < 2 * unit_size) {
> +               arch_accept_memory(start, end);
> +               return;
> +       }
> +
> +       /*
> +        * No matter how the start and end are aligned, at least one unaccepted
> +        * unit_size area will remain to be marked in the bitmap.
> +        */
> +
> +       /* Immediately accept a <unit_size piece at the start: */
> +       if (start & unit_mask) {
> +               arch_accept_memory(start, round_up(start, unit_size));
> +               start = round_up(start, unit_size);
> +       }
> +
> +       /* Immediately accept a <unit_size piece at the end: */
> +       if (end & unit_mask) {
> +               arch_accept_memory(round_down(end, unit_size), end);
> +               end = round_down(end, unit_size);
> +       }
> +
> +       /*
> +        * Accept part of the range that before phys_base and cannot be recorded
> +        * into the bitmap.
> +        */
> +       if (start < unaccepted_table->phys_base) {
> +               arch_accept_memory(start,
> +                                  min(unaccepted_table->phys_base, end));
> +               start = unaccepted_table->phys_base;
> +       }
> +
> +       /* Nothing to record */
> +       if (end < unaccepted_table->phys_base)
> +               return;
> +
> +       /* Translate to offsets from the beginning of the bitmap */
> +       start -= unaccepted_table->phys_base;
> +       end -= unaccepted_table->phys_base;
> +
> +       /* Accept memory that doesn't fit into bitmap */
> +       if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
> +               unsigned long phys_start, phys_end;
> +
> +               phys_start = bitmap_size * unit_size * BITS_PER_BYTE +
> +                            unaccepted_table->phys_base;
> +               phys_end = end + unaccepted_table->phys_base;
> +
> +               arch_accept_memory(phys_start, phys_end);
> +               end = bitmap_size * unit_size * BITS_PER_BYTE;
> +       }
> +
> +       /*
> +        * 'start' and 'end' are now both unit_size-aligned.
> +        * Record the range as being unaccepted:
> +        */
> +       bitmap_set(unaccepted_table->bitmap,
> +                  start / unit_size, (end - start) / unit_size);
> +}
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       unsigned long range_start, range_end;
> +       unsigned long bitmap_size;
> +       u64 unit_size;
> +
> +       if (!unaccepted_table)
> +               return;
> +
> +       unit_size = unaccepted_table->unit_size;
> +
> +       /*
> +        * Only care for the part of the range that is represented
> +        * in the bitmap.
> +        */
> +       if (start < unaccepted_table->phys_base)
> +               start = unaccepted_table->phys_base;
> +       if (end < unaccepted_table->phys_base)
> +               return;
> +
> +       /* Translate to offsets from the beginning of the bitmap */
> +       start -= unaccepted_table->phys_base;
> +       end -= unaccepted_table->phys_base;
> +
> +       /* Make sure not to overrun the bitmap */
> +       if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
> +               end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
> +

Should we warn here?


> +       range_start = start / unit_size;
> +       bitmap_size = DIV_ROUND_UP(end, unit_size);
> +
> +       for_each_set_bitrange_from(range_start, range_end,
> +                                  unaccepted_table->bitmap, bitmap_size) {
> +               unsigned long phys_start, phys_end;
> +
> +               phys_start = range_start * unit_size + unaccepted_table->phys_base;
> +               phys_end = range_end * unit_size + unaccepted_table->phys_base;
> +
> +               arch_accept_memory(phys_start, phys_end);
> +               bitmap_clear(unaccepted_table->bitmap,
> +                            range_start, range_end - range_start);
> +       }
> +}
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1afe7b5b02e1..16ea5e76907f 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -621,7 +621,7 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>                                 continue;
>                         }
>                         e820_type = E820_TYPE_RAM;
> -                       process_unaccepted_memory(params, d->phys_addr,
> +                       process_unaccepted_memory(d->phys_addr,
>                                                   d->phys_addr + PAGE_SIZE * d->num_pages);
>                         break;
>                 default:
> @@ -688,64 +688,6 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
>         return status;
>  }
>
> -static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
> -                                              __u32 nr_desc,
> -                                              struct efi_boot_memmap *map)
> -{
> -       unsigned long *mem = NULL;
> -       u64 size, max_addr = 0;
> -       efi_status_t status;
> -       bool found = false;
> -       int i;
> -
> -       /* Check if there's any unaccepted memory and find the max address */
> -       for (i = 0; i < nr_desc; i++) {
> -               efi_memory_desc_t *d;
> -               unsigned long m = (unsigned long)map->map;
> -
> -               d = efi_early_memdesc_ptr(m, map->desc_size, i);
> -               if (d->type == EFI_UNACCEPTED_MEMORY)
> -                       found = true;
> -               if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> -                       max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> -       }
> -
> -       if (!found) {
> -               params->unaccepted_memory = 0;
> -               return EFI_SUCCESS;
> -       }
> -
> -       /*
> -        * range_contains_unaccepted_memory() may need to check one 2M chunk
> -        * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
> -        * sure that the bitmap is large enough handle it.
> -        */
> -       max_addr += PMD_SIZE;
> -
> -       /*
> -        * If unaccepted memory is present, allocate a bitmap to track what
> -        * memory has to be accepted before access.
> -        *
> -        * One bit in the bitmap represents 2MiB in the address space:
> -        * A 4k bitmap can track 64GiB of physical address space.
> -        *
> -        * In the worst case scenario -- a huge hole in the middle of the
> -        * address space -- It needs 256MiB to handle 4PiB of the address
> -        * space.
> -        *
> -        * The bitmap will be populated in setup_e820() according to the memory
> -        * map after efi_exit_boot_services().
> -        */
> -       size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> -       status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
> -       if (status == EFI_SUCCESS) {
> -               memset(mem, 0, size);
> -               params->unaccepted_memory = (unsigned long)mem;
> -       }
> -
> -       return status;
> -}
> -
>  static efi_status_t allocate_e820(struct boot_params *params,
>                                   struct setup_data **e820ext,
>                                   u32 *e820ext_size)
> @@ -767,7 +709,7 @@ static efi_status_t allocate_e820(struct boot_params *params,
>         }
>
>         if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
> -               status = allocate_unaccepted_bitmap(params, nr_desc, map);
> +               status = allocate_unaccepted_bitmap(nr_desc, map);
>
>         efi_bs_call(free_pool, map);
>         return status;
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> new file mode 100644
> index 000000000000..3d1ca60916dd
> --- /dev/null
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -0,0 +1,138 @@
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
> +       /*
> +        * load_unaligned_zeropad() can lead to unwanted loads across page
> +        * boundaries. The unwanted loads are typically harmless. But, they
> +        * might be made to totally unrelated or even unmapped memory.
> +        * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
> +        * #VE) to recover from these unwanted loads.
> +        *
> +        * But, this approach does not work for unaccepted memory. For TDX, a
> +        * load from unaccepted memory will not lead to a recoverable exception
> +        * within the guest. The guest will exit to the VMM where the only
> +        * recourse is to terminate the guest.
> +        *
> +        * There are two parts to fix this issue and comprehensively avoid
> +        * access to unaccepted memory. Together these ensure that an extra
> +        * "guard" page is accepted in addition to the memory that needs to be
> +        * used:
> +        *
> +        * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> +        *    checks up to end+unit_size if 'end' is aligned on a unit_size
> +        *    boundary.
> +        *
> +        * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
> +        *    'end' is aligned on a unit_size boundary. (immediately following
> +        *    this comment)
> +        */
> +       if (!(end % unit_size))
> +               end += unit_size;
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
> +       /*
> +        * Also consider the unaccepted state of the *next* page. See fix #1 in
> +        * the comment on load_unaligned_zeropad() in accept_memory().
> +        */
> +       if (!(end % unit_size))
> +               end += unit_size;
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
> index efbe14641638..0f4620060ed8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -418,6 +418,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID      EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
>  #define LINUX_EFI_COCO_SECRET_AREA_GUID                EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>  #define LINUX_EFI_BOOT_MEMMAP_GUID             EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> +#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID    EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
>
>  #define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>
> @@ -535,6 +536,16 @@ struct efi_boot_memmap {
>         efi_memory_desc_t       map[];
>  };
>
> +struct efi_unaccepted_memory {
> +       u32 version;
> +       u32 unit_size;
> +       u64 phys_base;
> +       u64 size;
> +       unsigned long bitmap[];
> +};
> +
> +void __init efi_unaccepted_table_init(void);
> +
>  /*
>   * Architecture independent structure for describing a memory map for the
>   * benefit of efi_memmap_init_early(), and for passing context between
> @@ -637,6 +648,7 @@ extern struct efi {
>         unsigned long                   tpm_final_log;          /* TPM2 Final Events Log table */
>         unsigned long                   mokvar_table;           /* MOK variable config table */
>         unsigned long                   coco_secret;            /* Confidential computing secret table */
> +       unsigned long                   unaccepted;             /* Unaccepted memory table */
>
>         efi_get_time_t                  *get_time;
>         efi_set_time_t                  *set_time;
> diff --git a/mm/internal.h b/mm/internal.h
> index ed042e366d49..2e70f22d1b3f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1100,7 +1100,13 @@ struct vma_prepare {
>         struct vm_area_struct *remove2;
>  };
>
> -#ifndef CONFIG_UNACCEPTED_MEMORY
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +
> +bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +
> +#else
> +
>  static inline bool range_contains_unaccepted_memory(phys_addr_t start,
>                                                     phys_addr_t end)
>  {
> @@ -1110,6 +1116,7 @@ static inline bool range_contains_unaccepted_memory(phys_addr_t start,
>  static inline void accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  }
> +
>  #endif
>
>  #endif /* __MM_INTERNAL_H */
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
