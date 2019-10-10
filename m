Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82D1D2148
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 09:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfJJHCF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 03:02:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36401 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfJJHCF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 03:02:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so5482418wmc.1
        for <linux-efi@vger.kernel.org>; Thu, 10 Oct 2019 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dwWpB0VeJDrUWncAO9XEt6CLkOt4d9BmzYibkejxqc=;
        b=zw8zvAH2poJI6y12d3PeAgePxG0yoDdunggoXWMUfC9djEzUfir7TO1FutGwVesrGs
         P1iUt2IPbYIDooCrHVlMU3+cr/4LvV+qpcnsXChtAShVxlIYGbC5GNmPVKkPdHCt3PEQ
         JyJzfUDBVwoJLfE8sTXoPkuWDCsqaeJ86PKESmL7vxWiGmQ9Xt92s9Yllz+vFEND0pJ5
         e84tUXSCJ800zC5LEpfZkMpTEBMRZicDDymChe7zRKv/psuA+t9uEHPjN0tn/9HtZ4Hf
         tPH0nI1DP3Rl+64pq9dfdSvPhm3C7cNbgiLtnI9t03/3Y8ZzOHfD7D7KHF+gIDAJlQNt
         3row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dwWpB0VeJDrUWncAO9XEt6CLkOt4d9BmzYibkejxqc=;
        b=XiFkiAPbvjk6nHzyDtiXgZz+QPU59gZ4+4uUBnaHVvbSsCVaPW6LnLyjLzW8k0/z3A
         963TsDR7NnIqmS+xT85hBsPMqlf1NlT/6L1YVuRk3fNcWyTVYCJMrSpdaIvUyQqyOgrX
         rWCP++dY/Mt1o9h4IcGA5A5iX0F/Psv+S5ubICPRiY5E8azmFJDgEZF6I+osUIH3l0W1
         TBVqbvE4u23EDRK27UgwAKU5zKSlwUtCk7f3tm1Ypa4/xqudLGcFP4ihQy/PdqnjIRXe
         BosJoXpcQeYS/nGsimjJzLtonGAjFKe147tWdhML68H2fdUmGxa0tcfbTJ9CySGNlWn6
         ANSg==
X-Gm-Message-State: APjAAAWH3rxKVOdoEfUVvg+/kR3FpIFMTaO72QH2sZKtwwh/C1oZ28f3
        CBAU9+PrRSCJrSqvEDb23uOVpsd+GTHN78NAyeYVAQ==
X-Google-Smtp-Source: APXvYqxbnlzXpnNtKe4bbifDs/bBZqGhmlWfl63btw+8LmVpIG+xwIXkYkd8JCwB48fGJYWJHedMyN21jQb69RRBXTA=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr6424648wml.10.1570690921445;
 Thu, 10 Oct 2019 00:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066231436.1059972.14633230333322624569.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066231436.1059972.14633230333322624569.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 10 Oct 2019 09:01:48 +0200
