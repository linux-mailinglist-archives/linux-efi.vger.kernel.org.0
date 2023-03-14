Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA76B8F8A
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjCNKQ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCNKQe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:16:34 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED392F0C;
        Tue, 14 Mar 2023 03:16:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 759B94076B51;
        Tue, 14 Mar 2023 10:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 759B94076B51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788962;
        bh=KQX50IDaA6jZ2kthtK8SXDuugyihF8jwWgQGjoDSXQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjQYisjfZxZMV6h4m+SHY/QIVeA5iWeLKlreyZ85e4KK9cIyEmIPmZQyE654zZ1CU
         m61kYU1rLJ4noPb5EZpmpeIFyD6fr/Q0K/v9kn1xDsZsxdwDVjBj+DQAIzYG/Y7hhe
         wSsXQ2o3Afrd6yrxTnu+4zpucAJtk+9SLq9+olis=
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
Subject: [PATCH v5 09/27] x86/boot: Remove mapping from page fault handler
Date:   Tue, 14 Mar 2023 13:13:36 +0300
Message-Id: <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
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

After every implicit mapping is removed, this code is no longer needed.

Remove memory mapping from page fault handler to ensure that there are
no hidden invalid memory accesses.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++---------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index eb28ce9812c5..378f99b1d7e8 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -393,27 +393,21 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
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
2.39.2

