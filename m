Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7185C633AD3
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiKVLMx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiKVLMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:46 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83471D8F;
        Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1F10140737BC;
        Tue, 22 Nov 2022 11:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1F10140737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115561;
        bh=2OgHhvX0+NKEpZn5NMyzaoGQPiwdR+Cd155qSqPChrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLz8q0MMIyC5hmzfbPOkVty4Msd4Og74V5Gkwmoa+152kRZT4ObOLpYa+KPyaSCC5
         hDzv+vG5RFomXnx1ZY/eM0iNu6NArTDIEqUM68/mURRV9c5nuTYHh84Rrh8RxW+rqH
         HtkloXpaE8sxoWT6kHcXu/UjK9LdvX9DCSw2W5n4=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 04/24] x86/boot: Increase boot page table size
Date:   Tue, 22 Nov 2022 14:12:13 +0300
Message-Id: <5fe439aefdbbe52908512f5229d975dbd7780628.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Previous upper limit ignored pages implicitly mapped from #PF handler
by code accessing ACPI tables (boot/compressed/{acpi.c,efi.c}),
so theoretical upper limit is higher than it was set.

Using 4KB pages is desirable for better memory protection granularity.
Approximately twice as much memory is required for those.

Increase initial page table size to 64 4KB page tables.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/include/asm/boot.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..024d972c248e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -41,22 +41,24 @@
 # define BOOT_STACK_SIZE	0x4000
 
 # define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
 /*
  * Assuming all cross the 512GB boundary:
  * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * (3+3)*2 pages for param and cmd_line
+ * (2+2+S)*2 pages for kernel and randomized kernel, where S is total number
+ *     of sections of kernel. Explanation: 2+2 are upper level page tables.
+ *     We can have only S unaligned parts of section: 1 at the end of the kernel
+ *     and (S-1) at the section borders. The start address of the kernel is
+ *     aligned, so an extra page table. There are at most S=6 sections in
+ *     vmlinux ELF image.
+ * 3 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
+ * Total is 36 pages.
+ *
+ * Some pages are also required for UEFI memory map and
+ * ACPI table mappings, so we need to add extra space.
+ * FIXME: Figure out exact amount of pages.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE		(64*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.37.4

