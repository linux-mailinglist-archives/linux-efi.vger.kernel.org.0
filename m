Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37716056C
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBPSYC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgBPSYC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:02 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2102086A;
        Sun, 16 Feb 2020 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877441;
        bh=j3nSc1ziDeAOZ+GMaZJ73PIdlDUEWebRMtAgq39UXfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqZ9ZlllVcZiNnNk8PL/flvephl9ku9KJYSiyBxqtBcQBrRodDzq86YSHV8aqPWWy
         O9mdOL0iIQU0P1EIkskzsJiFN+pro0ivbUT1nk6CimLwxyH720r+n+V/b0cWnnEo11
         Z6i8sRHBC6mIlFObDNM47f+2QzWWhAbF37M0tmo8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 09/18] efi/ia64: use local variable for EFI system table address
Date:   Sun, 16 Feb 2020 19:23:25 +0100
Message-Id: <20200216182334.8121-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The IA64 code never refers to the EFI system table except from
inside the scope of efi_init(). So let's use a local variable
instead of efi.systab, which will be going away soon.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/kernel/efi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 74fad89ae209..81bc5031a115 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -484,6 +484,7 @@ efi_map_pal_code (void)
 void __init
 efi_init (void)
 {
+	const efi_system_table_t *efi_systab;
 	void *efi_map_start, *efi_map_end;
 	u64 efi_desc_size;
 	char *cp;
@@ -516,17 +517,17 @@ efi_init (void)
 		printk(KERN_INFO "Ignoring memory above %lluMB\n",
 		       max_addr >> 20);
 
-	efi.systab = __va(ia64_boot_param->efi_systab);
+	efi_systab = __va(ia64_boot_param->efi_systab);
 
 	/*
 	 * Verify the EFI Table
 	 */
-	if (efi.systab == NULL)
+	if (efi_systab == NULL)
 		panic("Whoa! Can't find EFI system table.\n");
-	if (efi_systab_check_header(&efi.systab->hdr, 1))
+	if (efi_systab_check_header(&efi_systab->hdr, 1))
 		panic("Whoa! EFI system table signature incorrect\n");
 
-	efi_systab_report_header(&efi.systab->hdr, efi.systab->fw_vendor);
+	efi_systab_report_header(&efi_systab->hdr, efi_systab->fw_vendor);
 
 	palo_phys      = EFI_INVALID_TABLE_ADDR;
 
@@ -536,7 +537,7 @@ efi_init (void)
 	if (palo_phys != EFI_INVALID_TABLE_ADDR)
 		handle_palo(palo_phys);
 
-	runtime = __va(efi.systab->runtime);
+	runtime = __va(efi_systab->runtime);
 	efi.get_time = phys_get_time;
 	efi.set_time = phys_set_time;
 	efi.get_wakeup_time = phys_get_wakeup_time;
-- 
2.17.1

