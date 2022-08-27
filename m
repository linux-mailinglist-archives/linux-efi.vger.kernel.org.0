Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A15A3607
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiH0IjT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiH0IjS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA0C00EC
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6DD6131A
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53749C433D7;
        Sat, 27 Aug 2022 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589556;
        bh=1mSKisnehw6lyIsd2B1K6ZdFNtO8Mhv8xjHGLt/K/Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tstNgS84EICyeQY1pnlnyrrnjcbsmH73fUxshkYwvz5IeRZyFiODuq8myx5wG66Z8
         3lSt5/LqklD3IpXdFehlhlyDOmjeKC7gCDuYPrYA8EVWVhgp/X0BlM5fnn39lQ4HBs
         4cmxCk/gwmFkyrTW1gzwWBmxB2Lu9Uq3i1tij1Nl+281mbef3XTEylKSj4NWBwSkHH
         rEDscqM95jtKatHLs7iR4d5F7NWGy67TRktszJBcI+ZTNXrCmdZRTkn5BL+xvbCZsz
         GQF5WiUoTs/Ai1SzZnWNRP88GdtiRXHzPL4BcewJ04o8vTeZuqX0Mqeglu5RYCuSo0
         /TsYH4I3M844w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 2/9] efi/libstub: add some missing EFI prototypes
Date:   Sat, 27 Aug 2022 10:38:43 +0200
Message-Id: <20220827083850.2702465-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5223; i=ardb@kernel.org; h=from:subject; bh=1mSKisnehw6lyIsd2B1K6ZdFNtO8Mhv8xjHGLt/K/Pc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgNAAb2WUR5ho9ZcTJ9PTwt9vUq2K7p9Oosjcf1 1P8j76OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYDQAKCRDDTyI5ktmPJK8TDA CELL0MNlCJ21VA4TsPEUK/SWRCbGdhzrtaNRc/iE/NAY2eGoPpf4jxN+Wr4S/cYSEoQ5Us81+kTUhW iu2U29GL1NgDcnMfykoROKWF/Ru7uwZ8Lw3n4vFPqLulH6BPQ+FkgJKURnLjl8R/v4KyIBYRGj3e+7 yNwju4oMzkPyF9oN66xkTjA9UXmdAUBgZ762/CIGFs0HiEBMJZraX2hQzF/Q7PBVoZmY+/kKxUxVJw zEsFCGAsuc2BDR6Gvh1YiOHJWcmp+fo8QK0wKXId8yTCzMN6cexmMYPFT81tNdz1yaRTq0CF5E9gUY 0jVVJXkdGKNT6dfdAtnKLBYmg9mKnITY7aCr24YghjbV+6NyMpLer5PgmCfUTnZ7r1JTb2PvWS7kdC cjq3KtNOlpRaH8rxVimALGrlBtn4h04sZVBuF6ALZlj0JpKf+oWT+Q5nuQLWDNvrSgJnZ4GFmBvcnb Y6WM2N8voFc4k1WectjSuHMXXtyyPtrdmhLxIN6d7+0PM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define the correct prototypes for the load_image, start_image and
unload_image boot service pointers so we can call them from the EFI
zboot code.

Also add some prototypes related to installation and deinstallation of
protocols in to the EFI protocol database, including some definitions
related to device paths.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Note that the device-path-to-text protocol is not used in this series,
but it was useful during development so I retained the definitions.

 drivers/firmware/efi/libstub/efistub.h | 31 ++++++++++++++++----
 include/linux/efi.h                    | 12 ++++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..c7efc404e663 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -171,6 +171,23 @@ struct efi_boot_memmap {
 
 typedef struct efi_generic_dev_path efi_device_path_protocol_t;
 
+union efi_device_path_to_text_protocol {
+	struct {
+		efi_char16_t *(__efiapi *convert_device_node_to_text)(
+					const efi_device_path_protocol_t *,
+					bool, bool);
+		efi_char16_t *(__efiapi *convert_device_path_to_text)(
+					const efi_device_path_protocol_t *,
+					bool, bool);
+	};
+	struct {
+		u32 convert_device_node_to_text;
+		u32 convert_device_path_to_text;
+	} mixed_mode;
+};
+
+typedef union efi_device_path_to_text_protocol efi_device_path_to_text_protocol_t;
+
 typedef void *efi_event_t;
 /* Note that notifications won't work in mixed mode */
 typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
@@ -254,13 +271,17 @@ union efi_boot_services {
 							    efi_handle_t *);
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
-		void *load_image;
-		void *start_image;
+		efi_status_t (__efiapi *load_image)(bool, efi_handle_t,
+						    efi_device_path_protocol_t *,
+						    void *, unsigned long,
+						    efi_handle_t *);
+		efi_status_t (__efiapi *start_image)(efi_handle_t, unsigned long *,
+						     efi_char16_t **);
 		efi_status_t __noreturn (__efiapi *exit)(efi_handle_t,
 							 efi_status_t,
 							 unsigned long,
 							 efi_char16_t *);
-		void *unload_image;
+		efi_status_t (__efiapi *unload_image)(efi_handle_t);
 		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
 							    unsigned long);
 		void *get_next_monotonic_count;
