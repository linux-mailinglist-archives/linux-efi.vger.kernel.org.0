Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D64B2400
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfIMQWh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 12:22:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44353 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387822AbfIMQWh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 12:22:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so29943662otj.11
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/7zA8hy7vWUCXE1P8KXDDtx137RZgfGDKbHKxNIEYs=;
        b=IN/M3FMxLBwmgvMmk0lJNGJAS/mUMfEPBK4dgES2Cj2oKAY0oKIpw5Wybr/17jg00X
         +YJoi5mNEigTjUjIbmSCUtoh1+9GIpSdGf9ez3YwNOscHMAfzE/dfBRizVxAYLjx+Fnj
         kxzUgKNThfMU/DRI4caSgvZMI5F9gBT0YahxqUp+eBKQqWGqQk5+Aa70t4xdFeT5aB40
         qU3i1b3guNJCM/e97/ugtmVp2lHJ/FIzpViABuUc+zo++HA/gKfg4B1xAn/UOJnRAdft
         rRbYF08TATalT5ldZdLKYcXjEpoLHFODVoFPDwY4Nr8htHrtTFrCg63F4ozFiQTPpNSE
         izeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/7zA8hy7vWUCXE1P8KXDDtx137RZgfGDKbHKxNIEYs=;
        b=EKeNwBJYiVdeBNnsCXKqkkuOlrQ8HbJ0NgaLk/Xw3A22OnOm4doLHU9Oq/PseeWLIg
         lO9aWACw2w4+0d33NfdAxfCktKcpO8ZOd2WtgNwJFl0bnG8YReNwdEH5u+8ITHbSlGCu
         50lSEVq8ymErzPt2N4/PxvBznaYAHjRGPbindxjeK5ZN4BDyMbFT7z+CafAZtdSJCex8
         vEkr28fHFpzQguKTAqn5CB4jDXVK03FypsRq1SFZhhsA87cE+Z3ZhGwaNVD35+EjZry0
         6QYnhqPyVEBDo10oUDX3Z7jcSsYpBRB3X5I6qTrTz4y0t/NQmNOt1idFfAhung4rNqyX
         Bi7w==
X-Gm-Message-State: APjAAAXvVVHatBTdUFkCL2AwRgUehoLqfF0n1BMVqJO2vstPMFyFKtTe
        mV8I9mfIxZsESgX5BdLRHG7il0UfbTsrRVgUOEIwkQ==
X-Google-Smtp-Source: APXvYqzBj5eqP5T9a9wW9o5625Or4fIYP9WPu1eQvUWQDn8pj5GLliAYq/QqVtCUdzEr4OdMYqWSczlV9/Uk/3fA1j8=
X-Received: by 2002:a9d:4a98:: with SMTP id i24mr974675otf.126.1568391755089;
 Fri, 13 Sep 2019 09:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995890.1616117.10724047366038926477.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8OOeLyuNwgG1eXM2FGDNrLvigMfR63uWwUB-Jg+WXM7A@mail.gmail.com>
In-Reply-To: <CAKv+Gu8OOeLyuNwgG1eXM2FGDNrLvigMfR63uWwUB-Jg+WXM7A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 09:22:23 -0700
Message-ID: <CAPcyv4hrEsQ0t1hTT1A5WKFqYhANq15n0ru67SLDfGf1ZG-XWA@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 13, 2019 at 6:00 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Aug 2019 at 03:06, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > interpretation of the EFI Memory Types as "reserved for a specific
> > purpose".
> >
> > The proposed Linux behavior for specific purpose memory is that it is
> > reserved for direct-access (device-dax) by default and not available for
> > any kernel usage, not even as an OOM fallback.  Later, through udev
> > scripts or another init mechanism, these device-dax claimed ranges can
> > be reconfigured and hot-added to the available System-RAM with a unique
> > node identifier. This device-dax management scheme implements "soft" in
> > the "soft reserved" designation by allowing some or all of the
> > reservation to be recovered as typical memory. This policy can be
> > disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> > efi=nosoftreserve.
> >
> > This patch introduces 2 new concepts at once given the entanglement
> > between early boot enumeration relative to memory that can optionally be
> > reserved from the kernel page allocator by default. The new concepts
> > are:
> >
> > - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
> >   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
> >   new type. Only perform this classification if the
> >   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
> >   typical ram.
> >
> > - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
> >   a device driver to search iomem resources for application specific
> >   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
> >
> > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > now, just identify and reserve memory of this type.
> >
> > The translation of EFI_CONVENTIONAL_MEMORY + EFI_MEMORY_SP to "soft
> > reserved" is x86/E820-only, but other archs could choose to publish
> > IORES_DESC_SOFT_RESERVED resources from their platform-firmware memory
> > map handlers. Other EFI-capable platforms would need to go audit their
> > local usages of EFI_CONVENTIONAL_MEMORY to consider the soft reserved
> > case.
> >
> > Cc: <x86@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> I understand that non-x86 may be out of scope for you, but this patch
> makes changes to x86 and generic code at the same time without regard
> for other architectures.

