Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3D109E6D
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2019 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfKZM70 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 26 Nov 2019 07:59:26 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35744 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfKZM70 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Nov 2019 07:59:26 -0500
Received: by mail-oi1-f169.google.com with SMTP id k196so157182oib.2;
        Tue, 26 Nov 2019 04:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0ZxJNOH7rMuReB8KSU0yjpLDZzbiOFLbBxle+ihuJvE=;
        b=t0/menJn6ID07MCY/lx5eXGn6COHI4RC+EahWDoi786fDgavzi7K0pCVtrtLV4RORp
         MT50pneZ2pubHiLfqW8jPChI2L8fXfgRhWpxSa5lkkpOePW5KB+3RLANQYEWjJsYawpT
         WSV34/eA9gRgfubwIKwKmIuZGnAQ2XtBrTsMrt0bc/PYjiYuK3mxYoDrXB1cd/xLjdDt
         aPHExqEEhbhloZFhUau62V388vDIyleNXjRnmwpapK90MqtKInI6RkBVJwm3M7nlIgWL
         qez5l3AyOBdNvSgxHYEgHAnPYLzXuxizNpXP850hPSJDR2r0S71LyRpHLWefMKYDUxyp
         ynRA==
X-Gm-Message-State: APjAAAXVkgYQzQsQSdGqv++g3p5cPQzh6Fo0XJO0VKep49GOKOOzbsbP
        EUbgNPVl4AKFzNEsSHTcaG911YZBESS9+1bTFaEE517R
X-Google-Smtp-Source: APXvYqwtJ/RGFbnBA2yw6xZZbA56o0qTy3cdM2jiPmmnD1HW/u0hnmY/Yx5cCGDC+jNy3+UjR9JtSlAn2i4YhmLTwRg=
X-Received: by 2002:aca:c753:: with SMTP id x80mr3280624oif.115.1574773164747;
 Tue, 26 Nov 2019 04:59:24 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 13:59:13 +0100
Message-ID: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.5-rc1

with top-most commit 782b59711e1561ee0da06bc478ca5e8249aa8d09

 Merge branch 'acpi-mm'

on top of commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c

 Linux 5.4-rc7

to receive ACPI update for 5.5-rc1.

These update the ACPICA code in the kernel to upstream revision
20191018, add support for EFI specific purpose memory, update the
ACPI EC driver to make it work on systems with hardware-reduced ACPI,
improve ACPI-based device enumeration for some platforms, rework the
lid blacklist handling in the button driver and add more lid quirks
to it, unify ACPI _HID/_UID matching, fix assorted issues and clean
up the code and documentation.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20191018
   including:

   * Fixes for Clang warnings (Bob Moore).

   * Fix for possible overflow in get_tick_count() (Bob Moore).

   * Introduction of acpi_unload_table() (Bob Moore).

   * Debugger and utilities updates (Erik Schmauss).

   * Fix for unloading tables loaded via configfs (Nikolaus Voss).

 - Add support for EFI specific purpose memory to optionally allow
   either application-exclusive or core-kernel-mm managed access to
   differentiated memory (Dan Williams).

 - Fix and clean up processing of the HMAT table (Brice Goglin,
   Qian Cai, Tao Xu).

 - Update the ACPI EC driver to make it work on systems with
   hardware-reduced ACPI (Daniel Drake).

 - Always build in support for the Generic Event Device (GED) to
   allow one kernel binary to work both on systems with full
   hardware ACPI and hardware-reduced ACPI (Arjan van de Ven).

 - Fix the table unload mechanism to unregister platform devices
   created when the given table was loaded (Andy Shevchenko).

 - Rework the lid blacklist handling in the button driver and add
   more lid quirks to it (Hans de Goede).

 - Improve ACPI-based device enumeration for some platforms based
   on Intel BayTrail SoCs (Hans de Goede).

 - Add an OpRegion driver for the Cherry Trail Crystal Cove PMIC
   and prevent handlers from being registered for unhandled PMIC
   OpRegions (Hans de Goede).

 - Unify ACPI _HID/_UID matching (Andy Shevchenko).

 - Clean up documentation and comments (Cao jin, James Pack, Kacper
   Piwiński).

Thanks!


---------------

Andy Shevchenko (7):
      ACPI / utils: Describe function parameters in kernel-doc
      ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
      ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
      ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
      mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
      iommu/amd: Switch to use acpi_dev_hid_uid_match()
      ACPI: platform: Unregister stale platform devices

Arjan van de Ven (1):
      ACPI: Always build evged in

