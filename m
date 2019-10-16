Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681B6D88CA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 08:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbfJPGzP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 02:55:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPGzP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 02:55:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so26590924wrl.11
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2019 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvemngoLbISxBekJPhoOOobnKswGYXyE2cDueD3WFkc=;
        b=ypZ5y6EO9Sfzg33U3P062e/oQJnnAeOxWgQgs1xmx38QYfcRqm+baGwYb19FRoT9sZ
         jDaDN/48+VyE+90xOMjpcFAO0bW3Aoyl5j64e2V8kRX8DZVQbzwENgOf+/BPO+FdukBu
         ujgmDKcXrGUHUPck+jEmEwxeeUQIAkhVuxi78fyVHFB3fMTTjgGHWMBRixZ82Sw2cNv9
         UguFiHGdO59eNQzKrQ6GOB1YvW/U/Fxfu88/5cfnFe7+gdv8MCtt75M2gTat35Ixb1lx
         cmpqhW/7nBt2rtolCfJAk2FHFYaVf53kBB4iB1B/nGwuMXsDIqesVD5L/IYwpRrU2uOw
         WASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvemngoLbISxBekJPhoOOobnKswGYXyE2cDueD3WFkc=;
        b=lZO3Q33YVLawK8iZzyNKHmKwL4ZjYprmN9NxPXXC4ZhPLfvpKDT3Z2JAeY59AgH6w/
         xWRBiTTYnKBQV2FiEtW0PaXUNROIoESgk6X7a+JP3ajVi0wQBGpswwoPmxIyzdGn7YFD
         EMnvUmzH3luQ118kI9Db6i+IW+7q4ZJ8JhHnQvzn750tIfZFDLE6c8kIv1mcpWg6+Mre
         w77lmlub9s9PG53qprEki+BTJHPmoxPz25mfx+EwiQkvGyXGn0nRzGyDf3aLJzsXW0xv
         s6KdAX1hoMAMNmqpBUFwia1YhCggrNTDWTiH2VSnm9VFg0AR62vno3O2ZmhkQHTosI78
         0shw==
X-Gm-Message-State: APjAAAVeqEocLrtyLem0w2L7eRBajoKj2DFJqU9y74uKYR7lZldpLd4r
        hZ2wXxgDdwTRXo+d+9MooXMqGYj0U+f3XzcOY/8Hlg==
X-Google-Smtp-Source: APXvYqxc9cqLwQ7WFuTCsU1yvT8pwx8dZGqpv6f4AXFcClouV0sMowN0ARh2mgpyk9WlI5zW0g02YGD74oqt3jTzq+o=
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr1155244wrw.32.1571208911936;
 Tue, 15 Oct 2019 23:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 16 Oct 2019 08:54:59 +0200
Message-ID: <CAKv+Gu-dxRjANWfDGAaxCtGr_UxVt=c1Byb3zKRM9EuudpqNEQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] EFI Specific Purpose Memory Support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Darren Hart <dvhart@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Oct 2019 at 03:13, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v6 [1]:
> - Collect Ard's ack / review on patches 5-7, but not on patch 4 since it
>   needed a non-trivial rework for linker error reported by the 0day robot.
>
> - Fixup "efi: Common enable/disable infrastructure for EFI soft
>   reservation" with a new dependency on CONFIG_EFI_STUB for
>   CONFIG_EFI_SOFT_RESERVE since the efi_soft_reserve_enabled() helper is
>   only built with EFI_STUB=y and the support depends on early reservations
>   to keep the kernel text from landing in the reservation.

As far as I know, GRUB on x86 still boots without the EFI stub by
default (i.e., using the 'linux' command instead of the 'linuxefi'
command), so even if you build the stub, it is not going to be called
in many cases. Is that going to be a problem?

> This also
>   moved the IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) check into the header so
>   that the stub does not try to link to __efi_soft_reserve_enabled() in
>   the EFI_STUB=n case.
>
> - Rework "x86/efi: EFI soft reservation to E820 enumeration" to always
>   add the full EFI memory map when EFI_MEMORY_SP ranges are found. This
>   simplifies the logic to just add the full EFI map rather than try to
>   tease out just the EFI_MEMORY_SP ranges. (Ard)
>
> [1]: https://lore.kernel.org/lkml/157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> ---
> Merge notes:
>
> Hi Ingo,
>
> I'm still looking for Ard's ack on the revised patch 4, but otherwise
> feel like this is ready for your consideration.
>

