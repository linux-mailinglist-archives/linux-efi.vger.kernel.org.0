Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6418560CE8B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiJYONW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiJYONU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:20 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E509C7C0;
        Tue, 25 Oct 2022 07:13:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8142B419E9DE;
        Tue, 25 Oct 2022 14:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8142B419E9DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707196;
        bh=Aefb2KxY8wEcsAL+nOTqxSi0oyRs3zJQN8d4KjyQNvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUXCK8FDt1OfckZRH01rWpwujnXnMfwWb9W1vnuL/a13vX/dA7f7mttzDmcDlMYcd
         Wm9Mb18LyqhHC0bK0YjgpXcU7g564zjgFL0KdwsJxGLRwofXtaLgU2cg0CcTJFj8UL
         8L9fmyzGJ02cQvCnEka3c66FGNI3jx2Jy201XFKY=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 04/23] x86/boot: Increase boot page table size
Date:   Tue, 25 Oct 2022 17:12:42 +0300
Message-Id: <7a4ead3a0790f5b88b6e6dc2529aebe3fb5b2129.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