Bob Moore (5):
      ACPICA: Results from Clang
      ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
      ACPICA: More Clang changes
      ACPICA: Add new external interface, acpi_unload_table()
      ACPICA: Update version to 20191018

Brice Goglin (1):
      ACPI: HMAT: don't mix pxm and nid when setting memory target processor_pxm

Cao jin (1):
      ACPI: OSI: Shoot duplicate word

Dan Williams (12):
      ACPI: NUMA: Establish a new drivers/acpi/numa/ directory
      efi: Enumerate EFI_MEMORY_SP
      x86/efi: Push EFI_MEMMAP check into leaf routines
      efi: Common enable/disable infrastructure for EFI soft reservation
      x86/efi: EFI soft reservation to E820 enumeration
      arm/efi: EFI soft reservation to memblock
      x86/efi: Add efi_fake_mem support for EFI_MEMORY_SP
      lib: Uplevel the pmem "region" ida to a global allocator
      dax: Fix alloc_dax_region() compile warning
      device-dax: Add a driver for "hmem" devices
      ACPI: NUMA: HMAT: Register HMAT at device_initcall level
      ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device

Daniel Drake (2):
      ACPI: EC: tweak naming in preparation for GpioInt support
      ACPI: EC: add support for hardware-reduced systems

Erik Schmauss (6):
      ACPICA: utilities: add flag to only display data when dumping buffers
      ACPICA: debugger: add command to dump all fields of particular subtype
      ACPICA: debugger: surround field unit output with braces '{'
      ACPICA: debugger: add field unit support for acpi_db_get_next_token
      ACPICA: acpiexec: initialize all simple types and field units
from user input
      ACPICA: debugger: remove leading whitespaces when converting a
string to a buffer

Hans de Goede (12):
      ACPI / PMIC: Do not register handlers for unhandled OpRegions
      ACPI / PMIC: Add byt prefix to Crystal Cove PMIC OpRegion driver
      ACPI / PMIC: Add Cherry Trail Crystal Cove PMIC OpRegion driver
      ACPI: LPSS: Add LNXVIDEO -> BYT I2C7 to lpss_device_links
      ACPI: LPSS: Add LNXVIDEO -> BYT I2C1 to lpss_device_links
      ACPI: LPSS: Add dmi quirk for skipping _DEP check for some device-links
      ACPI: button: Refactor lid_init_state module parsing code
      ACPI: button: Allow disabling LID support with the
lid_init_state module option
      ACPI: button: Turn lid_blacklst DMI table into a generic quirk table
      ACPI: button: Add DMI quirk for Medion Akoya E2215T
      ACPI: button: Add DMI quirk for Asus T200TA
      ACPI: button: Remove unused acpi_lid_notifier_[un]register() functions

James Pack (1):
      ACPI: Documentation: Minor spelling fix in namespace.rst

Kacper Piwiński (1):
      ACPI: video: update doc for acpi_video_bus_DOS()

Nikolaus Voss (1):
      ACPICA: make acpi_load_table() return table index

Qian Cai (1):
      ACPI: NUMA: HMAT: fix a section mismatch

Tao Xu (1):
      ACPI: HMAT: use %u instead of %d to print u32 values