@@ -277,8 +298,8 @@ union efi_boot_services {
 		void *locate_handle_buffer;
 		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
 							 void **);
-		void *install_multiple_protocol_interfaces;
-		void *uninstall_multiple_protocol_interfaces;
+		efi_status_t (__efiapi *install_multiple_protocol_interfaces)(efi_handle_t *, ...);
+		efi_status_t (__efiapi *uninstall_multiple_protocol_interfaces)(efi_handle_t, ...);
 		void *calculate_crc32;
 		void *copy_mem;
 		void *set_mem;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39..af90f7989f80 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -368,6 +368,9 @@ void efi_native_runtime_setup(void);
 #define UV_SYSTEM_TABLE_GUID			EFI_GUID(0x3b13a7d4, 0x633e, 0x11dd,  0x93, 0xec, 0xda, 0x25, 0x56, 0xd8, 0x95, 0x93)
 #define LINUX_EFI_CRASH_GUID			EFI_GUID(0xcfc8fc79, 0xbe2e, 0x4ddc,  0x97, 0xf0, 0x9f, 0x98, 0xbf, 0xe2, 0x98, 0xa0)
 #define LOADED_IMAGE_PROTOCOL_GUID		EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
+#define LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID	EFI_GUID(0xbc62157e, 0x3e33, 0x4fec,  0x99, 0x20, 0x2d, 0x3b, 0x36, 0xd7, 0x50, 0xdf)
+#define EFI_DEVICE_PATH_PROTOCOL_GUID		EFI_GUID(0x09576e91, 0x6d3f, 0x11d2,  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
+#define EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID	EFI_GUID(0x8b843e20, 0x8132, 0x4852,  0x90, 0xcc, 0x55, 0x1a, 0x4e, 0x4a, 0x7f, 0x1c)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
 #define EFI_UGA_PROTOCOL_GUID			EFI_GUID(0x982c298b, 0xf4fa, 0x41cb,  0xb8, 0x38, 0x77, 0xaa, 0x68, 0x8f, 0xb8, 0x39)
 #define EFI_PCI_IO_PROTOCOL_GUID		EFI_GUID(0x4cf5b200, 0x68b8, 0x4ca5,  0x9e, 0xec, 0xb2, 0x3e, 0x3f, 0x50, 0x02, 0x9a)
@@ -952,6 +955,7 @@ extern int efi_status_to_err(efi_status_t status);
 #define   EFI_DEV_MEDIA_VENDOR			 3
 #define   EFI_DEV_MEDIA_FILE			 4
 #define   EFI_DEV_MEDIA_PROTOCOL		 5
+#define   EFI_DEV_MEDIA_REL_OFFSET		 8
 #define EFI_DEV_BIOS_BOOT		0x05
 #define EFI_DEV_END_PATH		0x7F
 #define EFI_DEV_END_PATH2		0xFF
@@ -982,12 +986,20 @@ struct efi_vendor_dev_path {
 	u8				vendordata[];
 } __packed;
 
+struct efi_rel_offset_dev_path {
+	struct efi_generic_dev_path	header;
+	u32				reserved;
+	u64				starting_offset;
+	u64				ending_offset;
+} __packed;
+
 struct efi_dev_path {
 	union {
 		struct efi_generic_dev_path	header;
 		struct efi_acpi_dev_path	acpi;
 		struct efi_pci_dev_path		pci;
 		struct efi_vendor_dev_path	vendor;
+		struct efi_rel_offset_dev_path	rel_offset;
 	};
 } __packed;
 
-- 
2.35.1

