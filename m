Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9281760CE90
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiJYONt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiJYONp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232B1ABF20;
        Tue, 25 Oct 2022 07:13:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 940B7419E9FC;
        Tue, 25 Oct 2022 14:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 940B7419E9FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707212;
        bh=bLo8SKzI6m8S91IVaglgF8mOxCQMqZtqBjyc3705zno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnuPICTqGcCHyv5JohVZn/Iy9SZjGNEZ4lT4u5gTHIXacVP46flHXSp/TI/APoCPh
         QVNNlkItKMde/F2KIUv617thzrs3mC8aBhh6/PJkKhfuRudq/Lyt9x9f9pqQNQxig0
         8wuv2LrjxyIW63fwqPnglCC96nvvlLw25CLJ3wCc=
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
Subject: [PATCH v2 09/23] x86/boot: Remove mapping from page fault handler
Date:   Tue, 25 Oct 2022 17:12:47 +0300
Message-Id: <d028f2565984a6bd9a423d669e80fce55b6b83e9.1666705333.git.baskov@ispras.ru>
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

After every implicit mapping is removed, this code is no longer needed.

Remove memory mapping from page fault handler to ensure that there are
no hidden invalid memory accesses.

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

