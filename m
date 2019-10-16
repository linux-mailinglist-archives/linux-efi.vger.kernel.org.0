Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE822D853F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 03:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfJPBNp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 21:13:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:11969 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfJPBNp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 21:13:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:13:44 -0700
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="189528314"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:13:44 -0700
Subject: [PATCH v7 00/12] EFI Specific Purpose Memory Support
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Tue, 15 Oct 2019 17:59:26 -0700
Message-ID: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes since v6 [1]:
- Collect Ard's ack / review on patches 5-7, but not on patch 4 since it
  needed a non-trivial rework for linker error reported by the 0day robot.

- Fixup "efi: Common enable/disable infrastructure for EFI soft
  reservation" with a new dependency on CONFIG_EFI_STUB for
  CONFIG_EFI_SOFT_RESERVE since the efi_soft_reserve_enabled() helper is
  only built with EFI_STUB=y and the support depends on early reservations
  to keep the kernel text from landing in the reservation. This also
  moved the IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) check into the header so
  that the stub does not try to link to __efi_soft_reserve_enabled() in
  the EFI_STUB=n case.

- Rework "x86/efi: EFI soft reservation to E820 enumeration" to always
  add the full EFI memory map when EFI_MEMORY_SP ranges are found. This
  simplifies the logic to just add the full EFI map rather than try to
  tease out just the EFI_MEMORY_SP ranges. (Ard)

[1]: https://lore.kernel.org/lkml/157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com/

---
Merge notes:

Hi Ingo,

I'm still looking for Ard's ack on the revised patch 4, but otherwise
feel like this is ready for your consideration.

---

The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
purpose") memory attribute. This attribute bit replaces the deprecated
ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
in ACPI 6.3.

Given the increasing diversity of memory types that might be advertised
to the operating system, there is a need for platform firmware to hint
which memory ranges are free for the OS to use as general purpose memory
and which ranges are intended for application specific usage. For
example, an application with prior knowledge of the platform may expect
to be able to exclusively allocate a precious / limited pool of high
bandwidth memory. Alternatively, for the general purpose case, the
operating system may want to make the memory available on a best effort
basis as a unique numa-node with performance properties by the new
CONFIG_HMEM_REPORTING [3] facility.

In support of optionally allowing either application-exclusive and
core-kernel-mm managed access to differentiated memory, claim
EFI_MEMORY_SP ranges for exposure as "soft reserved" and assigned to a
device-dax instance by default. Such instances can be directly owned /
mapped by a platform-topology-aware application. Alternatively, with the
new kmem facility [4], the administrator has the option to instead
designate that those memory ranges be hot-added to the core-kernel-mm as
a unique memory numa-node. In short, allow for the decision about what
software agent manages soft-reserved memory to be made at runtime.

The patches build on the new HMAT+HMEM_REPORTING facilities merged
for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
[5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
attribute. Specific details on reproducing the test configuration are in
patch 12.

[2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
[5]: http://patchwork.ozlabs.org/cover/1096737/

---

Dan Williams (12):
      acpi/numa: Establish a new drivers/acpi/numa/ directory
      efi: Enumerate EFI_MEMORY_SP
      x86/efi: Push EFI_MEMMAP check into leaf routines
      efi: Common enable/disable infrastructure for EFI soft reservation
      x86/efi: EFI soft reservation to E820 enumeration
      arm/efi: EFI soft reservation to memblock
      x86/efi: Add efi_fake_mem support for EFI_MEMORY_SP
      lib: Uplevel the pmem "region" ida to a global allocator
      dax: Fix alloc_dax_region() compile warning
      device-dax: Add a driver for "hmem" devices
      acpi/numa/hmat: Register HMAT at device_initcall level
      acpi/numa/hmat: Register "soft reserved" memory as an "hmem" device


 Documentation/admin-guide/kernel-parameters.txt |   19 +++
 arch/arm64/mm/mmu.c                             |    2 
 arch/x86/boot/compressed/eboot.c                |    6 +
 arch/x86/boot/compressed/kaslr.c                |   46 +++++++-
 arch/x86/include/asm/e820/types.h               |    8 +
 arch/x86/include/asm/efi.h                      |   17 +++
 arch/x86/kernel/e820.c                          |   12 ++
 arch/x86/kernel/setup.c                         |   18 +--
 arch/x86/platform/efi/efi.c                     |   54 ++++++++-
 arch/x86/platform/efi/quirks.c                  |    3 +
 drivers/acpi/Kconfig                            |    9 --
 drivers/acpi/Makefile                           |    3 -
 drivers/acpi/hmat/Makefile                      |    2 
 drivers/acpi/numa/Kconfig                       |    7 +
 drivers/acpi/numa/Makefile                      |    3 +
 drivers/acpi/numa/hmat.c                        |  138 +++++++++++++++++++++--
 drivers/acpi/numa/srat.c                        |    0 
 drivers/dax/Kconfig                             |   27 ++++-
 drivers/dax/Makefile                            |    2 
 drivers/dax/bus.c                               |    2 
 drivers/dax/bus.h                               |    2 
 drivers/dax/dax-private.h                       |    2 
 drivers/dax/hmem.c                              |   56 +++++++++
 drivers/firmware/efi/Kconfig                    |   21 ++++
 drivers/firmware/efi/Makefile                   |    5 +
 drivers/firmware/efi/arm-init.c                 |    9 ++
 drivers/firmware/efi/arm-runtime.c              |   24 ++++
 drivers/firmware/efi/efi.c                      |   13 ++
 drivers/firmware/efi/esrt.c                     |    3 +
 drivers/firmware/efi/fake_mem.c                 |   26 ++--
 drivers/firmware/efi/fake_mem.h                 |   10 ++
 drivers/firmware/efi/libstub/arm32-stub.c       |    5 +
 drivers/firmware/efi/libstub/efi-stub-helper.c  |   19 +++
 drivers/firmware/efi/libstub/random.c           |    4 +
 drivers/firmware/efi/x86_fake_mem.c             |   69 ++++++++++++
 drivers/nvdimm/Kconfig                          |    1 
 drivers/nvdimm/core.c                           |    1 
 drivers/nvdimm/nd-core.h                        |    1 
 drivers/nvdimm/region_devs.c                    |   13 +-
 include/linux/efi.h                             |   16 +++
 include/linux/ioport.h                          |    1 
 include/linux/memregion.h                       |   23 ++++
 lib/Kconfig                                     |    3 +
 lib/Makefile                                    |    1 
 lib/memregion.c                                 |   18 +++
 45 files changed, 634 insertions(+), 90 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (75%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (85%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)
 create mode 100644 drivers/dax/hmem.c
 create mode 100644 drivers/firmware/efi/fake_mem.h
 create mode 100644 drivers/firmware/efi/x86_fake_mem.c
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c
