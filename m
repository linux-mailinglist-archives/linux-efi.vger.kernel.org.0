Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BA60CE9D
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiJYOPJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiJYOOW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:22 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC95B14F4;
        Tue, 25 Oct 2022 07:14:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2F52D40737BC;
        Tue, 25 Oct 2022 14:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F52D40737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707260;
        bh=IPQq2DUkqvsePNeMmcO13zCtRaNzLNzLzqZArfZzb4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFbQd/6JEhEySWp3agtsqOQbk7vueRFcbOkkchDsC0kBV/iaWjiSLSOkFQXYreNgX
         6iNASS1kdM9WHP1asr4DURYn5aZrpHSftjWk2mcZiBNblqsKk8JgIiuNB1h8uiX+j1
         K50cozUr/nZTEahpCPSaFFs+0LDvF3OWVNi6jXfQ=
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
Subject: [PATCH v2 21/23] efi/x86: Explicitly set sections memory attributes
Date:   Tue, 25 Oct 2022 17:12:59 +0300
Message-Id: <d1e825c2210767d6dd251a3dfb16d39ba22117c8.1666705333.git.baskov@ispras.ru>
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

Explicitly change sections memory attributes in efi_pe_entry in case
of incorrect EFI implementations and to reduce access rights to
compressed kernel blob. By default it is set executable due to
restriction in maximum number of sections that can fit before zero
page.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/x86-stub.c | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 4d9588d33479..d9bb9125d518 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -27,6 +27,12 @@ const efi_dxe_services_table_t *efi_dxe_table;
 extern u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
+extern char _head[], _ehead[];
+extern char _compressed[], _ecompressed[];
+extern char _text[], _etext[];
+extern char _rodata[], _erodata[];
+extern char _data[];
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -343,6 +349,54 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 		asm("hlt");
 }
 
+
+/*
+ * Manually setup memory protection attributes for each ELF section
+ * since we cannot do it properly by using PE sections.
+ */
+static void setup_sections_memory_protection(void *image_base,
+					     unsigned long init_size)
+{
+#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
+	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+
+	if (!efi_dxe_table ||
+	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
+		efi_warn("Unable to locate EFI DXE services table\n");
+		efi_dxe_table = NULL;
+		return;
+	}
+
+	/* .setup [image_base, _head] */
+	efi_adjust_memory_range_protection((unsigned long)image_base,
+					   (unsigned long)_head - (unsigned long)image_base,
+					   EFI_MEMORY_RO | EFI_MEMORY_XP);
+	/* .head.text [_head, _ehead] */
+	efi_adjust_memory_range_protection((unsigned long)_head,
+					   (unsigned long)_ehead - (unsigned long)_head,
+					   EFI_MEMORY_RO);
+	/* .rodata..compressed [_compressed, _ecompressed] */
+	efi_adjust_memory_range_protection((unsigned long)_compressed,
+					   (unsigned long)_ecompressed - (unsigned long)_compressed,
+					   EFI_MEMORY_RO | EFI_MEMORY_XP);
+	/* .text [_text, _etext] */
+	efi_adjust_memory_range_protection((unsigned long)_text,
+					   (unsigned long)_etext - (unsigned long)_text,
+					   EFI_MEMORY_RO);
+	/* .rodata [_rodata, _erodata] */
+	efi_adjust_memory_range_protection((unsigned long)_rodata,
+					   (unsigned long)_erodata - (unsigned long)_rodata,
+					   EFI_MEMORY_RO | EFI_MEMORY_XP);
+	/* .data, .bss [_data, image_base + init_size] */
+	efi_adjust_memory_range_protection((unsigned long)_data,
+					   (unsigned long)image_base + init_size - (unsigned long)_rodata,
+					   EFI_MEMORY_XP);
+#else
+	(void)image_base;
+	(void)init_size;
+#endif
+}
+
 void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params);
@@ -396,6 +450,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	memcpy(&hdr->jump, image_base + 0x1000,
 	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
+	setup_sections_memory_protection(image_base, hdr->init_size);
+
 	/*
 	 * Fill out some of the header fields ourselves because the
 	 * EFI firmware loader doesn't load the first sector.
-- 
2.37.4

