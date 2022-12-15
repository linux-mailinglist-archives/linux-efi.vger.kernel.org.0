Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B002264DB6A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLOMmS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLOMl0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:41:26 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE792F01A;
        Thu, 15 Dec 2022 04:40:26 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 421B540737A3;
        Thu, 15 Dec 2022 12:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 421B540737A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671108024;
        bh=M3naYL3GGl+5q+XfB9vebSxsQoc+3D3N13eyKPThq2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWyIGJFBnzJsQIQrSjOaeMbZjo7sAJtUMyNo3yquaylA6gq0bJVAr4PeNJJC3Jf0Q
         URAETK1ahqEnAouSJpMiIC15NDt4Iz03atawHNbkIDkRhcOds6fkCvObHGM7TMrytA
         OrSu2IqbhBN+5RdqIF3TUrfTF9ihM+NdoLGTvBVo=
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
Subject: [PATCH v4 13/26] x86/boot: Split trampoline and pt init code
Date:   Thu, 15 Dec 2022 15:38:04 +0300
Message-Id: <9f951d6332eea6e46ebd46ca919ed5b1b85c0ba3.1671098103.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
References: <cover.1671098103.git.baskov@ispras.ru>
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

When allocating trampoline from libstub trampoline allocation is
performed separately, so it needs to be skipped.

Split trampoline initialization and allocation code into two
functions to make them invokable separately.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/pgtable_64.c | 73 +++++++++++++++++----------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c7cf5a1059a8..1f7169248612 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -106,12 +106,8 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+bool trampoline_pgtable_init(struct boot_params *boot_params)
 {
-	struct paging_config paging_config = {};
-
-	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = rmode;
 
 	/*
 	 * Check if LA57 is desired and supported.
@@ -125,26 +121,10 @@ struct paging_config paging_prepare(void *rmode)
 	 *
 	 * That's substitute for boot_cpu_has() in early boot code.
 	 */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
-			!cmdline_find_option_bool("no5lvl") &&
-			native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
-		paging_config.l5_required = 1;
-	}
-
-	paging_config.trampoline_start = find_trampoline_placement();
-
-	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
-
-	/* Preserve trampoline memory */
-	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
-
-	/* Clear trampoline memory first */
-	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
-
-	/* Copy trampoline code in place */
-	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
-			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+	bool l5_required = IS_ENABLED(CONFIG_X86_5LEVEL) &&
+			   !cmdline_find_option_bool("no5lvl") &&
+			   native_cpuid_eax(0) >= 7 &&
+			   (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)));
 
 	/*
 	 * The code below prepares page table in trampoline memory.
@@ -160,10 +140,10 @@ struct paging_config paging_prepare(void *rmode)
 	 * We are not going to use the page table in trampoline memory if we
 	 * are already in the desired paging mode.
 	 */
-	if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
 		goto out;
 
-	if (paging_config.l5_required) {
+	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
@@ -185,6 +165,45 @@ struct paging_config paging_prepare(void *rmode)
 		       (void *)src, PAGE_SIZE);
 	}
 
+out:
+	return l5_required;
+}
+
+struct paging_config paging_prepare(void *rmode)
+{
+	struct paging_config paging_config = {};
+	bool early_trampoline_alloc = 0;
+
+	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	boot_params = rmode;
+
+	/*
+	 * We only need to find trampoline placement, if we have
+	 * not already done it from libstub.
+	 */
+
+	paging_config.trampoline_start = find_trampoline_placement();
+	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+	early_trampoline_alloc = 0;
+
+	/*
+	 * Preserve trampoline memory.
+	 * When trampoline is located in memory
+	 * owned by us, i.e. allocated in EFISTUB,
+	 * we don't care about previous contents
+	 * of this memory so copying can also be skipped.
+	 */
+	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
+
+	/* Clear trampoline memory first */
+	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
+
+	/* Copy trampoline code in place */
+	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
+			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+
+	paging_config.l5_required = trampoline_pgtable_init(boot_params);
+
 out:
 	return paging_config;
 }
-- 
2.37.4

