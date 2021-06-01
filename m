Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B277396E49
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhFAH4C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 03:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233265AbhFAH4B (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Jun 2021 03:56:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08E961378;
        Tue,  1 Jun 2021 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622534060;
        bh=3D+bj5o5A5tcEPmr9Tb4qDYrRfzOIR7HmG3BtQDywkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbSnnlSctb6taPdQLppGzt3Mh6GYeKS/HKwxxhaOiIssZdPxWwLsOpwG+Z+12pnfG
         mJhJQdF08CH/ab9fC94kJM1KqI+XzUsqwjHkt5QbMm9ua3IFsG2Um15hhiNNJbJMjh
         TVKWRoWQd8D8BK6/QR7GpgpxReivElXECLBXtfqCzUiScTU5Ady9CkozetXlU/ra++
         H86i00og9/6sMybL8tSNtFnl1dQpdOLgYO07jYbu15DJOq6D0AiMB7bDLPeMUPwNm7
         QDn5dBzL08mGPV8mXRuHdCXXdwtIGGHce/NEx9ydaenXjgYP0psbMFeQXAVbHYenJt
         auqoATZ0lthnA==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/3] x86/setup: always reserve the first 1M of RAM
Date:   Tue,  1 Jun 2021 10:53:52 +0300
Message-Id: <20210601075354.5149-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210601075354.5149-1-rppt@kernel.org>
References: <20210601075354.5149-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are BIOSes that are known to corrupt the memory under 1M, or more
precisely under 640K because the memory above 640K is anyway reserved for
the EGA/VGA frame buffer and BIOS.

To prevent usage of the memory that will be potentially clobbered by the
kernel, the beginning of the memory is always reserved. The exact size of
the reserved area is determined by CONFIG_X86_RESERVE_LOW build time and
reservelow command line option. The reserved range may be from 4K to 640K
with the default of 64K. There are also configurations that reserve the
entire 1M range, like machines with SandyBridge graphic devices or systems
that enable crash kernel.

In addition to the potentially clobbered memory, EBDA of unknown size may
be as low as 128K and the memory above that EBDA start is also reserved
early.

It would have been possible to reserve the entire range under 1M unless for
the real mode trampoline that must reside in that area.

To accommodate placement of the real mode trampoline and keep the memory
safe from being clobbered by BIOS reserve the first 64K of RAM before
memory allocations are possible and then, after the real mode trampoline is
allocated, reserve the entire range from 0 to 1M.

Update trim_snb_memory() and reserve_real_mode() to avoid redundant
reservations of the same memory range.

Also make sure the memory under 1M is not getting freed by
efi_free_boot_services().

Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/setup.c        | 35 ++++++++++++++++++++--------------
 arch/x86/platform/efi/quirks.c | 12 ++++++++++++
 arch/x86/realmode/init.c       | 14 ++++++++------
 3 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 72920af0b3c0..22e9a17d6ac3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -637,11 +637,11 @@ static void __init trim_snb_memory(void)
 	 * them from accessing certain memory ranges, namely anything below
 	 * 1M and in the pages listed in bad_pages[] above.
 	 *
-	 * To avoid these pages being ever accessed by SNB gfx devices
-	 * reserve all memory below the 1 MB mark and bad_pages that have
-	 * not already been reserved at boot time.
+	 * To avoid these pages being ever accessed by SNB gfx devices reserve
+	 * bad_pages that have not already been reserved at boot time.
+	 * All memory below the 1 MB mark is anyway reserved later during
+	 * setup_arch(), so there is no need to reserve it here.
 	 */
-	memblock_reserve(0, 1<<20);
 
 	for (i = 0; i < ARRAY_SIZE(bad_pages); i++) {
 		if (memblock_reserve(bad_pages[i], PAGE_SIZE))
@@ -733,14 +733,14 @@ static void __init early_reserve_memory(void)
 	 * The first 4Kb of memory is a BIOS owned area, but generally it is
 	 * not listed as such in the E820 table.
 	 *
-	 * Reserve the first memory page and typically some additional
-	 * memory (64KiB by default) since some BIOSes are known to corrupt
-	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
+	 * Reserve the first 64K of memory since some BIOSes are known to
+	 * corrupt low memory. After the real mode trampoline is allocated the
+	 * rest of the memory below 640k is reserved.
 	 *
 	 * In addition, make sure page 0 is always reserved because on
 	 * systems with L1TF its contents can be leaked to user processes.
 	 */
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
+	memblock_reserve(0, SZ_64K);
 
 	early_reserve_initrd();
 
@@ -751,6 +751,7 @@ static void __init early_reserve_memory(void)
 
 	reserve_ibft_region();
 	reserve_bios_regions();
+	trim_snb_memory();
 }
 
 /*
@@ -1081,14 +1082,20 @@ void __init setup_arch(char **cmdline_p)
 			(max_pfn_mapped<<PAGE_SHIFT) - 1);
 #endif
 
-	reserve_real_mode();
-
 	/*
-	 * Reserving memory causing GPU hangs on Sandy Bridge integrated
-	 * graphics devices should be done after we allocated memory under
-	 * 1M for the real mode trampoline.
+	 * Find free memory for the real mode trampoline and place it
+	 * there.
+	 * If there is not enough free memory under 1M, on EFI-enabled
+	 * systems there will be additional attempt to reclaim the memory
+	 * for the real mode trampoline at efi_free_boot_services().
+	 *
+	 * Unconditionally reserve the entire first 1M of RAM because
+	 * BIOSes are know to corrupt low memory and several
+	 * hundred kilobytes are not worth complex detection what memory gets
+	 * clobbered. Moreover, on machines with SandyBridge graphics or in
+	 * setups that use crashkernel the entire 1M is anyway reserved.
 	 */
-	trim_snb_memory();
+	reserve_real_mode();
 
 	init_mem_mapping();
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 7850111008a8..b15ebfe40a73 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
 			size -= rm_size;
 		}
 
+		/*
+		 * Don't free memory under 1M for two reasons:
+		 * - BIOS might clobber it
+		 * - Crash kernel needs it to be reserved
+		 */
+		if (start + size < SZ_1M)
+			continue;
+		if (start < SZ_1M) {
+			size -= (SZ_1M - start);
+			start = SZ_1M;
+		}
+
 		memblock_free_late(start, size);
 	}
 
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 2e1c1bec0f9e..8ea285aca827 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -29,14 +29,16 @@ void __init reserve_real_mode(void)
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
 	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
-	if (!mem) {
+	if (!mem)
 		pr_info("No sub-1M memory is available for the trampoline\n");
-		return;
-	}
+	else
+		set_real_mode_mem(mem);
 
-	memblock_reserve(mem, size);
-	set_real_mode_mem(mem);
-	crash_reserve_low_1M();
+	/*
+	 * Unconditionally reserve the entire fisrt 1M, see comment in
+	 * setup_arch()
+	 */
+	memblock_reserve(0, SZ_1M);
 }
 
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
-- 
2.28.0