Message-ID: <CAKv+Gu-yM+QfzUjcVNe1UzW7w2A_nEazPkWRYJ93jEepGx36Cg@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] x86/efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Given that EFI_MEMORY_SP is platform BIOS policy decision for marking
> memory ranges as "reserved for a specific purpose" there will inevitably
> be scenarios where the BIOS omits the attribute in situations where it
> is desired. Unlike other attributes if the OS wants to reserve this
> memory from the kernel the reservation needs to happen early in init. So
> early, in fact, that it needs to happen before e820__memblock_setup()
> which is a pre-requisite for efi_fake_memmap() that wants to allocate
> memory for the updated table.
>
> Introduce an x86 specific efi_fake_memmap_early() that can search for
> attempts to set EFI_MEMORY_SP via efi_fake_mem and update the e820 table
> accordingly.
>
> The KASLR code that scans the command line looking for user-directed
> memory reservations also needs to be updated to consider
> "efi_fake_mem=nn@ss:0x40000" requests.
>
> Cc: <x86@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |   10 +++
>  arch/x86/boot/compressed/kaslr.c                |   42 ++++++++++++--
>  arch/x86/include/asm/efi.h                      |    8 +++
>  arch/x86/platform/efi/efi.c                     |    2 +
>  drivers/firmware/efi/Makefile                   |    5 +-
>  drivers/firmware/efi/fake_mem.c                 |   24 ++++----
>  drivers/firmware/efi/fake_mem.h                 |   10 +++
>  drivers/firmware/efi/x86_fake_mem.c             |   69 +++++++++++++++++++++++
>  8 files changed, 147 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/firmware/efi/fake_mem.h
>  create mode 100644 drivers/firmware/efi/x86_fake_mem.c
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 47478a730011..9489d76b0e9f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1196,15 +1196,21 @@
>                         updating original EFI memory map.
>                         Region of memory which aa attribute is added to is
>                         from ss to ss+nn.
> +
>                         If efi_fake_mem=2G@4G:0x10000,2G@0x10a0000000:0x10000
>                         is specified, EFI_MEMORY_MORE_RELIABLE(0x10000)
>                         attribute is added to range 0x100000000-0x180000000 and
>                         0x10a0000000-0x1120000000.
>
> +                       If efi_fake_mem=8G@9G:0x40000 is specified, the
> +                       EFI_MEMORY_SP(0x40000) attribute is added to
> +                       range 0x240000000-0x43fffffff.
> +
>                         Using this parameter you can do debugging of EFI memmap
> -                       related feature. For example, you can do debugging of
> +                       related features. For example, you can do debugging of
>                         Address Range Mirroring feature even if your box
> -                       doesn't support it.
> +                       doesn't support it, or mark specific memory as
> +                       "soft reserved".
>
>         efivar_ssdt=    [EFI; X86] Name of an EFI variable that contains an SSDT
>                         that is to be dynamically loaded by Linux. If there are
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index ff6fa81949cd..da0eedd5635d 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -132,8 +132,14 @@ char *skip_spaces(const char *str)
>  #include "../../../../lib/ctype.c"
>  #include "../../../../lib/cmdline.c"
>
> +enum parse_mode {
> +       PARSE_MEMMAP,
> +       PARSE_EFI,
> +};
> +
>  static int
> -parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
> +parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
> +               enum parse_mode mode)
>  {
>         char *oldp;
>
> @@ -156,8 +162,29 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
>                 *start = memparse(p + 1, &p);
>                 return 0;
>         case '@':
> -               /* memmap=nn@ss specifies usable region, should be skipped */
> -               *size = 0;
> +               if (mode == PARSE_MEMMAP) {
> +                       /*
> +                        * memmap=nn@ss specifies usable region, should
> +                        * be skipped
> +                        */
> +                       *size = 0;
> +               } else {
> +                       unsigned long long flags;
> +
> +                       /*
> +                        * efi_fake_mem=nn@ss:attr the attr specifies
> +                        * flags that might imply a soft-reservation.
> +                        */
> +                       *start = memparse(p + 1, &p);
> +                       if (p && *p == ':') {
> +                               p++;
> +                               if (kstrtoull(p, 0, &flags) < 0)
> +                                       *size = 0;
> +                               else if (flags & EFI_MEMORY_SP)
> +                                       return 0;
> +                       }
> +                       *size = 0;
> +               }
>                 /* Fall through */
>         default:
>                 /*
> @@ -172,7 +199,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
>         return -EINVAL;
>  }
>
> -static void mem_avoid_memmap(char *str)
> +static void mem_avoid_memmap(enum parse_mode mode, char *str)
>  {
>         static int i;
>
> @@ -187,7 +214,7 @@ static void mem_avoid_memmap(char *str)
>                 if (k)
>                         *k++ = 0;
>
> -               rc = parse_memmap(str, &start, &size);
> +               rc = parse_memmap(str, &start, &size, mode);
>                 if (rc < 0)
>                         break;
>                 str = k;
> @@ -238,7 +265,6 @@ static void parse_gb_huge_pages(char *param, char *val)
>         }
>  }
>
> -
>  static void handle_mem_options(void)
>  {
>         char *args = (char *)get_cmd_line_ptr();
> @@ -271,7 +297,7 @@ static void handle_mem_options(void)
>                 }
>
>                 if (!strcmp(param, "memmap")) {
> -                       mem_avoid_memmap(val);
> +                       mem_avoid_memmap(PARSE_MEMMAP, val);
>                 } else if (strstr(param, "hugepages")) {
>                         parse_gb_huge_pages(param, val);
>                 } else if (!strcmp(param, "mem")) {
> @@ -284,6 +310,8 @@ static void handle_mem_options(void)
>                                 goto out;
>
>                         mem_limit = mem_size;
> +               } else if (!strcmp(param, "efi_fake_mem")) {
> +                       mem_avoid_memmap(PARSE_EFI, val);
>                 }
>         }
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 45f853bce869..d028e9acdf1c 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -263,4 +263,12 @@ static inline void efi_reserve_boot_services(void)
>  }
>  #endif /* CONFIG_EFI */
>
> +#ifdef CONFIG_EFI_FAKE_MEMMAP
> +extern void __init efi_fake_memmap_early(void);
> +#else
> +static inline void efi_fake_memmap_early(void)
> +{
> +}
> +#endif
> +
>  #endif /* _ASM_X86_EFI_H */
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index c96657993167..188cd73cd7d6 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -259,6 +259,8 @@ int __init efi_memblock_x86_reserve_range(void)
>                 do_add_efi_memmap(ADD_EFI_SOFT_RESERVED);
>         }
>
> +       efi_fake_memmap_early();
> +
>         WARN(efi.memmap.desc_version != 1,
>              "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
>              efi.memmap.desc_version);
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 4ac2de4dfa72..554d795270d9 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -20,13 +20,16 @@ obj-$(CONFIG_UEFI_CPER)                     += cper.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
>  obj-$(CONFIG_EFI_STUB)                 += libstub/
> -obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_mem.o
> +obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
>  obj-$(CONFIG_EFI_TEST)                 += test/
>  obj-$(CONFIG_EFI_DEV_PATH_PARSER)      += dev-path-parser.o
>  obj-$(CONFIG_APPLE_PROPERTIES)         += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>
> +fake_map-y                             += fake_mem.o
> +fake_map-$(CONFIG_X86)                 += x86_fake_mem.o
> +
>  arm-obj-$(CONFIG_EFI)                  := arm-init.o arm-runtime.o
>  obj-$(CONFIG_ARM)                      += $(arm-obj-y)
>  obj-$(CONFIG_ARM64)                    += $(arm-obj-y)
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index 526b45331d96..bb9fc70d0cfa 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -17,12 +17,10 @@
>  #include <linux/memblock.h>
>  #include <linux/types.h>
>  #include <linux/sort.h>
> -#include <asm/efi.h>
> +#include "fake_mem.h"
>
> -#define EFI_MAX_FAKEMEM CONFIG_EFI_MAX_FAKE_MEM
> -
> -static struct efi_mem_range fake_mems[EFI_MAX_FAKEMEM];
> -static int nr_fake_mem;
> +struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
> +int nr_fake_mem;
>
>  static int __init cmp_fake_mem(const void *x1, const void *x2)
>  {
> @@ -50,7 +48,7 @@ void __init efi_fake_memmap(void)
>         /* count up the number of EFI memory descriptor */
>         for (i = 0; i < nr_fake_mem; i++) {
>                 for_each_efi_memory_desc(md) {
> -                       struct range *r = &fake_mems[i].range;
> +                       struct range *r = &efi_fake_mems[i].range;
>
>                         new_nr_map += efi_memmap_split_count(md, r);
>                 }
> @@ -70,7 +68,7 @@ void __init efi_fake_memmap(void)
>         }
>
>         for (i = 0; i < nr_fake_mem; i++)
> -               efi_memmap_insert(&efi.memmap, new_memmap, &fake_mems[i]);
> +               efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
>
>         /* swap into new EFI memmap */
>         early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
> @@ -104,22 +102,22 @@ static int __init setup_fake_mem(char *p)
>                 if (nr_fake_mem >= EFI_MAX_FAKEMEM)
>                         break;
>
> -               fake_mems[nr_fake_mem].range.start = start;
> -               fake_mems[nr_fake_mem].range.end = start + mem_size - 1;
> -               fake_mems[nr_fake_mem].attribute = attribute;
> +               efi_fake_mems[nr_fake_mem].range.start = start;
> +               efi_fake_mems[nr_fake_mem].range.end = start + mem_size - 1;
> +               efi_fake_mems[nr_fake_mem].attribute = attribute;
>                 nr_fake_mem++;
>
>                 if (*p == ',')
>                         p++;
>         }
>
> -       sort(fake_mems, nr_fake_mem, sizeof(struct efi_mem_range),
> +       sort(efi_fake_mems, nr_fake_mem, sizeof(struct efi_mem_range),
>              cmp_fake_mem, NULL);
>
>         for (i = 0; i < nr_fake_mem; i++)
>                 pr_info("efi_fake_mem: add attr=0x%016llx to [mem 0x%016llx-0x%016llx]",
> -                       fake_mems[i].attribute, fake_mems[i].range.start,
> -                       fake_mems[i].range.end);
> +                       efi_fake_mems[i].attribute, efi_fake_mems[i].range.start,
> +                       efi_fake_mems[i].range.end);
>
>         return *p == '\0' ? 0 : -EINVAL;
>  }
> diff --git a/drivers/firmware/efi/fake_mem.h b/drivers/firmware/efi/fake_mem.h
> new file mode 100644
> index 000000000000..d52791af4b18
> --- /dev/null
> +++ b/drivers/firmware/efi/fake_mem.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __EFI_FAKE_MEM_H__
> +#define __EFI_FAKE_MEM_H__
> +#include <asm/efi.h>
> +
> +#define EFI_MAX_FAKEMEM CONFIG_EFI_MAX_FAKE_MEM
> +
> +extern struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
> +extern int nr_fake_mem;
> +#endif /* __EFI_FAKE_MEM_H__ */
> diff --git a/drivers/firmware/efi/x86_fake_mem.c b/drivers/firmware/efi/x86_fake_mem.c
> new file mode 100644
> index 000000000000..e5d6d5a1b240
> --- /dev/null
> +++ b/drivers/firmware/efi/x86_fake_mem.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +#include <linux/efi.h>
> +#include <asm/e820/api.h>
> +#include "fake_mem.h"
> +
> +void __init efi_fake_memmap_early(void)
> +{
> +       int i;
> +
> +       /*
> +        * The late efi_fake_mem() call can handle all requests if
> +        * EFI_MEMORY_SP support is disabled.
> +        */
> +       if (!efi_soft_reserve_enabled())
> +               return;
> +
> +       if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
> +               return;
> +
> +       /*
> +        * Given that efi_fake_memmap() needs to perform memblock
> +        * allocations it needs to run after e820__memblock_setup().
> +        * However, if efi_fake_mem specifies EFI_MEMORY_SP for a given
> +        * address range that potentially needs to mark the memory as
> +        * reserved prior to e820__memblock_setup(). Update e820
> +        * directly if EFI_MEMORY_SP is specified for an
> +        * EFI_CONVENTIONAL_MEMORY descriptor.
> +        */
> +       for (i = 0; i < nr_fake_mem; i++) {
> +               struct efi_mem_range *mem = &efi_fake_mems[i];
> +               efi_memory_desc_t *md;
> +               u64 m_start, m_end;
> +
> +               if ((mem->attribute & EFI_MEMORY_SP) == 0)
> +                       continue;
> +
> +               m_start = mem->range.start;
> +               m_end = mem->range.end;
> +               for_each_efi_memory_desc(md) {
> +                       u64 start, end;
> +
> +                       if (md->type != EFI_CONVENTIONAL_MEMORY)
> +                               continue;
> +
> +                       start = md->phys_addr;
> +                       end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
> +
> +                       if (m_start <= end && m_end >= start)
> +                               /* fake range overlaps descriptor */;
> +                       else
> +                               continue;
> +
> +                       /*
> +                        * Trim the boundary of the e820 update to the
> +                        * descriptor in case the fake range overlaps
> +                        * !EFI_CONVENTIONAL_MEMORY
> +                        */
> +                       start = max(start, m_start);
> +                       end = min(end, m_end);
> +
> +                       if (end <= start)
> +                               continue;
> +                       e820__range_update(start, end - start + 1, E820_TYPE_RAM,
> +                                       E820_TYPE_SOFT_RESERVED);
> +                       e820__update_table(e820_table);
> +               }
> +       }
> +}
>
