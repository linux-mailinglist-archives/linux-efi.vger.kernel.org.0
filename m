Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96712A2D2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLXPLy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfLXPLL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:11 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994C12071A;
        Tue, 24 Dec 2019 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200270;
        bh=VjiI9pnf1cQc/crLdBBdKIYtlUwGTCJNkegMsA/ka2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W57JZ515Ht+jLukXnvd+f6kskGtjO0+VWifyYslDfEvHwKTa3M1ukaK35vj6lqiZl
         WWhtY/QGkXO1XgR81o3CxJjLsLSoHzLg6RpIBUV4SvfGu8RD2sZPjF7krIe/Xykg9K
         zYASqYL6bXI0iT4i4LJxbQDFBGN+4OUgVsCkoZ5U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 16/25] efi/libstub: unify the efi_char16_printk implementations
Date:   Tue, 24 Dec 2019 16:10:16 +0100
Message-Id: <20191224151025.32482-17-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use a single implementation for efi_char16_printk() across all
architectures.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               | 7 -------
 drivers/firmware/efi/libstub/arm-stub.c        | 9 ---------
 drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++++++
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 3a7c900b9c66..5fb12827bdc2 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -46,13 +46,6 @@ static void setup_boot_services##bits(struct efi_config *c)		\
 BOOT_SERVICES(32);
 BOOT_SERVICES(64);
 
-void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
-{
-	efi_call_proto(efi_simple_text_output_protocol, output_string,
-		       ((efi_simple_text_output_protocol_t *)(unsigned long)
-				efi_early->text_output), str);
-}
-
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 47f072ac3f30..b44b1bd4d480 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -44,15 +44,6 @@ __pure efi_system_table_t *efi_system_table(void)
 	return sys_table;
 }
 
-void efi_char16_printk(efi_system_table_t *sys_table_arg,
-			      efi_char16_t *str)
-{
-	efi_simple_text_output_protocol_t *out;
-
-	out = (efi_simple_text_output_protocol_t *)sys_table_arg->con_out;
-	out->output_string(out, str);
-}
-
 static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 9bb74ad4b7fe..f74b514789d7 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -955,3 +955,12 @@ void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 	}
 	return NULL;
 }
+
+void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
+{
+	efi_call_proto(efi_simple_text_output_protocol,
+		       output_string,
+		       efi_table_attr(efi_system_table, con_out,
+				      efi_system_table()),
+		       str);
+}
-- 
2.20.1

