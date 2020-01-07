Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31788131CDE
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 01:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAGA4Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 19:56:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:59613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAGA4Z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Jan 2020 19:56:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:24 -0800
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="233001479"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:24 -0800
Subject: [PATCH v4 0/4] efi: Fix handling of multiple efi_fake_mem= entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Date:   Mon, 06 Jan 2020 16:40:22 -0800
Message-ID: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes since v3 [1]:
- Rather than pass a reference to a new flags argument, pass a common
  data structure ('struct efi_memory_map_data'), between
  efi_memmap_alloc() and efi_memmap_install(). (Ard)

- Arrange for EFI_MEMMAP_SLAB to be clear if EFI_MEMMAP_MEMBLOCK was set
  and vice versa (Ard).

[1]: http://lore.kernel.org/r/157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com
---

While testing an upcoming patchset to enhance the "soft reservation"
implementation it started crashing when rebased on v5.5-rc3. This
uncovered a few bugs in the efi_fake_mem= handling and
efi_memmap_alloc() leaks.

---

Copied from patch4:

Dave noticed that when specifying multiple efi_fake_mem= entries only
the last entry was successfully being reflected in the efi memory map.
This is due to the fact that the efi_memmap_insert() is being called
multiple times, but on successive invocations the insertion should be
applied to the last new memmap rather than the original map at
efi_fake_memmap() entry.

Rework efi_fake_memmap() to install the new memory map after each
efi_fake_mem= entry is parsed.

This also fixes an issue in efi_fake_memmap() that caused it to litter
emtpy entries into the end of the efi memory map. An empty entry causes
efi_memmap_insert() to attempt more memmap splits / copies than
efi_memmap_split_count() accounted for when sizing the new map. When
that happens efi_memmap_insert() may overrun its allocation, and if you
are lucky will spill over to an unmapped page leading to crash
signature like the following rather than silent corruption:

    BUG: unable to handle page fault for address: ffffffffff281000
    [..]
    RIP: 0010:efi_memmap_insert+0x11d/0x191
    [..]
    Call Trace:
     ? bgrt_init+0xbe/0xbe
     ? efi_arch_mem_reserve+0x1cb/0x228
     ? acpi_parse_bgrt+0xa/0xd
     ? acpi_table_parse+0x86/0xb8
     ? acpi_boot_init+0x494/0x4e3
     ? acpi_parse_x2apic+0x87/0x87
     ? setup_acpi_sci+0xa2/0xa2
     ? setup_arch+0x8db/0x9e1
     ? start_kernel+0x6a/0x547
     ? secondary_startup_64+0xb6/0xc0

Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
services data to fix kexec breakage" is listed in Fixes: since it
introduces more occurrences where efi_memmap_insert() is invoked after
an efi_fake_mem= configuration has been parsed. Previously the side
effects of vestigial empty entries were benign, but with commit
af1648984828 that follow-on efi_memmap_insert() invocation triggers
efi_memmap_insert() overruns.

---

Dan Williams (4):
      efi: Add a flags parameter to efi_memory_map
      efi: Add tracking for dynamically allocated memmaps
      efi: Fix efi_memmap_alloc() leaks
      efi: Fix handling of multiple efi_fake_mem= entries


 arch/x86/platform/efi/efi.c     |   10 +++-
 arch/x86/platform/efi/quirks.c  |   23 ++++------
 drivers/firmware/efi/fake_mem.c |   43 +++++++++---------
 drivers/firmware/efi/memmap.c   |   94 ++++++++++++++++++++++++++-------------
 include/linux/efi.h             |   17 +++++--
 5 files changed, 113 insertions(+), 74 deletions(-)
