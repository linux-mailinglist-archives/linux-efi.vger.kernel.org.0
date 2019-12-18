Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8429124EBB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfLRRD2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfLRRD2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:28 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0F524650;
        Wed, 18 Dec 2019 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688607;
        bh=TcnjokefKw/qEC12DaROp7Q82qiK3iob28QfZMHCYDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Svl9SMGnluHj7Yf6g7MIE/lfPfdOvxr4ie9TC7cVxsAWLtq21rPyF/F4Jq0FifOoY
         6VIS/Yc48JxBd0knoSpvvdXWU75BZIwQOuiDxQ6yITRQb5u4M20dQbujYMxxs31YDE
         MyQhFUd1fIhr8cHPzpvjbimQ9y9yW5038fgFyrus=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 19/21] efi/libstub: tidy up types and names of global cmdline variables
Date:   Wed, 18 Dec 2019 19:01:37 +0200
Message-Id: <20191218170139.9468-20-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop leading underscores and use bool not int for true/false
variables set on the command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 34 ++++++++++----------
 drivers/firmware/efi/libstub/efistub.h         |  6 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 59c273cb7a92..8b0d59f5c8cd 100644
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
+static bool __section(.data) efi_nokaslr;
+static bool __section(.data) efi_quiet;
+static bool __section(.data) efi_novamap;
 static bool __section(.data) efi_nosoftreserve;
 
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
@@ -461,11 +461,11 @@ efi_status_t efi_parse_options(char const *cmdline)
 
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
@@ -485,18 +485,18 @@ efi_status_t efi_parse_options(char const *cmdline)
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
@@ -661,8 +661,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 			while (size) {
 				unsigned long chunksize;
 
-				if (IS_ENABLED(CONFIG_X86) && size > __chunk_size)
-					chunksize = __chunk_size;
+				if (IS_ENABLED(CONFIG_X86) && size > efi_chunk_size)
+					chunksize = efi_chunk_size;
 				else
 					chunksize = size;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b5d9c9e65213..72e60b6afbf8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,9 +25,9 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-extern int __pure nokaslr(void);
-extern int __pure is_quiet(void);
-extern int __pure novamap(void);
+extern bool __pure nokaslr(void);
+extern bool __pure is_quiet(void);
+extern bool __pure novamap(void);
 
 extern __pure efi_system_table_t  *efi_system_table(void);
 
-- 
2.17.1

