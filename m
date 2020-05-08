Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92A01CB691
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEHSCv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEHSCu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:50 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E205721974;
        Fri,  8 May 2020 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960969;
        bh=2jew03jHhbJ4tYdttjEtxxUUZNb9+fBYEcl/Fza8KHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dC5rEQLjwHmHetLSEiZcwaxJZ1kftToq3Sp6pjkfQneV3LjotGcj4EyPYiA7DNe3n
         ekcMAJ/royVlIhZ5kVffwvaiWnDleZC4zneskzf9yOlj1m/U0GHnd81zVMS0hY318+
         M6eBqLTOiJ76IilGtlBHdVnC9JgjZSME39z74Dvg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 11/15] efi/libstub: Check return value of efi_parse_options
Date:   Fri,  8 May 2020 20:01:53 +0200
Message-Id: <20200508180157.1816-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

efi_parse_options can fail if it is unable to allocate space for a copy
of the command line. Check the return value to make sure it succeeded.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-12-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 23 +++++++++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 63541c2440ef..c2484bf75c5d 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -207,11 +207,21 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    cmdline_size == 0)
-		efi_parse_options(CONFIG_CMDLINE);
+	    cmdline_size == 0) {
+		status = efi_parse_options(CONFIG_CMDLINE);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
-		efi_parse_options(cmdline_ptr);
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
+		status = efi_parse_options(cmdline_ptr);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail_free_cmdline;
+		}
+	}
 
 	efi_info("Booting Linux Kernel...\n");
 
@@ -223,7 +233,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 				     dram_base, image);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
-		goto fail_free_cmdline;
+		goto fail_free_screeninfo;
 	}
 
 	efi_retrieve_tpm2_eventlog();
@@ -326,8 +336,9 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 fail_free_image:
 	efi_free(image_size, image_addr);
 	efi_free(reserve_size, reserve_addr);
-fail_free_cmdline:
+fail_free_screeninfo:
 	free_screen_info(si);
+fail_free_cmdline:
 	efi_free(cmdline_size, (unsigned long)cmdline_ptr);
 fail:
 	return status;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c84c5678e3e1..37154bb93c59 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -739,12 +739,20 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	efi_parse_options(CONFIG_CMDLINE);
+	status = efi_parse_options(CONFIG_CMDLINE);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to parse options\n");
+		goto fail;
+	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		efi_parse_options((char *)cmdline_paddr);
+		status = efi_parse_options((char *)cmdline_paddr);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse options\n");
+			goto fail;
+		}
 	}
 
 	/*
-- 
2.17.1

