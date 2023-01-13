Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924666A520
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjAMVbo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 16:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAMVbn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 16:31:43 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6FCF5
        for <linux-efi@vger.kernel.org>; Fri, 13 Jan 2023 13:30:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v17-20020a17090abb9100b002239a73bc6eso15942659pjr.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Jan 2023 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L6JMs+vv0Y8b3m+JQom4X+Xtk6qATobid/EnFCyXyOM=;
        b=k5gES+OYQ33yZJbqj6EICTT/1+3F+ewBr5o1mDRPJcxeYe4eyVjUNmgTMOfEi3ctVr
         l0yIbSuHeQo8DfUsgXRVGzSkAk0q72JNEUFMPoCERObxULD6UJ2BRE6Yt6k6Xw/M5N5S
         l9tDBXC7w+uByJ9jNhqliIS2ClP1y5k87kuJuxSe5Ky4uAdQD9kZUrqf/7i2vZACwa3u
         HrvoVYADmB4zoxyqPhHeFYovU5pm2y+UkRKEdEC3ugzXzDZrNmXDJ4BUKJORoWJ/O1fn
         4RFyJRPKXg9cTuvGoOhWM5F55GbMoLk5OgD0XUXT3Ol/QKQ4boyd6yMIfurFY6yMEjia
         Olrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6JMs+vv0Y8b3m+JQom4X+Xtk6qATobid/EnFCyXyOM=;
        b=J156gJLxu3TS69zA4PyprRZj4fqHah7lvSPIYDNHQ6qVoUt1tdXcGRwaHoVBpq8iKf
         HaLO4XDtXY1gPKwYb4Lp5c3Jp6GWEbR83xqul6VNLoL6/0sDJskkNADLBWQQVTeo6aR4
         00SkAfNORN+cf8AQ+7M5T6DXHuM3RgfGgrUGEwam3tM8EPAsUYD44/7sW/LHQC1wSE/Z
         LHuJKgKej54uvovhnR6mtMmgZtHKEoJySr13ARNIaeGtltKdFVQ7leZf8At3AGg1ynu2
         tGUnv8eGljIUKR00phCWUFsjdgl9j7eoNI5c30phJmzwlrCl5zhr3Mfii/U0D5NxeUU1
         FZxw==
X-Gm-Message-State: AFqh2krUpGUBKbeDvAllnftHPBP66m5Zlt5QoGgQvWz3hLVAqKODs0Ug
        nka/V4BOkqMoon6TY+T9bh1/BNymwqfcBXG0sg==
X-Google-Smtp-Source: AMrXdXs19Hm7YNsIlOoPtjAfoKNdOI6m9CNlFDVidToplU+VfsIec2tRsOeip86nZJFq2LUjUmGdzLv1DyEmSZeWjA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:4ac5:b0:229:36cd:4ab8 with
 SMTP id mh5-20020a17090b4ac500b0022936cd4ab8mr227511pjb.114.1673645459173;
 Fri, 13 Jan 2023 13:30:59 -0800 (PST)
Date:   Fri, 13 Jan 2023 21:29:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230113212926.2904735-1-dionnaglaze@google.com>
Subject: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org
Cc:     jiewen.yao@intel.com, devel@edk2.groups.io,
        Dionna Glaze <dionnaglaze@google.com>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch depends on Kirill A. Shutemov's series

[PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory

The UEFI v2.9 specification includes a new memory type to be used in
environments where the OS must accept memory that is provided from its
host. Before the introduction of this memory type, all memory was
accepted eagerly in the firmware. In order for the firmware to safely
stop accepting memory on the OS's behalf, the OS must affirmatively
indicate support to the firmware.

Enabling unaccepted memory requires calling a 0-argument enablement
protocol before ExitBootServices. This call is only made if the kernel
is compiled with UNACCEPTED_MEMORY=y

The naming of the protocol guid is dependent on the standardization of
the protocol, which is being discussed. Acceptance is contingent on
the kernel community's approval.

Cc: Ard Biescheuvel <ardb@kernel.org>
Cc: "Min M. Xu" <min.m.xu@intel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Jiewen Yao <jiewen.yao@intel.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 37 +++++++++++++++++++++++++
 include/linux/efi.h                     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba..abf31e5ade55 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
+typedef union memory_acceptance_protocol memory_acceptance_protocol_t;
+union memory_acceptance_protocol {
+	struct {
+		efi_status_t (__efiapi *allow_unaccepted_memory)(
+			memory_acceptance_protocol_t *);
+	};
+	struct {
+		u32 allow_unaccepted_memory;
+	} mixed_mode;
+};
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -310,6 +321,30 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 #endif
 }
 
+
+static void setup_unaccepted_memory(void)
+{
+	efi_guid_t mem_acceptance_proto = EFI_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
+	memory_acceptance_protocol_t *proto;
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		return;
+
+	/*
+	 * Enable unaccepted memory before calling exit boot services in order
+	 * for the UEFI to not accept all memory on EBS.
+	 */
+	status = efi_bs_call(locate_protocol, &mem_acceptance_proto, NULL,
+			     (void **)&proto);
+	if (status != EFI_SUCCESS)
+		return;
+
+	status = efi_call_proto(proto, allow_unaccepted_memory);
+	if (status != EFI_SUCCESS)
+		efi_err("Memory acceptance protocol failed\n");
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params,
@@ -899,6 +934,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
+	setup_unaccepted_memory();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f5..bfc0e4f2aba5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -391,6 +391,7 @@ void efi_native_runtime_setup(void);
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 #define EFI_SMBIOS_PROTOCOL_GUID		EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
+#define EFI_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-- 
2.39.0.314.g84b9a713c41-goog

