Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5C2FA060
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jan 2021 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404323AbhARMuZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jan 2021 07:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbhARMuF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Jan 2021 07:50:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42DD222286;
        Mon, 18 Jan 2021 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610974164;
        bh=L7XN53THx60L8nc9yyjr8F8pae87hzBdUTyX8cbOp5I=;
        h=From:To:Cc:Subject:Date:From;
        b=hptA74NAYipXruKNzAGJWvHtYwnopF2ste0lVM2ztAz3NPkaxCA8uRAN7PJl8ZIzg
         +bwpZsTEk9Yv2XIf0JjvZx+TqSPi7hXipWx+Np+JJaFgXxpRhDGUsutEDeiz/4p98R
         aI4GKRFCHujm9EfaEm4gxOOeRWwFp/TqaDgZaqXEAMxJM6sjVtkStJC7z6NooDUMpr
         Jq8Wa0ec9/31aspTuU7LdmpVI4KQDHjOoz6/wHNYfJhyDz6fdmTeoDur/M182OfQ6g
         /emermT8PEVNcjJWHO97f8iantx8p55SX92xnCf57y+jplo0Mk6YHldNqX3rKshI58
         wNyyHEqdnY0Hw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-ia64@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] efi: ia64: move IA64-only declarations to new asm/efi.h header
Date:   Mon, 18 Jan 2021 13:49:13 +0100
Message-Id: <20210118124913.1555-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move some EFI related declarations that are only referenced on IA64 to
a new asm/efi.h arch header.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/include/asm/efi.h      | 13 +++++++++++++
 arch/ia64/kernel/efi.c           |  1 +
 arch/ia64/kernel/machine_kexec.c |  1 +
 arch/ia64/kernel/mca.c           |  1 +
 arch/ia64/kernel/smpboot.c       |  1 +
 arch/ia64/kernel/time.c          |  1 +
 arch/ia64/kernel/uncached.c      |  4 +---
 arch/ia64/mm/contig.c            |  1 +
 arch/ia64/mm/discontig.c         |  1 +
 arch/ia64/mm/init.c              |  1 +
 include/linux/efi.h              |  6 ------
 11 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 arch/ia64/include/asm/efi.h

diff --git a/arch/ia64/include/asm/efi.h b/arch/ia64/include/asm/efi.h
new file mode 100644
index 000000000000..6a4a50d8f19a
--- /dev/null
+++ b/arch/ia64/include/asm/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
+
+void *efi_get_pal_addr(void);
+void efi_map_pal_code(void);
+void efi_memmap_walk(efi_freemem_callback_t, void *);
+void efi_memmap_walk_uc(efi_freemem_callback_t, void *);
+void efi_gettimeofday(struct timespec64 *ts);
+
+#endif
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f932b25fb817..dd7fd750bb93 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -34,6 +34,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/kregs.h>
 #include <asm/meminit.h>
diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
index efc9b568401c..af310dc8a356 100644
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -16,6 +16,7 @@
 #include <linux/numa.h>
 #include <linux/mmzone.h>
 
+#include <asm/efi.h>
 #include <asm/numa.h>
 #include <asm/mmu_context.h>
 #include <asm/setup.h>
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 2703f7795672..0fea266b4d39 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -91,6 +91,7 @@
 #include <linux/gfp.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 093040f7e626..49b488580939 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -45,6 +45,7 @@
 #include <asm/cache.h>
 #include <asm/current.h>
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index ed9fc3d057a6..a37f161a66b1 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -26,6 +26,7 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/hw_irq.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 0750f367837d..51883a66aeb5 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -20,14 +20,12 @@
 #include <linux/genalloc.h>
 #include <linux/gfp.h>
 #include <linux/pgtable.h>
+#include <asm/efi.h>
 #include <asm/page.h>
 #include <asm/pal.h>
 #include <linux/atomic.h>
 #include <asm/tlbflush.h>
 
-
-extern void __init efi_memmap_walk_uc(efi_freemem_callback_t, void *);
-
 struct uncached_pool {
 	struct gen_pool *pool;
 	struct mutex add_chunk_mutex;	/* serialize adding a converted chunk */
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index bfc4ecd0a2ab..62fe80a16f42 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/sizes.h>
 
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index c7311131156e..03b3a02375ff 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -24,6 +24,7 @@
 #include <linux/efi.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
+#include <asm/efi.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 9b5acf8fb092..24583a39fa1b 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -27,6 +27,7 @@
 #include <linux/swiotlb.h>
 
 #include <asm/dma.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/patch.h>
diff --git a/include/linux/efi.h b/include/linux/efi.h
index b1ca1903b483..a81ff5047859 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -167,8 +167,6 @@ struct capsule_info {
 
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
-typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
-
 /*
  * Types and defines for Time Services
  */
@@ -605,10 +603,6 @@ efi_guid_to_str(efi_guid_t *guid, char *out)
 }
 
 extern void efi_init (void);
-extern void *efi_get_pal_addr (void);
-extern void efi_map_pal_code (void);
-extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
-extern void efi_gettimeofday (struct timespec64 *ts);
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else
-- 
2.17.1

