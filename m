Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4232697C6
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgINVfl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 17:35:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36787 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVfl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 17:35:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id q63so1984907qkf.3
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 14:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/ewQ0iLQm3IC5miF4QzLllSyKfTF36wPSh2Hc3VkY0=;
        b=Ao36HJe932TB2VirCAU3/2bGGBSfqqZfQCkKJgTk6pXiwVi+14wi3WREmPdP/435rv
         ME9JNUWyZfNaBq3ODK/pSQtViaurPc6xT1FNjb0M3NK+JBcsFaDtxRUSqOGWavyH31dJ
         G3bXp2rYBQJ1pDyN1YPU58eNmddkPOK2/Skf3gNRuwAOcZCQdZ2pC/KLmNm3eIgmIu+j
         2Ds4YQKxbwds1xIetaaDuf73T3gorf5gw5IgY4HMsuglQZSaFo0wVBsaSkeXoadNvNqD
         tTqGCfiVkCDMPoAPdg3kfeHYpvOt99BaAQAfTAzpqHTGsYusFNQRrNOKaucdigCH4yhe
         XX9g==
X-Gm-Message-State: AOAM531bhsbACZMIfBO5/MCGkIFOAjsNDCCd+OhhQ/oj+pqczClRnbv7
        APYnM6zCsVCUac/TA78i10g=
X-Google-Smtp-Source: ABdhPJzCpsFBiOz2OEXGw7ZwhxcpevteNzqYJwPwv1ASt/88ZxT4t8Vps7CefzNCXUlIHF6ctuWCMQ==
X-Received: by 2002:a05:620a:1274:: with SMTP id b20mr14843417qkl.358.1600119337826;
        Mon, 14 Sep 2020 14:35:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g203sm15766260qkb.51.2020.09.14.14.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:35:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH 2/2] efi/x86: Add a quirk to support command line arguments on Dell EFI firmware
Date:   Mon, 14 Sep 2020 17:35:35 -0400
Message-Id: <20200914213535.933454-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914213535.933454-1-nivedita@alum.mit.edu>
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

At least some versions of Dell EFI firmware pass the entire
EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
the loaded image. This was verified with firmware revision 2.15.0 on a
Dell Precision T3620 by Jacobo Pontaja.

To handle this, add a quirk to check if the options look like a valid
EFI_LOAD_OPTION descriptor, and if so, use the OptionalData part as the
command line.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Jacobo Pantoja <jacobopantoja@gmail.com>
Link: https://lore.kernel.org/linux-efi/20200907170021.GA2284449@rani.riverdale.lan/
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 101 +++++++++++++++++-
 drivers/firmware/efi/libstub/efistub.h        |  31 ++++++
 drivers/firmware/efi/libstub/file.c           |   5 +-
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f735db55adc0..aa8da0a49829 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -238,6 +238,102 @@ efi_status_t efi_parse_options(char const *cmdline)
 	return EFI_SUCCESS;
 }
 
