Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0C157F6A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBJQDb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgBJQDb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:31 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2987824680;
        Mon, 10 Feb 2020 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350610;
        bh=PL6d01T90M5XW0tFbVb2uQ+udpO3E9/eaIt8jnf2EMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tB6RStpBNVhyWaKtbtdsvUtx8wPC4Z+RqjaAuCDL/4E1F1U6e5nS4EczGw95ZGqcB
         5Oqj6F7sAwbH9QUaiXMYZ1GFpxqO2Yh7qYNkOKSMiPBvjXmFYcQ3udhFkqI0UlrEQy
         lqXyR/v614d8rY/vT4CgNXdUbzXvrVWCfgFYc06Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 19/19] efi/libstub: Make the LoadFile EFI protocol accessible
Date:   Mon, 10 Feb 2020 17:02:48 +0100
Message-Id: <20200210160248.4889-20-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the protocol definitions, GUIDs and mixed mode glue so that
the EFI loadfile protocol can be used from the stub. This will
be used in a future patch to load the initrd.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             |  4 ++++
 drivers/firmware/efi/libstub/efistub.h | 14 ++++++++++++++
 include/linux/efi.h                    |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 9ced980b123b..fcb21e3d13c5 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -291,6 +291,10 @@ static inline void *efi64_zero_upper(void *p)
 	((protocol), efi64_zero_upper(seg), efi64_zero_upper(bus),	\
 	 efi64_zero_upper(dev), efi64_zero_upper(func))
 
+/* LoadFile */
+#define __efi64_argmap_load_file(protocol, path, policy, bufsize, buf)	\
+	((protocol), (path), (policy), efi64_zero_upper(bufsize), (buf))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index afa774a312f5..34fe3fad042f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -541,6 +541,20 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+typedef union efi_load_file_protocol efi_load_file_protocol_t;
+typedef union efi_load_file_protocol efi_load_file2_protocol_t;
+
+union efi_load_file_protocol {
+	struct {
+		efi_status_t (__efiapi *load_file)(efi_load_file_protocol_t *,
+						   efi_device_path_protocol_t *,
+						   bool, unsigned long *, void *);
+	};
+	struct {
+		u32 load_file;
+	} mixed_mode;
+};
+
 void efi_pci_disable_bridge_busmaster(void);
 
 typedef efi_status_t (*efi_exit_boot_map_processing)(
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 0e047d2738cd..9ccf313fe9de 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -332,6 +332,8 @@ void efi_native_runtime_setup(void);
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
+#define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
+#define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-- 
2.17.1

