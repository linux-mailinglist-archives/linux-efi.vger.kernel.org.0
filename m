Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E46FA111
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjEHHbt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjEHHbr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB81A49F;
        Mon,  8 May 2023 00:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A4E61AB3;
        Mon,  8 May 2023 07:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4234BC4339E;
        Mon,  8 May 2023 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531103;
        bh=ta0vub5XjOzQQ417e8iblal3NekaozYwNhO75CzHH1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fkTnobG1NIDgfxCWkqyfJ67NOlEdMAvnnmypLUc25cyKGnnE1RVsEifJryA5XdyFx
         WpFLS2sTdc+5BYD920I7gHTmAJ0di8NT1AnJmKTUEY1ADA9vnJrETKi/XW2mkdfxYQ
         0M/M8rQ3IpfcmV8P8JSvmkYeGXYTMxxn+9pFp26vz4GDSnP+UH4B0UmK/DjKnh+FV4
         rrBRJAh5cSaG3z7yFLSa9WqwqKlmrElIN4GQmwfXr8rd69lEr7sYZnRu0iwA8gRKTS
         0hBcHeRHQRV5M24ILkU8zzJJmeZ0gqLiW78mvhwkUT893onJ6cT+hVY+hQk31JeUsY
         LsNBo6gJmvONg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4efd6e26585so4693336e87.1;
        Mon, 08 May 2023 00:31:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDzTq2sKPjuNJr+nqcO+/HvbVyuobTExaxBxpwh/T2ahXXQSjzRN
        rEP5B+N+RgQKg/mjkxcmqI+z+bvzJEccb//Ump4=
X-Google-Smtp-Source: ACHHUZ5y7vA1tqWcne6emiRXv9HEK6nUTcGdP8LdbT0ZnVt6cAKzfTkXfRslaz3IMtMcQB05xvbksw36RX5AdY4j0Y4=
X-Received: by 2002:ac2:47e5:0:b0:4ef:ec94:9678 with SMTP id
 b5-20020ac247e5000000b004efec949678mr2695408lfp.20.1683531101267; Mon, 08 May
 2023 00:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com> <20230507234618.18067-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230507234618.18067-6-kirill.shutemov@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 May 2023 09:31:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGGeY8odrViZBb3aGmZ4FwaQ++ByTAesW2p5yZEk3cj_Q@mail.gmail.com>