---------------

 Documentation/admin-guide/kernel-parameters.txt    |  19 +-
 Documentation/firmware-guide/acpi/namespace.rst    |   2 +-
 arch/arm64/mm/mmu.c                                |   2 +
 arch/x86/boot/compressed/eboot.c                   |   6 +-
 arch/x86/boot/compressed/kaslr.c                   |  46 ++++-
 arch/x86/include/asm/e820/types.h                  |   8 +
 arch/x86/include/asm/efi.h                         |  17 +-
 arch/x86/kernel/e820.c                             |  12 +-
 arch/x86/kernel/setup.c                            |  18 +-
 arch/x86/platform/efi/efi.c                        |  54 +++++-
 arch/x86/platform/efi/quirks.c                     |   3 +
 drivers/acpi/Kconfig                               |  23 +--
 drivers/acpi/Makefile                              |   8 +-
 drivers/acpi/acpi_configfs.c                       |   4 +-
 drivers/acpi/acpi_lpss.c                           |  48 ++---
 drivers/acpi/acpi_platform.c                       |  43 +++++
 drivers/acpi/acpi_video.c                          |   8 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +
 drivers/acpi/acpica/acstruct.h                     |  10 ++
 drivers/acpi/acpica/acutils.h                      |   9 +-
 drivers/acpi/acpica/dbconvert.c                    |   4 +
 drivers/acpi/acpica/dbdisply.c                     |   2 -
 drivers/acpi/acpica/dbfileio.c                     |   2 +-
 drivers/acpi/acpica/dbinput.c                      |  36 +++-
 drivers/acpi/acpica/dbmethod.c                     |   4 +
 drivers/acpi/acpica/dbnames.c                      | 114 ++++++++++++
 drivers/acpi/acpica/dbobject.c                     |   1 -
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsfield.c                      |  12 +-
 drivers/acpi/acpica/evgpeblk.c                     |  11 +-
 drivers/acpi/acpica/evgpeinit.c                    |   3 -
 drivers/acpi/acpica/evmisc.c                       |  12 +-
 drivers/acpi/acpica/evregion.c                     |   4 +-
 drivers/acpi/acpica/evrgnini.c                     |   1 -
 drivers/acpi/acpica/hwxfsleep.c                    |   3 +
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   6 +-
 drivers/acpi/acpica/nsxfname.c                     |   4 +-
 drivers/acpi/acpica/psobject.c                     |   7 +-
 drivers/acpi/acpica/rscreate.c                     |   3 +
 drivers/acpi/acpica/tbdata.c                       |   3 +
 drivers/acpi/acpica/tbxfload.c                     |  40 ++++-
 drivers/acpi/acpica/utbuffer.c                     |  52 +++---
 drivers/acpi/acpica/utids.c                        |   2 -
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/button.c                              | 139 ++++++++-------
 drivers/acpi/ec.c                                  | 195 +++++++++++++++------
 drivers/acpi/hmat/Makefile                         |   2 -
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/{hmat => numa}/Kconfig                |   7 +
 drivers/acpi/numa/Makefile                         |   3 +
 drivers/acpi/{hmat => numa}/hmat.c                 | 158 ++++++++++++++---
 drivers/acpi/{numa.c => numa/srat.c}               |   0
 drivers/acpi/osi.c                                 |   6 +-
 drivers/acpi/pmic/intel_pmic.c                     |  20 ++-
 .../pmic/{intel_pmic_crc.c => intel_pmic_bytcrc.c} |   4 +-
 drivers/acpi/pmic/intel_pmic_chtcrc.c              |  44 +++++
 drivers/acpi/scan.c                                |   1 +
 drivers/acpi/utils.c                               |  32 ++++
 drivers/dax/Kconfig                                |  27 ++-
 drivers/dax/Makefile                               |   2 +
 drivers/dax/bus.c                                  |   2 +-
 drivers/dax/bus.h                                  |   2 +-
 drivers/dax/dax-private.h                          |   2 +-
 drivers/dax/hmem.c                                 |  56 ++++++
 drivers/firmware/efi/Kconfig                       |  21 +++
 drivers/firmware/efi/Makefile                      |   5 +-
 drivers/firmware/efi/arm-init.c                    |   9 +
 drivers/firmware/efi/arm-runtime.c                 |  24 +++
 drivers/firmware/efi/efi.c                         |  15 +-
 drivers/firmware/efi/esrt.c                        |   3 +
 drivers/firmware/efi/fake_mem.c                    |  26 ++-
 drivers/firmware/efi/fake_mem.h                    |  10 ++
 drivers/firmware/efi/libstub/arm32-stub.c          |   5 +
 drivers/firmware/efi/libstub/efi-stub-helper.c     |  19 ++
 drivers/firmware/efi/libstub/random.c              |   4 +
 drivers/firmware/efi/x86_fake_mem.c                |  69 ++++++++
 drivers/iommu/amd_iommu.c                          |  30 +---
 drivers/mfd/intel_soc_pmic_crc.c                   |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |  49 ++----
 drivers/nvdimm/Kconfig                             |   1 +
 drivers/nvdimm/core.c                              |   1 -
 drivers/nvdimm/nd-core.h                           |   1 -
 drivers/nvdimm/region_devs.c                       |  13 +-
 include/acpi/acpi_bus.h                            |   8 +-
 include/acpi/acpixf.h                              |   8 +-
 include/acpi/button.h                              |  12 --
 include/linux/acpi.h                               |   8 +
 include/linux/efi.h                                |  16 +-
 include/linux/ioport.h                             |   1 +
 include/linux/memregion.h                          |  23 +++
 lib/Kconfig                                        |   3 +
 lib/Makefile                                       |   1 +
 lib/memregion.c                                    |  18 ++
 94 files changed, 1374 insertions(+), 410 deletions(-)
