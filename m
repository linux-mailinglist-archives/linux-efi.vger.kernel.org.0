Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC664DB4C
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLOMi6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLOMij (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:38:39 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD12EF6C;
        Thu, 15 Dec 2022 04:38:25 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id AD20F400CBDC;
        Thu, 15 Dec 2022 12:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AD20F400CBDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671107901;
        bh=LKdPN2ZvZx4fnLPS2t3A1XEN4tVvozM/uwlffktRvcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX0IrRnsenVbR64VOD4t+61yrGNmLTwUUhZm4VdJHbvwWZKDY0FDAhig3UQXx9ynv
         3NpWs1+D0wD5XIuz0DWBRRqT2RZ9DpntTQd+h35zrGmdPLYaBoxdke6KA1MxWNAz1C
         bzaxCj4glhhojWN1lIgyNViKDrVyduWp+wJdHXxY=
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
Subject: [PATCH v4 02/26] x86/build: Remove RWX sections and align on 4KB
Date:   Thu, 15 Dec 2022 15:37:53 +0300
Message-Id: <721b5c42e0e79d307d5bcb08f9c8402f5067ded0.1671098103.git.baskov@ispras.ru>
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

Avoid creating sections simultaneously writable and readable
to prepare for W^X implementation. Align sections on page size (4KB) to
allow protecting them in the page tables.

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
Tested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2e0ee14229bf..2e56d694c491 100644
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
 
@@ -227,9 +226,10 @@ SECTIONS
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
@@ -241,6 +241,7 @@ SECTIONS
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
 	}
+	:init
 
 	INIT_DATA_SECTION(16)
 
-- 
2.37.4

