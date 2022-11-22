Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E9633AE4
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiKVLNJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiKVLMu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:50 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62862AC7;
        Tue, 22 Nov 2022 03:12:48 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8D6E840737CB;
        Tue, 22 Nov 2022 11:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8D6E840737CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115562;
        bh=6oUI8mIWLd1Fo2Wh2YHphseFjFuqPo1vi/6/ODurdpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qlx40wQ5kSLXszjhsQVxrO7xRhMyp9Oeuf12SIidIpokRDaEqNZ0ZRiVGEDVJVEVw
         Xo1PjqI0fJjpP8NhqxzQ+0D/QKO4G4UgcycPQVTvRJjf/mZXYg3Dhf50S0Z2+PWHK0
         RWWb5DFfcPIQe+twwUa/qAqFFUbJtoOnF8anC/3Y=
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
Subject: [PATCH v3 09/24] x86/boot: Remove mapping from page fault handler
Date:   Tue, 22 Nov 2022 14:12:18 +0300
Message-Id: <7438db5fded11a28310267a7b51b483a5f61d0d4.1668958803.git.baskov@ispras.ru>
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

After every implicit mapping is removed, this code is no longer needed.

Remove memory mapping from page fault handler to ensure that there are
no hidden invalid memory accesses.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++---------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index fec795a4ce23..ba5108c58a4e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -386,27 +386,21 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	unsigned long address = native_read_cr2();
 	unsigned long end;
-	bool ghcb_fault;
+	char *msg;
 
-	ghcb_fault = sev_es_check_ghcb_fault(address);
+	if (sev_es_check_ghcb_fault(address))
+		msg = "Page-fault on GHCB page:";
+	else
+		msg = "Unexpected page-fault:";
 
 	address   &= PMD_MASK;
 	end        = address + PMD_SIZE;
 
 	/*
-	 * Check for unexpected error codes. Unexpected are:
-	 *	- Faults on present pages
-	 *	- User faults
-	 *	- Reserved bits set
-	 */
-	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
-		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
-	else if (ghcb_fault)
-		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
-
-	/*
-	 * Error code is sane - now identity map the 2M region around
-	 * the faulting address.
+	 * Since all memory allocations are made explicit
+	 * now, every page fault at this stage is an
+	 * error and the error handler is there only
+	 * for debug purposes.
 	 */
-	kernel_add_identity_map(address, end, MAP_WRITE);
+	do_pf_error(msg, error_code, address, regs->ip);
 }
-- 
2.37.4