Message-ID: <CAMj1kXGGeY8odrViZBb3aGmZ4FwaQ++ByTAesW2p5yZEk3cj_Q@mail.gmail.com>
Subject: Re: [PATCHv10 05/11] x86/boot/compressed: Handle unaccepted memory
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
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
> The firmware will pre-accept the memory used to run the stub. But, the
> stub is responsible for accepting the memory into which it decompresses
> the main kernel. Accept memory just before decompression starts.
>
> The stub is also responsible for choosing a physical address in which to
> place the decompressed kernel image. The KASLR mechanism will randomize
> this physical address. Since the unaccepted memory region is relatively
> small, KASLR would be quite ineffective if it only used the pre-accepted
> area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
> entire physical address space by also including EFI_UNACCEPTED_MEMORY.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/Makefile        |  2 +-
>  arch/x86/boot/compressed/efi.h           |  1 +
>  arch/x86/boot/compressed/kaslr.c         | 35 ++++++++++++++++--------
>  arch/x86/boot/compressed/mem.c           | 18 ++++++++++++
>  arch/x86/boot/compressed/misc.c          |  6 ++++
>  arch/x86/boot/compressed/misc.h          |  6 ++++
>  arch/x86/include/asm/unaccepted_memory.h |  2 ++
>  7 files changed, 57 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f62c02348f9a..74f7adee46ad 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,7 +107,7 @@ endif
>
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/find.o $(obj)/mem.o
>
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index 7db2f41b54cd..cf475243b6d5 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -32,6 +32,7 @@ typedef       struct {
>  } efi_table_hdr_t;
>
>  #define EFI_CONVENTIONAL_MEMORY                 7
> +#define EFI_UNACCEPTED_MEMORY          15
>
>  #define EFI_MEMORY_MORE_RELIABLE \
>                                 ((u64)0x0000000000010000ULL)    /* higher reliability */
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 454757fbdfe5..749f0fe7e446 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
>  }
>
>  #ifdef CONFIG_EFI
> +
> +/*
> + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
> + * guaranteed to be free.
> + *
> + * It is more conservative in picking free memory than the EFI spec allows:
> + *
> + * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
> + * and thus available to place the kernel image into, but in practice there's
> + * firmware where using that memory leads to crashes.
> + */
> +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> +{
> +       if (md->type == EFI_CONVENTIONAL_MEMORY)
> +               return true;
> +
> +       if (md->type == EFI_UNACCEPTED_MEMORY)
> +               return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);
> +
> +       return false;
> +}
> +
>  /*
>   * Returns true if we processed the EFI memmap, which we prefer over the E820
>   * table if it is available.
> @@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>         for (i = 0; i < nr_desc; i++) {
>                 md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
>
> -               /*
> -                * Here we are more conservative in picking free memory than
> -                * the EFI spec allows:
> -                *
> -                * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
> -                * free memory and thus available to place the kernel image into,
> -                * but in practice there's firmware where using that memory leads
> -                * to crashes.
> -                *
> -                * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> -                */
> -               if (md->type != EFI_CONVENTIONAL_MEMORY)
> +               if (!memory_type_is_free(md))
>                         continue;
>
>                 if (efi_soft_reserve_enabled() &&
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index 6b15a0ed8b54..de858a5180b6 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -3,12 +3,15 @@
>  #include "../cpuflags.h"
>  #include "bitmap.h"
>  #include "error.h"
> +#include "find.h"
>  #include "math.h"
>
>  #define PMD_SHIFT      21
>  #define PMD_SIZE       (_AC(1, UL) << PMD_SHIFT)
>  #define PMD_MASK       (~(PMD_SIZE - 1))
>
> +extern struct boot_params *boot_params;
> +
>  static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>         /* Platform-specific memory-acceptance call goes here */
> @@ -71,3 +74,18 @@ void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
>         bitmap_set((unsigned long *)params->unaccepted_memory,
>                    start / PMD_SIZE, (end - start) / PMD_SIZE);
>  }
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       unsigned long range_start, range_end;
> +       unsigned long *bitmap, bitmap_size;
> +
> +       bitmap = (unsigned long *)boot_params->unaccepted_memory;
> +       range_start = start / PMD_SIZE;
> +       bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
> +
> +       for_each_set_bitrange_from(range_start, range_end, bitmap, bitmap_size) {
> +               __accept_memory(range_start * PMD_SIZE, range_end * PMD_SIZE);
> +               bitmap_clear(bitmap, range_start, range_end - range_start);
> +       }
> +}
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 014ff222bf4b..186bfd53e042 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  #endif
>
>         debug_putstr("\nDecompressing Linux... ");
> +
> +       if (boot_params->unaccepted_memory) {
> +               debug_putstr("Accepting memory... ");
> +               accept_memory(__pa(output), __pa(output) + needed_size);
> +       }
> +
>         __decompress(input_data, input_len, NULL, NULL, output, output_len,
>                         NULL, error);
>         entry_offset = parse_elf(output);
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 2f155a0e3041..9663d1839f54 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -247,4 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
>  }
>  #endif /* CONFIG_EFI */
>
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +#else
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
> +#endif
> +
>  #endif /* BOOT_COMPRESSED_MISC_H */
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> index df0736d32858..41fbfc798100 100644
> --- a/arch/x86/include/asm/unaccepted_memory.h
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -7,4 +7,6 @@ struct boot_params;
>
>  void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
>
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +
>  #endif
> --
> 2.39.3
>
