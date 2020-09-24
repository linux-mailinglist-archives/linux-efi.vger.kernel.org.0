Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58D927705F
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIXL4Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 07:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbgIXL4Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 07:56:24 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1012344C;
        Thu, 24 Sep 2020 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600948583;
        bh=3uyo8fFXY3k6Xdx1KAGmxTA1tZ4v3aug8Ud7x2AjvAs=;
        h=From:To:Cc:Subject:Date:From;
        b=AE7SKO/bXMtPbIza/C5+T6vb6efHdGY/WxJ4gaHWkyGr9xhoaj0H6GiU49jA5G1WE
         g74qRbgErnT+uSnePVpCLfjaqiU1pGh0yLYCz7NmareavyYK2Ko2E3NGB+prHgXVm7
         GJWmfvhTbR5H5YrxAYRtDYkL/hSEjw6eG/rvhOFQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH] efi: add definition of EFI_MEMORY_CPU_CRYPTO and ability to report it
Date:   Thu, 24 Sep 2020 13:56:19 +0200
Message-Id: <20200924115619.20740-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Incorporate the definition of EFI_MEMORY_CPU_CRYPTO from the UEFI
specification v2.8, and wire it into our memory map dumping routine
as well.

To make a bit of space in the output buffer, which is provided by
the various callers, shorten the descriptive names of the memory
types.

Cc: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
This could be split into two or even three patches, but this might need
to go into -stable as well, so presented as a single patch.

 drivers/firmware/efi/efi.c | 47 ++++++++++----------
 include/linux/efi.h        |  1 +
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3b5136..ebb59e52294f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -714,7 +714,7 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 		vendor);
 }
 
-static __initdata char memory_type_name[][20] = {
+static __initdata char memory_type_name[][13] = {
 	"Reserved",
 	"Loader Code",
 	"Loader Data",
@@ -722,14 +722,14 @@ static __initdata char memory_type_name[][20] = {
 	"Boot Data",
 	"Runtime Code",
 	"Runtime Data",
-	"Conventional Memory",
-	"Unusable Memory",
-	"ACPI Reclaim Memory",
-	"ACPI Memory NVS",
-	"Memory Mapped I/O",
-	"MMIO Port Space",
+	"Conventional",
+	"Unusable",
+	"ACPI Reclaim",
+	"ACPI Mem NVS",
+	"MMIO",
+	"MMIO Port",
 	"PAL Code",
-	"Persistent Memory",
+	"Persistent",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
@@ -756,26 +756,27 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
-		     EFI_MEMORY_NV | EFI_MEMORY_SP |
+		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
 		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
-			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
-			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
-			 attr & EFI_MEMORY_SP      ? "SP"  : "",
-			 attr & EFI_MEMORY_NV      ? "NV"  : "",
-			 attr & EFI_MEMORY_XP      ? "XP"  : "",
-			 attr & EFI_MEMORY_RP      ? "RP"  : "",
-			 attr & EFI_MEMORY_WP      ? "WP"  : "",
-			 attr & EFI_MEMORY_RO      ? "RO"  : "",
-			 attr & EFI_MEMORY_UCE     ? "UCE" : "",
-			 attr & EFI_MEMORY_WB      ? "WB"  : "",
-			 attr & EFI_MEMORY_WT      ? "WT"  : "",
-			 attr & EFI_MEMORY_WC      ? "WC"  : "",
-			 attr & EFI_MEMORY_UC      ? "UC"  : "");
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
+			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
+			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
+			 attr & EFI_MEMORY_SP			? "SP"  : "",
+			 attr & EFI_MEMORY_NV			? "NV"  : "",
+			 attr & EFI_MEMORY_XP			? "XP"  : "",
+			 attr & EFI_MEMORY_RP			? "RP"  : "",
+			 attr & EFI_MEMORY_WP			? "WP"  : "",
+			 attr & EFI_MEMORY_RO			? "RO"  : "",
+			 attr & EFI_MEMORY_UCE			? "UCE" : "",
+			 attr & EFI_MEMORY_WB			? "WB"  : "",
+			 attr & EFI_MEMORY_WT			? "WT"  : "",
+			 attr & EFI_MEMORY_WC			? "WC"  : "",
+			 attr & EFI_MEMORY_UC			? "UC"  : "");
 	return buf;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6f9dc44d6d8e..9cc8b11d26de 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -122,6 +122,7 @@ typedef	struct {
 				((u64)0x0000000000010000ULL)	/* higher reliability */
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
+#define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
-- 
2.17.1