Yes, that did give me pause.

> I'd prefer it if we could cover ARM cleanly as well right at the start.

Let's do it.

>
> The first step would be to split out the EFI stub changes (i.e., to
> avoid allocating memory from EFI_MEMORY_SP regions) and the EFI core
> changes from the other changes. Then, I would like to ask for your
> help to get the arm64 part implemented where EFI_MEMORY_SP memory gets
> registered/reserved in a way that allows the HMAT code (which should
> be arch agnostic) to operate in the same way as it does on x86. Would
> it be enough to simply memblock_reserve() it and insert the iomem
> resource with the soft_reserved attribute?
>
> Some more comments below.
>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |   19 +++++++--
> >  arch/x86/Kconfig                                |   21 +++++++++
> >  arch/x86/boot/compressed/eboot.c                |    7 +++
> >  arch/x86/boot/compressed/kaslr.c                |    4 ++
> >  arch/x86/include/asm/e820/types.h               |    8 ++++
> >  arch/x86/include/asm/efi-stub.h                 |   11 +++++
> >  arch/x86/kernel/e820.c                          |   12 +++++
> >  arch/x86/platform/efi/efi.c                     |   51 +++++++++++++++++++++--
> >  drivers/firmware/efi/efi.c                      |    3 +
> >  drivers/firmware/efi/libstub/efi-stub-helper.c  |   12 +++++
> >  include/linux/efi.h                             |    1
> >  include/linux/ioport.h                          |    1
> >  12 files changed, 139 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/x86/include/asm/efi-stub.h
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1c67acd1df65..dd28f0726309 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1152,7 +1152,8 @@
> >                         Format: {"off" | "on" | "skip[mbr]"}
> >
> >         efi=            [EFI]
> > -                       Format: { "old_map", "nochunk", "noruntime", "debug" }
> > +                       Format: { "old_map", "nochunk", "noruntime", "debug",
> > +                                 "nosoftreserve" }
> >                         old_map [X86-64]: switch to the old ioremap-based EFI
> >                         runtime services mapping. 32-bit still uses this one by
> >                         default.
> > @@ -1161,6 +1162,12 @@
> >                         firmware implementations.
> >                         noruntime : disable EFI runtime services support
> >                         debug: enable misc debug output
> > +                       nosoftreserve: The EFI_MEMORY_SP (Specific Purpose)
> > +                       attribute may cause the kernel to reserve the
> > +                       memory range for a memory mapping driver to
> > +                       claim. Specify efi=nosoftreserve to disable this
> > +                       reservation and treat the memory by its base type
> > +                       (i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
> >
> >         efi_no_storage_paranoia [EFI; X86]
> >                         Using this parameter you can use more than 50% of
> > @@ -1173,15 +1180,21 @@
> >                         updating original EFI memory map.
> >                         Region of memory which aa attribute is added to is
> >                         from ss to ss+nn.
> > +
> >                         If efi_fake_mem=2G@4G:0x10000,2G@0x10a0000000:0x10000
> >                         is specified, EFI_MEMORY_MORE_RELIABLE(0x10000)
> >                         attribute is added to range 0x100000000-0x180000000 and
> >                         0x10a0000000-0x1120000000.
> >
> > +                       If efi_fake_mem=8G@9G:0x40000 is specified, the
> > +                       EFI_MEMORY_SP(0x40000) attribute is added to
> > +                       range 0x240000000-0x43fffffff.
> > +
> >                         Using this parameter you can do debugging of EFI memmap
> > -                       related feature. For example, you can do debugging of
> > +                       related features. For example, you can do debugging of
> >                         Address Range Mirroring feature even if your box
> > -                       doesn't support it.
> > +                       doesn't support it, or mark specific memory as
> > +                       "soft reserved".
> >
> >         efivar_ssdt=    [EFI; X86] Name of an EFI variable that contains an SSDT
> >                         that is to be dynamically loaded by Linux. If there are
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 4195f44c6a09..bced13503bb1 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1981,6 +1981,27 @@ config EFI_MIXED
> >
> >            If unsure, say N.
> >
> > +config EFI_SOFT_RESERVE
> > +       bool "Reserve EFI Specific Purpose Memory"
> > +       depends on EFI && ACPI_HMAT
> > +       default ACPI_HMAT
> > +       ---help---
> > +         On systems that have mixed performance classes of memory EFI
> > +         may indicate specific purpose memory with an attribute (See
> > +         EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> > +         attribute may have unique performance characteristics compared
> > +         to the system's general purpose "System RAM" pool. On the
> > +         expectation that such memory has application specific usage,
> > +         and its base EFI memory type is "conventional" answer Y to
> > +         arrange for the kernel to reserve it as a "Soft Reserved"
> > +         resource, and set aside for direct-access (device-dax) by
> > +         default. The memory range can later be optionally assigned to
> > +         the page allocator by system administrator policy via the
> > +         device-dax kmem facility. Say N to have the kernel treat this
> > +         memory as "System RAM" by default.
> > +
> > +         If unsure, say Y.
> > +
>
> This should be in generic code.

Agree.

>
> >  config SECCOMP
> >         def_bool y
> >         prompt "Enable seccomp to safely compute untrusted bytecode"
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index d6662fdef300..f2dc5896d770 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/pci.h>
> >
> >  #include <asm/efi.h>
> > +#include <asm/efi-stub.h>
> >  #include <asm/e820/types.h>
> >  #include <asm/setup.h>
> >  #include <asm/desc.h>
> > @@ -553,7 +554,11 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
> >                 case EFI_BOOT_SERVICES_CODE:
> >                 case EFI_BOOT_SERVICES_DATA:
> >                 case EFI_CONVENTIONAL_MEMORY:
> > -                       e820_type = E820_TYPE_RAM;
> > +                       if (!efi_nosoftreserve
> > +                                       && (d->attribute & EFI_MEMORY_SP))
> > +                               e820_type = E820_TYPE_SOFT_RESERVED;
> > +                       else
> > +                               e820_type = E820_TYPE_RAM;
> >                         break;
> >
> >                 case EFI_ACPI_MEMORY_NVS:
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 2e53c056ba20..093e84e28b7a 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/efi.h>
> >  #include <generated/utsrelease.h>
> >  #include <asm/efi.h>
> > +#include <asm/efi-stub.h>
> >
> >  /* Macros used by the included decompressor code below. */
> >  #define STATIC
> > @@ -760,6 +761,9 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >                 if (md->type != EFI_CONVENTIONAL_MEMORY)
> >                         continue;
> >
> > +               if (!efi_nosoftreserve && (md->attribute & EFI_MEMORY_SP))
> > +                       continue;
> > +
> >                 if (efi_mirror_found &&
> >                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
> >                         continue;
> > diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> > index c3aa4b5e49e2..314f75d886d0 100644
> > --- a/arch/x86/include/asm/e820/types.h
> > +++ b/arch/x86/include/asm/e820/types.h
> > @@ -28,6 +28,14 @@ enum e820_type {
> >          */
> >         E820_TYPE_PRAM          = 12,
> >
> > +       /*
> > +        * Special-purpose memory is indicated to the system via the
> > +        * EFI_MEMORY_SP attribute. Define an e820 translation of this
> > +        * memory type for the purpose of reserving this range and
> > +        * marking it with the IORES_DESC_SOFT_RESERVED designation.
> > +        */
> > +       E820_TYPE_SOFT_RESERVED = 0xefffffff,
> > +
> >         /*
> >          * Reserved RAM used by the kernel itself if
> >          * CONFIG_INTEL_TXT=y is enabled, memory of this type
> > diff --git a/arch/x86/include/asm/efi-stub.h b/arch/x86/include/asm/efi-stub.h
> > new file mode 100644
> > index 000000000000..16ebd036387b
> > --- /dev/null
> > +++ b/arch/x86/include/asm/efi-stub.h
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#ifndef _X86_EFI_STUB_H_
> > +#define _X86_EFI_STUB_H_
> > +
> > +#ifdef CONFIG_EFI_STUB
> > +extern bool efi_nosoftreserve;
> > +#else
> > +#define efi_nosoftreserve (1)
> > +#endif
> > +
> > +#endif /* _X86_EFI_STUB_H_ */
>
> Please put this in generic code as well (but you need a function not a
> variable - see below)
>
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index 7da2bcd2b8eb..9976106b57ec 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -190,6 +190,7 @@ static void __init e820_print_type(enum e820_type type)
> >         case E820_TYPE_RAM:             /* Fall through: */
> >         case E820_TYPE_RESERVED_KERN:   pr_cont("usable");                      break;
> >         case E820_TYPE_RESERVED:        pr_cont("reserved");                    break;
> > +       case E820_TYPE_SOFT_RESERVED:   pr_cont("soft reserved");               break;
> >         case E820_TYPE_ACPI:            pr_cont("ACPI data");                   break;
> >         case E820_TYPE_NVS:             pr_cont("ACPI NVS");                    break;
> >         case E820_TYPE_UNUSABLE:        pr_cont("unusable");                    break;
> > @@ -1037,6 +1038,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
> >         case E820_TYPE_PRAM:            return "Persistent Memory (legacy)";
> >         case E820_TYPE_PMEM:            return "Persistent Memory";
> >         case E820_TYPE_RESERVED:        return "Reserved";
> > +       case E820_TYPE_SOFT_RESERVED:   return "Soft Reserved";
> >         default:                        return "Unknown E820 type";
> >         }
> >  }
> > @@ -1052,6 +1054,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
> >         case E820_TYPE_PRAM:            /* Fall-through: */
> >         case E820_TYPE_PMEM:            /* Fall-through: */
> >         case E820_TYPE_RESERVED:        /* Fall-through: */
> > +       case E820_TYPE_SOFT_RESERVED:   /* Fall-through: */
> >         default:                        return IORESOURCE_MEM;
> >         }
> >  }
> > @@ -1064,6 +1067,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
> >         case E820_TYPE_PMEM:            return IORES_DESC_PERSISTENT_MEMORY;
> >         case E820_TYPE_PRAM:            return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> >         case E820_TYPE_RESERVED:        return IORES_DESC_RESERVED;
> > +       case E820_TYPE_SOFT_RESERVED:   return IORES_DESC_SOFT_RESERVED;
> >         case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
> >         case E820_TYPE_RAM:             /* Fall-through: */
> >         case E820_TYPE_UNUSABLE:        /* Fall-through: */
> > @@ -1078,11 +1082,12 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
> >                 return true;
> >
> >         /*
> > -        * Treat persistent memory like device memory, i.e. reserve it
> > -        * for exclusive use of a driver
> > +        * Treat persistent memory and other special memory ranges like
> > +        * device memory, i.e. reserve it for exclusive use of a driver
> >          */
> >         switch (type) {
> >         case E820_TYPE_RESERVED:
> > +       case E820_TYPE_SOFT_RESERVED:
> >         case E820_TYPE_PRAM:
> >         case E820_TYPE_PMEM:
> >                 return false;
> > @@ -1285,6 +1290,9 @@ void __init e820__memblock_setup(void)
> >                 if (end != (resource_size_t)end)
> >                         continue;
> >
> > +               if (entry->type == E820_TYPE_SOFT_RESERVED)
> > +                       memblock_reserve(entry->addr, entry->size);
> > +
> >                 if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> >                         continue;
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 0bb58eb33ca0..9cfb7f1cf25d 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -151,10 +151,18 @@ void __init efi_find_mirror(void)
> >   * more than the max 128 entries that can fit in the e820 legacy
> >   * (zeropage) memory map.
> >   */
> > +enum add_efi_mode {
> > +       ADD_EFI_ALL,
> > +       ADD_EFI_SOFT_RESERVED,
> > +};
> >
> > -static void __init do_add_efi_memmap(void)
> > +static void __init do_add_efi_memmap(enum add_efi_mode mode)
> >  {
> >         efi_memory_desc_t *md;
> > +       int add = 0;
> > +
> > +       if (!efi_enabled(EFI_MEMMAP))
> > +               return;
> >
> >         for_each_efi_memory_desc(md) {
> >                 unsigned long long start = md->phys_addr;
> > @@ -167,7 +175,10 @@ static void __init do_add_efi_memmap(void)
> >                 case EFI_BOOT_SERVICES_CODE:
> >                 case EFI_BOOT_SERVICES_DATA:
> >                 case EFI_CONVENTIONAL_MEMORY:
> > -                       if (md->attribute & EFI_MEMORY_WB)
> > +                       if (efi_enabled(EFI_MEM_SOFT_RESERVE)
> > +                                       && (md->attribute & EFI_MEMORY_SP))
> > +                               e820_type = E820_TYPE_SOFT_RESERVED;
> > +                       else if (md->attribute & EFI_MEMORY_WB)
> >                                 e820_type = E820_TYPE_RAM;
> >                         else
> >                                 e820_type = E820_TYPE_RESERVED;
> > @@ -193,9 +204,17 @@ static void __init do_add_efi_memmap(void)
> >                         e820_type = E820_TYPE_RESERVED;
> >                         break;
> >                 }
> > +
> > +               if (e820_type == E820_TYPE_SOFT_RESERVED)
> > +                       /* always add E820_TYPE_SOFT_RESERVED */;
> > +               else if (mode == ADD_EFI_SOFT_RESERVED)
> > +                       continue;
> > +
> > +               add++;
> >                 e820__range_add(start, size, e820_type);
> >         }
> > -       e820__update_table(e820_table);
> > +       if (add)
> > +               e820__update_table(e820_table);
> >  }
> >
> >  int __init efi_memblock_x86_reserve_range(void)
> > @@ -227,8 +246,18 @@ int __init efi_memblock_x86_reserve_range(void)
> >         if (rv)
> >                 return rv;
> >
> > -       if (add_efi_memmap)
> > -               do_add_efi_memmap();
> > +       if (add_efi_memmap) {
> > +               do_add_efi_memmap(ADD_EFI_ALL);
> > +       } else {
> > +               /*
> > +                * Given add_efi_memmap defaults to 0 and there there is no e820
> > +                * mechanism for soft-reserved memory. Explicitly scan for
> > +                * soft-reserved memory. Otherwise, the mechanism to disable the
> > +                * kernel's consideration of EFI_MEMORY_SP is the
> > +                * efi=nosoftreserve option.
> > +                */
> > +               do_add_efi_memmap(ADD_EFI_SOFT_RESERVED);
> > +       }
> >
> >         WARN(efi.memmap.desc_version != 1,
> >              "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> > @@ -781,6 +810,15 @@ static bool should_map_region(efi_memory_desc_t *md)
> >         if (IS_ENABLED(CONFIG_X86_32))
> >                 return false;
> >
> > +       /*
> > +        * EFI specific purpose memory may be reserved by default
> > +        * depending on kernel config and boot options.
> > +        */
> > +       if (md->type == EFI_CONVENTIONAL_MEMORY
> > +                       && efi_enabled(EFI_MEM_SOFT_RESERVE)
> > +                       && (md->attribute & EFI_MEMORY_SP))
> > +               return false;
> > +
> >         /*
> >          * Map all of RAM so that we can access arguments in the 1:1
> >          * mapping when making EFI runtime calls.
> > @@ -1072,6 +1110,9 @@ static int __init arch_parse_efi_cmdline(char *str)
> >         if (parse_option_str(str, "old_map"))
> >                 set_bit(EFI_OLD_MEMMAP, &efi.flags);
> >
> > +       if (parse_option_str(str, "nosoftreserve"))
> > +               clear_bit(EFI_MEM_SOFT_RESERVE, &efi.flags);
> > +
>
> Can we move this to the generic efi= handling code?

To parse_efi_cmdline() in drivers/fimrware/efi.c? Sure.

>
> >         return 0;
> >  }
> >  early_param("efi", arch_parse_efi_cmdline);
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 363bb9d00fa5..6d54d5c74347 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -52,6 +52,9 @@ struct efi __read_mostly efi = {
> >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> >         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > +#ifdef CONFIG_EFI_SOFT_RESERVE
> > +       .flags                  = 1UL << EFI_MEM_SOFT_RESERVE,
> > +#endif
> >  };
> >  EXPORT_SYMBOL(efi);
> >
>
> I'd prefer it if we could call this EFI_MEM_NO_SOFT_RESERVE instead,
> and invert the meaning of the bit.

...but that would mean repeat occurrences of
"!efi_enabled(EFI_MEM_NO_SOFT_RESERVE)", doesn't the double negative
seem less readable to you?

>
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index 3caae7f2cf56..35ee98a2c00c 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -28,6 +28,7 @@
> >  #define EFI_READ_CHUNK_SIZE    (1024 * 1024)
> >
> >  static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
> > +bool efi_nosoftreserve;
> >
>
> This needs a getter function if you want to access it from other
> compilation units. This has to do with how the early relocation code
> handles data symbol references. Please refer to nokaslr() for an
> example.

Ah, does that mean that the efi_nosoftreserve global variable
instances in different compilation units are effectively static the
way I currently have them defined?
