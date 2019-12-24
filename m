Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE15012A2C4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfLXPLY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfLXPLY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:24 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2793920CC7;
        Tue, 24 Dec 2019 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200283;
        bh=kEpNKZ+gUmZIgWkUkQ/lTPf0yIvn5APUaBestMovXK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRWqzzDVQJiIDOFm8nxhHxKm9hw7Rb3qBITesjDiFKG9P8fyEoNj/MitJx60TkF9b
         6JhxaTs3+MPiSJtA0WU3fqYyTDWupAHn0/KWn7nwUcukaVTsd4H+7U2bZqn1VbXpbL
         P2O6H0ZNZJ8CtZlv1WXFaDQu8SoeFLecYmSbSvQ4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 24/25] efi/libstub: tidy up types and names of global cmdline variables
Date:   Tue, 24 Dec 2019 16:10:24 +0100
Message-Id: <20191224151025.32482-25-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop leading underscores and use bool not int for true/false
variables set on the command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c       |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 36 +++++++++----------
 drivers/firmware/efi/libstub/efistub.h        | 12 +++++--
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 62280df09dd4..7bbef4a67350 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -37,7 +37,7 @@
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 
-static efi_system_table_t *__section(.data) sys_table;
+static efi_system_table_t *__efistub_global sys_table;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index ef0ffa512c20..f1b9c36934e9 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -27,24 +27,24 @@
  */
 #define EFI_READ_CHUNK_SIZE	(1024 * 1024)
 
-static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
+static unsigned long efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
-static int __section(.data) __nokaslr;
-static int __section(.data) __quiet;
-static int __section(.data) __novamap;
-static bool __section(.data) efi_nosoftreserve;
+static bool __efistub_global efi_nokaslr;
+static bool __efistub_global efi_quiet;
+static bool __efistub_global efi_novamap;
+static bool __efistub_global efi_nosoftreserve;
 
-int __pure nokaslr(void)
+bool __pure nokaslr(void)
 {
-	return __nokaslr;
+	return efi_nokaslr;
 }
-int __pure is_quiet(void)
+bool __pure is_quiet(void)
 {
-	return __quiet;
+	return efi_quiet;
 }
-int __pure novamap(void)
+bool __pure novamap(void)
 {
-	return __novamap;
+	return efi_novamap;
 }
 bool __pure __efi_soft_reserve_enabled(void)
 {
@@ -455,11 +455,11 @@ efi_status_t efi_parse_options(char const *cmdline)
 
 	str = strstr(cmdline, "nokaslr");
 	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
-		__nokaslr = 1;
+		efi_nokaslr = true;
 
 	str = strstr(cmdline, "quiet");
 	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
-		__quiet = 1;
+		efi_quiet = true;
 
 	/*
 	 * If no EFI parameters were specified on the cmdline we've got
@@ -479,18 +479,18 @@ efi_status_t efi_parse_options(char const *cmdline)
 	while (*str && *str != ' ') {
 		if (!strncmp(str, "nochunk", 7)) {
 			str += strlen("nochunk");
-			__chunk_size = -1UL;
+			efi_chunk_size = -1UL;
 		}
 
 		if (!strncmp(str, "novamap", 7)) {
 			str += strlen("novamap");
-			__novamap = 1;
+			efi_novamap = true;
 		}
 
 		if (IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
 		    !strncmp(str, "nosoftreserve", 7)) {
 			str += strlen("nosoftreserve");
-			efi_nosoftreserve = 1;
+			efi_nosoftreserve = true;
 		}
 
 		/* Group words together, delimited by "," */
@@ -644,8 +644,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 			while (size) {
 				unsigned long chunksize;
 
-				if (IS_ENABLED(CONFIG_X86) && size > __chunk_size)
-					chunksize = __chunk_size;
+				if (IS_ENABLED(CONFIG_X86) && size > efi_chunk_size)
+					chunksize = efi_chunk_size;
 				else
 					chunksize = size;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 4e2b33fd6a43..c244b165005e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,9 +25,15 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-extern int __pure nokaslr(void);
-extern int __pure is_quiet(void);
-extern int __pure novamap(void);
+#ifdef CONFIG_ARM
+#define __efistub_global	__section(.data)
+#else
+#define __efistub_global
+#endif
+
+extern bool __pure nokaslr(void);
+extern bool __pure is_quiet(void);
+extern bool __pure novamap(void);
 
 extern __pure efi_system_table_t  *efi_system_table(void);
 
-- 
2.20.1