Patch 4 looks fine to me,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>
> The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
> purpose") memory attribute. This attribute bit replaces the deprecated
> ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
> in ACPI 6.3.
>
> Given the increasing diversity of memory types that might be advertised
> to the operating system, there is a need for platform firmware to hint
> which memory ranges are free for the OS to use as general purpose memory
> and which ranges are intended for application specific usage. For
> example, an application with prior knowledge of the platform may expect
> to be able to exclusively allocate a precious / limited pool of high
> bandwidth memory. Alternatively, for the general purpose case, the
> operating system may want to make the memory available on a best effort
> basis as a unique numa-node with performance properties by the new
> CONFIG_HMEM_REPORTING [3] facility.
>
> In support of optionally allowing either application-exclusive and
> core-kernel-mm managed access to differentiated memory, claim
> EFI_MEMORY_SP ranges for exposure as "soft reserved" and assigned to a
> device-dax instance by default. Such instances can be directly owned /
> mapped by a platform-topology-aware application. Alternatively, with the
> new kmem facility [4], the administrator has the option to instead
> designate that those memory ranges be hot-added to the core-kernel-mm as
> a unique memory numa-node. In short, allow for the decision about what
> software agent manages soft-reserved memory to be made at runtime.
>
> The patches build on the new HMAT+HMEM_REPORTING facilities merged
> for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
> [5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
> attribute. Specific details on reproducing the test configuration are in
> patch 12.
>
> [2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
> [5]: http://patchwork.ozlabs.org/cover/1096737/
>
> ---
>
> Dan Williams (12):
>       acpi/numa: Establish a new drivers/acpi/numa/ directory
>       efi: Enumerate EFI_MEMORY_SP
>       x86/efi: Push EFI_MEMMAP check into leaf routines
>       efi: Common enable/disable infrastructure for EFI soft reservation
>       x86/efi: EFI soft reservation to E820 enumeration
>       arm/efi: EFI soft reservation to memblock
>       x86/efi: Add efi_fake_mem support for EFI_MEMORY_SP
>       lib: Uplevel the pmem "region" ida to a global allocator
>       dax: Fix alloc_dax_region() compile warning
>       device-dax: Add a driver for "hmem" devices
>       acpi/numa/hmat: Register HMAT at device_initcall level
>       acpi/numa/hmat: Register "soft reserved" memory as an "hmem" device
>
>
>  Documentation/admin-guide/kernel-parameters.txt |   19 +++
>  arch/arm64/mm/mmu.c                             |    2
>  arch/x86/boot/compressed/eboot.c                |    6 +
>  arch/x86/boot/compressed/kaslr.c                |   46 +++++++-
>  arch/x86/include/asm/e820/types.h               |    8 +
>  arch/x86/include/asm/efi.h                      |   17 +++
>  arch/x86/kernel/e820.c                          |   12 ++
>  arch/x86/kernel/setup.c                         |   18 +--
>  arch/x86/platform/efi/efi.c                     |   54 ++++++++-
>  arch/x86/platform/efi/quirks.c                  |    3 +
>  drivers/acpi/Kconfig                            |    9 --
>  drivers/acpi/Makefile                           |    3 -
>  drivers/acpi/hmat/Makefile                      |    2
>  drivers/acpi/numa/Kconfig                       |    7 +
>  drivers/acpi/numa/Makefile                      |    3 +
>  drivers/acpi/numa/hmat.c                        |  138 +++++++++++++++++++++--
>  drivers/acpi/numa/srat.c                        |    0
>  drivers/dax/Kconfig                             |   27 ++++-
>  drivers/dax/Makefile                            |    2
>  drivers/dax/bus.c                               |    2
>  drivers/dax/bus.h                               |    2
>  drivers/dax/dax-private.h                       |    2
>  drivers/dax/hmem.c                              |   56 +++++++++
>  drivers/firmware/efi/Kconfig                    |   21 ++++
>  drivers/firmware/efi/Makefile                   |    5 +
>  drivers/firmware/efi/arm-init.c                 |    9 ++
>  drivers/firmware/efi/arm-runtime.c              |   24 ++++
>  drivers/firmware/efi/efi.c                      |   13 ++
>  drivers/firmware/efi/esrt.c                     |    3 +
>  drivers/firmware/efi/fake_mem.c                 |   26 ++--
>  drivers/firmware/efi/fake_mem.h                 |   10 ++
>  drivers/firmware/efi/libstub/arm32-stub.c       |    5 +
>  drivers/firmware/efi/libstub/efi-stub-helper.c  |   19 +++
>  drivers/firmware/efi/libstub/random.c           |    4 +
>  drivers/firmware/efi/x86_fake_mem.c             |   69 ++++++++++++
>  drivers/nvdimm/Kconfig                          |    1
>  drivers/nvdimm/core.c                           |    1
>  drivers/nvdimm/nd-core.h                        |    1
>  drivers/nvdimm/region_devs.c                    |   13 +-
>  include/linux/efi.h                             |   16 +++
>  include/linux/ioport.h                          |    1
>  include/linux/memregion.h                       |   23 ++++
>  lib/Kconfig                                     |    3 +
>  lib/Makefile                                    |    1
>  lib/memregion.c                                 |   18 +++
>  45 files changed, 634 insertions(+), 90 deletions(-)
>  delete mode 100644 drivers/acpi/hmat/Makefile
>  rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (75%)
>  create mode 100644 drivers/acpi/numa/Makefile
>  rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (85%)
>  rename drivers/acpi/{numa.c => numa/srat.c} (100%)
>  create mode 100644 drivers/dax/hmem.c
>  create mode 100644 drivers/firmware/efi/fake_mem.h
>  create mode 100644 drivers/firmware/efi/x86_fake_mem.c
>  create mode 100644 include/linux/memregion.h
>  create mode 100644 lib/memregion.c
