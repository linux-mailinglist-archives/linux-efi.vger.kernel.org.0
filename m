Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF80124EAF
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLRRC6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRRC6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:02:58 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361EC24650;
        Wed, 18 Dec 2019 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688577;
        bh=1I/5DaWiHE7sWZ14eR8M6MgMnRmPPN1bEiP/q9I0L/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AySSKDlZY89QKGf5IHaGF4qFiT4dgS8kV2rz4EC9UXDnDurjkcrxEV2vbYDUiQ6p7
         DFN9XOQtxG05MaYfZEXxCLJQ1QQq0QKleNHNuKAG4oBiTGuOc+4tbnnB24FXw0u82f
         UAhe+4b8VwalqW7WykVCVyfEBW3med7uUyZYsVEw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 12/21] efi/libstub: unify the efi_char16_printk implementations
Date:   Wed, 18 Dec 2019 19:01:30 +0200
Message-Id: <20191218170139.9468-13-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use a single implementation for efi_char16_printk() across all
architectures.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               | 6 ------
 drivers/firmware/efi/libstub/arm-stub.c        | 9 ---------
 drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++++++
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index bed78679e10b..2bcab1ef5a56 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -39,12 +39,6 @@ static void setup_boot_services(struct efi_config *c)
 	c->text_output		= efi_table_attr(efi_system_table, con_out, sys_table);
 }
 
-void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
-{
-	efi_call_proto(efi_simple_text_output_protocol, output_string,
-		       efi_early->text_output, str);
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
index 5eaf6ada960f..3b89317f4c80 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -975,3 +975,12 @@ void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
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
2.17.1

