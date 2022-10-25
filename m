Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E790960CE94
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiJYONW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJYONV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:21 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707129C7E4;
        Tue, 25 Oct 2022 07:13:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1B37A419E9C9;
        Tue, 25 Oct 2022 14:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1B37A419E9C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707196;
        bh=fViJDAK7Jhjm7j67wCahWTDXOcbmMv5WuCSXc1GBvn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6QaZrGXcpcaJ2A5BEn7J5H8f5rZe/kj/BDwztW6nCUOKyZiYaXL+L1C41mgnciH+
         OCZ6RVKxFamOFgCJT6ZcjxcTwWQFExvZZNWbziGVBbbI5+96pcciQ47rxKSyFLzhU3
         28Slr0PxWap659fbgOrgpLGhApAkdLpywUfoh9TI=
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
Subject: [PATCH v2 02/23] x86/build: Remove RWX sections and align on 4KB
Date:   Tue, 25 Oct 2022 17:12:40 +0300
Message-Id: <953b10b58f87a5a218091062fa24c284eb9b5252.1666705333.git.baskov@ispras.ru>
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

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 15f29053cec4..6587e0201b50 100644
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
2.37.4

