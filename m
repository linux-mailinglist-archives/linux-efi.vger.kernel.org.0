Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE5395EC
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 21:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfFGTlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 15:41:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:7382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfFGTla (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 15:41:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 12:41:29 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2019 12:41:29 -0700
Subject: [PATCH v3 00/10] EFI Specific Purpose Memory Support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Darren Hart <dvhart@infradead.org>, linux-nvdimm@lists.01.org,
        x86@kernel.org, linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 12:27:13 -0700
Message-ID: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes since v2:
- Consolidate the new E820_TYPE and IORES_DESC and EFI configuration
  symbol on an "_APPLICATION_RESERVED" suffix. (Ard).

- Rework the implementation to drop the new MEMBLOCK_APP_SPECIFIC
  memblock and move the reservation earlier to e820__memblock_setup().
  (Mike)

- Move efi_fake_mem support for EFI_MEMORY_SP to its own implementation
  that does not require memblock allocations.

- Move is_efi_application_reserved() into the x86 efi implementation.
  (Ard)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-May/021668.html

---

Merge logistics: These patches touch core-efi, acpi, device-dax, and
x86. Given the regression risk is highest for the x86 changes it seems
tip.git is the best tree to host the series.

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
EFI_MEMORY_SP ranges for exposure as device-dax instances by default.
Such instances can be directly owned / mapped by a
platform-topology-aware application. Alternatively, with the new kmem
facility [4], the administrator has the option to instead designate that
those memory ranges be hot-added to the core-kernel-mm as a unique
memory numa-node. In short, allow for the decision about what software
agent manages specific-purpose memory to be made at runtime.

The patches are based on the new HMAT+HMEM_REPORTING facilities merged
for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
[5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
attribute.

[2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
[5]: http://patchwork.ozlabs.org/cover/1096737/

---

Dan Williams (10):
      acpi/numa: Establish a new drivers/acpi/numa/ directory
      acpi/numa/hmat: Skip publishing target info for nodes with no online memory
      efi: Enumerate EFI_MEMORY_SP
      x86, efi: Push EFI_MEMMAP check into leaf routines
      x86, efi: Reserve UEFI 2.8 Specific Purpose Memory for dax
      x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
      lib/memregion: Uplevel the pmem "region" ida to a global allocator
      device-dax: Add a driver for "hmem" devices
      acpi/numa/hmat: Register HMAT at device_initcall level
      acpi/numa/hmat: Register "specific purpose" memory as an "hmem" device


 arch/x86/Kconfig                    |   21 +++++
 arch/x86/boot/compressed/eboot.c    |    5 +
 arch/x86/boot/compressed/kaslr.c    |    3 -
 arch/x86/include/asm/e820/types.h   |    9 ++
 arch/x86/include/asm/efi.h          |   15 ++++
 arch/x86/kernel/e820.c              |   12 ++-
 arch/x86/kernel/setup.c             |   21 +++--
 arch/x86/platform/efi/efi.c         |   40 ++++++++-
 arch/x86/platform/efi/quirks.c      |    3 +
 drivers/acpi/Kconfig                |    9 --
 drivers/acpi/Makefile               |    3 -
 drivers/acpi/hmat/Makefile          |    2 
 drivers/acpi/numa/Kconfig           |    8 ++
 drivers/acpi/numa/Makefile          |    3 +
 drivers/acpi/numa/hmat.c            |  149 +++++++++++++++++++++++++++++++----
 drivers/acpi/numa/srat.c            |    0 
 drivers/dax/Kconfig                 |   27 +++++-
 drivers/dax/Makefile                |    2 
 drivers/dax/hmem.c                  |   58 ++++++++++++++
 drivers/firmware/efi/Makefile       |    5 +
 drivers/firmware/efi/efi.c          |    5 +
 drivers/firmware/efi/esrt.c         |    3 +
 drivers/firmware/efi/fake_mem-x86.c |   69 ++++++++++++++++
 drivers/firmware/efi/fake_mem.c     |   26 +++---
 drivers/firmware/efi/fake_mem.h     |   10 ++
 drivers/nvdimm/Kconfig              |    1 
 drivers/nvdimm/core.c               |    1 
 drivers/nvdimm/nd-core.h            |    1 
 drivers/nvdimm/region_devs.c        |   13 +--
 include/linux/efi.h                 |    1 
 include/linux/ioport.h              |    1 
 include/linux/memregion.h           |   11 +++
 lib/Kconfig                         |    7 ++
 lib/Makefile                        |    1 
 lib/memregion.c                     |   15 ++++
 35 files changed, 481 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (70%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (81%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)
 create mode 100644 drivers/dax/hmem.c
 create mode 100644 drivers/firmware/efi/fake_mem-x86.c
 create mode 100644 drivers/firmware/efi/fake_mem.h
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c
