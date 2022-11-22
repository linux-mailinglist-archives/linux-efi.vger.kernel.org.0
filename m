Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B1633B17
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKVLSr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiKVLRf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:17:35 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E656069C;
        Tue, 22 Nov 2022 03:14:50 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id B3D3340737C9;
        Tue, 22 Nov 2022 11:14:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B3D3340737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115685;
        bh=ZUJpRbIyPzAf4A80RpXrKYrL/K9OYgNwdLc+ngJr0bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cmk+mb5huszA2qUFj6o4xt2AVcWngG+nCNUXrywyMMftoNEzoH1yIW/BlZ68vjIAy
         Hf7zgiAUUOm2pr1Xbrn2xDzRLWWWhw8MnYOKl4531bY6OOICWrEMmjn3n/zbcDKJ/q
         yj9lRV7Xe7xSb2tS0ae/DT7XA1UVQGIXKExqa6ng=
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
Subject: [PATCH v3 21/24] efi/x86: Explicitly set sections memory attributes
Date:   Tue, 22 Nov 2022 14:12:30 +0300
Message-Id: <9b18f9efb457e9aa88e814928fdaa37c76f080e1.1668958803.git.baskov@ispras.ru>
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

Explicitly change sections memory attributes in efi_pe_entry in case
of incorrect EFI implementations and to reduce access rights to
compressed kernel blob. By default it is set executable due to
restriction in maximum number of sections that can fit before zero
page.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/x86-stub.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d9b239d7289f..56b8e7207361 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -27,6 +27,12 @@ const efi_dxe_services_table_t *efi_dxe_table;
 extern u32 image_offset;
 static efi_loaded_image_t *image __section(".data");
 
+extern char _head[], _ehead[];
+extern char _compressed[], _ecompressed[];
+extern char _text[], _etext[];
+extern char _rodata[], _erodata[];
+extern char _data[];
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -343,6 +349,52 @@ void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 		asm("hlt");
 }
 
+
+/*
+ * Manually setup memory protection attributes for each ELF section
+ * since we cannot do it properly by using PE sections.
+ */
+static void setup_sections_memory_protection(unsigned long image_base)
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
+	efi_adjust_memory_range_protection(image_base,
+					   (unsigned long)_head - image_base,
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
+	/* .data, .bss [_data, _end] */
+	efi_adjust_memory_range_protection((unsigned long)_data,
+					   (unsigned long)_end - (unsigned long)_data,
+					   EFI_MEMORY_XP);
+#else
+	(void)image_base;
+#endif
+}
+
 void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params);
@@ -687,6 +739,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+	setup_sections_memory_protection(bzimage_addr - image_offset);
+
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
-- 
2.37.4