+/*
+ * The EFI_LOAD_OPTION descriptor has the following layout:
+ *	u32 Attributes;
+ *	u16 FilePathListLength;
+ *	u16 Description[];
+ *	efi_device_path_protocol_t FilePathList[];
+ *	u8 OptionalData[];
+ *
+ * This function validates and unpacks the variable-size data fields.
+ */
+static
+bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
+			    const efi_load_option_t *src, size_t size)
+{
+	const void *pos;
+	u16 c;
+	efi_device_path_protocol_t header;
+	const efi_char16_t *description;
+	const efi_device_path_protocol_t *file_path_list;
+
+	if (size < offsetof(efi_load_option_t, variable_data))
+		return false;
+	pos = src->variable_data;
+	size -= offsetof(efi_load_option_t, variable_data);
+
+	if ((src->attributes & ~EFI_LOAD_OPTION_MASK) != 0)
+		return false;
+
+	/* Scan description. */
+	description = pos;
+	do {
+		if (size < sizeof(c))
+			return false;
+		c = *(const u16 *)pos;
+		pos += sizeof(c);
+		size -= sizeof(c);
+	} while (c != L'\0');
+
+	/* Scan file_path_list. */
+	file_path_list = pos;
+	do {
+		if (size < sizeof(header))
+			return false;
+		header = *(const efi_device_path_protocol_t *)pos;
+		if (header.length < sizeof(header))
+			return false;
+		if (size < header.length)
+			return false;
+		pos += header.length;
+		size -= header.length;
+	} while ((header.type != EFI_DEV_END_PATH && header.type != EFI_DEV_END_PATH2) ||
+		 (header.sub_type != EFI_DEV_END_ENTIRE));
+	if (pos != (const void *)file_path_list + src->file_path_list_length)
+		return false;
+
+	dest->attributes = src->attributes;
+	dest->file_path_list_length = src->file_path_list_length;
+	dest->description = description;
+	dest->file_path_list = file_path_list;
+	dest->optional_data_size = size;
+	dest->optional_data = size ? pos : NULL;
+
+	return true;
+}
+
+/*
+ * At least some versions of Dell firmware pass the entire contents of the
+ * Boot#### variable, i.e. the EFI_LOAD_OPTION descriptor, rather than just the
+ * OptionalData field.
+ *
+ * Detect this case and extract OptionalData.
+ */
+void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size)
+{
+	const efi_load_option_t *load_option = *load_options;
+	efi_load_option_unpacked_t load_option_unpacked;
+
+	if (!IS_ENABLED(CONFIG_X86))
+		return;
+	if (!load_option)
+		return;
+	if (*load_options_size < sizeof(*load_option))
+		return;
+	if ((load_option->attributes & ~EFI_LOAD_OPTION_BOOT_MASK) != 0)
+		return;
+
+	if (!efi_load_option_unpack(&load_option_unpacked, load_option, *load_options_size))
+		return;
+
+	efi_warn_once(FW_BUG "LoadOptions is an EFI_LOAD_OPTION descriptor\n");
+	efi_warn_once(FW_BUG "Using OptionalData as a workaround\n");
+
+	*load_options = load_option_unpacked.optional_data;
+	*load_options_size = load_option_unpacked.optional_data_size;
+}
+
 /*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
@@ -247,12 +343,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 {
 	const u16 *s2;
 	unsigned long cmdline_addr = 0;
-	int options_chars = efi_table_attr(image, load_options_size) / 2;
+	int options_chars = efi_table_attr(image, load_options_size);
 	const u16 *options = efi_table_attr(image, load_options);
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
 	efi_status_t status;
 
+	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
+	options_chars /= sizeof(*options);
+
 	if (options) {
 		s2 = options;
 		while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e33b9395bc23..7997890c756d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -711,6 +711,35 @@ union efi_load_file_protocol {
 	} mixed_mode;
 };
 
+typedef struct {
+	u32 attributes;
+	u16 file_path_list_length;
+	u8 variable_data[];
+	// efi_char16_t description[];
+	// efi_device_path_protocol_t file_path_list[];
+	// u8 optional_data[];
+} __packed efi_load_option_t;
+
+#define EFI_LOAD_OPTION_ACTIVE		0x0001U
+#define EFI_LOAD_OPTION_FORCE_RECONNECT	0x0002U
+#define EFI_LOAD_OPTION_HIDDEN		0x0008U
+#define EFI_LOAD_OPTION_CATEGORY	0x1f00U
+#define   EFI_LOAD_OPTION_CATEGORY_BOOT	0x0000U
+#define   EFI_LOAD_OPTION_CATEGORY_APP	0x0100U
+
+#define EFI_LOAD_OPTION_BOOT_MASK \
+	(EFI_LOAD_OPTION_ACTIVE|EFI_LOAD_OPTION_HIDDEN|EFI_LOAD_OPTION_CATEGORY)
+#define EFI_LOAD_OPTION_MASK (EFI_LOAD_OPTION_FORCE_RECONNECT|EFI_LOAD_OPTION_BOOT_MASK)
+
+typedef struct {
+	u32 attributes;
+	u16 file_path_list_length;
+	const efi_char16_t *description;
+	const efi_device_path_protocol_t *file_path_list;
+	size_t optional_data_size;
+	const void *optional_data;
+} efi_load_option_unpacked_t;
+
 void efi_pci_disable_bridge_busmaster(void);
 
 typedef efi_status_t (*efi_exit_boot_map_processing)(
@@ -753,6 +782,8 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
 
 void efi_free(unsigned long size, unsigned long addr);
 
+void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size);
+
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 630caa6b1f4c..4e81c6077188 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -136,7 +136,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_size)
 {
 	const efi_char16_t *cmdline = image->load_options;
-	int cmdline_len = image->load_options_size / 2;
+	int cmdline_len = image->load_options_size;
 	unsigned long efi_chunk_size = ULONG_MAX;
 	efi_file_protocol_t *volume = NULL;
 	efi_file_protocol_t *file;
@@ -148,6 +148,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	if (!load_addr || !load_size)
 		return EFI_INVALID_PARAMETER;
 
+	efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
+	cmdline_len /= sizeof(*cmdline);
+
 	if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
 		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
-- 
2.26.2

