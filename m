Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061646B8FB0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCNKWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCNKW1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:22:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554719BA74;
        Tue, 14 Mar 2023 03:22:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id CDC7B40755D2;
        Tue, 14 Mar 2023 10:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CDC7B40755D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788840;
        bh=EFJb9tTw64ENt680pifdKRXpvL7PgePGOnq6mgMilbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggABUxDrzLvNuUbajlU0vfcHk6kjIt3AhOX8yP6tIfcNDRtbNZ0Monp4gLl4Q/x8P
         pRiB0dAKaypOKO/Ou7Ml1USRjoirdXCWolVA77DP3epJ+4NhlULw+xK0UIT6dbmYxV
         8Fs5pW69Gi93ZNQSy0CtUwi7bSWHob8SqRPhH6N0=
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
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 02/27] x86/build: Remove RWX sections and align on 4KB
Date:   Tue, 14 Mar 2023 13:13:29 +0300
Message-Id: <edf3afbdcd87cb6c61815068084ac6de35be15a2.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
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

Avoid creating sections simultaneously writable and readable to prepare
for W^X implementation for the kernel itself (not the decompressor).
Align kernel sections on page size (4KB) to allow protecting them in the
page tables.

Split init code form ".init" segment into separate R_X ".inittext"
segment and make ".init" segment non-executable.

Also add these segments to x86_32 architecture for consistency.
Currently paging is disabled in x86_32 in compressed kernel, so
protection is not applied anyways, but .init code was incorrectly
placed in non-executable ".data" segment. This should not change
anything meaningful in memory layout now, but might be required in case
memory protection will also be implemented in compressed kernel for
x86_32.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 25f155205770..81ea1236d293 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,12 +102,11 @@ jiffies = jiffies_64;
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
+#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
 	percpu PT_LOAD FLAGS(6);        /* RW_ */
 #endif
-	init PT_LOAD FLAGS(7);          /* RWE */
-#endif
+	inittext PT_LOAD FLAGS(5);      /* R_E */
+	init PT_LOAD FLAGS(6);          /* RW_ */
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
@@ -226,9 +225,10 @@ SECTIONS
 #endif
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
-#ifdef CONFIG_X86_64
-	:init
-#endif
+	:inittext
+
+	. = ALIGN(PAGE_SIZE);
+
 
 	/*
 	 * Section for code used exclusively before alternatives are run. All
@@ -240,6 +240,7 @@ SECTIONS
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
 	}
+	:init
 
 	INIT_DATA_SECTION(16)
 
-- 
2.39.2

