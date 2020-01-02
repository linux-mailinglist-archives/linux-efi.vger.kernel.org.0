Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1142012E250
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 05:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgABE3V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 23:29:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:36000 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgABE3V (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jan 2020 23:29:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:20 -0800
X-IronPort-AV: E=Sophos;i="5.69,385,1571727600"; 
   d="scan'208";a="209682597"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:20 -0800
Subject: [PATCH v3 0/4] efi: Fix handling of multiple efi_fake_mem= entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Date:   Wed, 01 Jan 2020 20:13:18 -0800
Message-ID: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes since v2 [1]:
- Move the efi_memmap_free() until efi_memmap_install() is committed to
  installing the new map. (Dave).

- Handle the case of a memblock allocated memmap being freed after the slab
  allocator is up. Just use memblock_free_late() for that case rather
  than warn. (Prompted by Dave's feedback on how many successful
  efi_memmap_free() calls occur during a boot).

- Not changed was anything additional related to Dave's concern about
  efi_fake_mem= being applied to overlapping entries. I tested
  "efi_fake_mem=4G@9G:0x40000,4G@12G:0x40000" which triggers the second
  entry to overwrite the first as well as another entry. The result is
  reasonable and functional for what is otherwise garbage input:

  efi: mem53: [Conventional Memory|   |  |SP|  |  |  |  |  |   |WB|WT|WC|UC] range=[0x240000000-0x2ffffffff] (3072MB)
  efi: mem54: [Conventional Memory|   |  |SP|  |  |  |  |  |   |WB|WT|WC|UC] range=[0x300000000-0x33fffffff] (1024MB)
  efi: mem55: [Conventional Memory|   |  |SP|  |  |  |  |  |   |WB|WT|WC|UC] range=[0x340000000-0x3ffffffff] (3072MB)
  efi: mem56: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x400000000-0x43fffffff] (1024MB)

  # cat /proc/iomem  | grep Sof
  240000000-3ffffffff : Soft Reserved

[1]: http://lore.kernel.org/r/157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com

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
emtpy entries into the end of the efi memory map. The empty entry causes
efi_memmap_insert() to attempt more memmap splits / copies than
efi_memmap_split_count() accounted for when sizing the new map.

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
af1648984828 that follow-on efi_memmap_insert() invocation triggers the
above crash signature.

---

Dan Williams (4):
      efi: Add a flags parameter to efi_memory_map
      efi: Add tracking for dynamically allocated memmaps
      efi: Fix efi_memmap_alloc() leaks
      efi: Fix handling of multiple efi_fake_mem= entries


 arch/x86/platform/efi/efi.c     |    2 +
 arch/x86/platform/efi/quirks.c  |   11 ++++---
 drivers/firmware/efi/fake_mem.c |   37 +++++++++++++------------
 drivers/firmware/efi/memmap.c   |   58 ++++++++++++++++++++++++++++++---------
 include/linux/efi.h             |   13 +++++++--
 5 files changed, 81 insertions(+), 40 deletions(-)
