Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB61B765F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgDXNHQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgDXNHN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:13 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA162087E;
        Fri, 24 Apr 2020 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733632;
        bh=+6ZF5JZBWYW7C6szLyrrPqghgocxwmA+j6HDDjswy3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chPidlqym1b2XUs2c7pzdyXQKv2u3VhxGsG4tPsfC9xiB+hSUnYMk2THjSSe3s6/J
         8soNNDtGLjP6xbmFRbYJizvqNDBQCtY8wqp7LnpqRogvGbTZR+03fZgBkWJ4+SxxcO
         G9KdQKwL1CkQOACxWJXLhCDK4cdND9xEOAWXD6E4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 28/33] efi: Kill __efistub_global
Date:   Fri, 24 Apr 2020 15:05:26 +0200
Message-Id: <20200424130531.30518-29-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Now that both arm and x86 are using the linker script to place the EFI
stub's global variables in the correct section, remove __efistub_global.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20200416151227.3360778-4-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 15 +++++++--------
 drivers/firmware/efi/libstub/efi-stub.c        |  4 ++--
 drivers/firmware/efi/libstub/efistub.h         |  2 --
 drivers/firmware/efi/libstub/gop.c             |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index c6092b6038cf..14e56a64f208 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -12,14 +12,13 @@
 
 #include "efistub.h"
 
-static bool __efistub_global efi_nochunk;
-static bool __efistub_global efi_nokaslr;
-static bool __efistub_global efi_noinitrd;
-static bool __efistub_global efi_quiet;
-static bool __efistub_global efi_novamap;
-static bool __efistub_global efi_nosoftreserve;
-static bool __efistub_global efi_disable_pci_dma =
-					IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
+static bool efi_nochunk;
+static bool efi_nokaslr;
+static bool efi_noinitrd;
+static bool efi_quiet;
+static bool efi_novamap;
+static bool efi_nosoftreserve;
+static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
 bool __pure nochunk(void)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 8a26cc11ca4a..8455c590c7b9 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -36,9 +36,9 @@
 #endif
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
-static bool __efistub_global flat_va_mapping;
+static bool flat_va_mapping;
 
-static efi_system_table_t *__efistub_global sys_table;
+static efi_system_table_t *sys_table;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5244eacc5d4b..9a87fff1d4ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,8 +25,6 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#define __efistub_global
-
 extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
 extern bool __pure noinitrd(void);
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index fa05a0b0adfd..216327d0b034 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -32,7 +32,7 @@ static struct {
 			u8 depth;
 		} res;
 	};
-} cmdline __efistub_global = { .option = EFI_CMDLINE_NONE };
+} cmdline = { .option = EFI_CMDLINE_NONE };
 
 static bool parse_modenum(char *option, char **next)
 {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ccb229fb45..1c3807d0c321 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,7 +20,7 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table __efistub_global;
+static efi_system_table_t *sys_table;
 extern const bool efi_is64;
 extern u32 image_offset;
 
-- 
2.17.1

