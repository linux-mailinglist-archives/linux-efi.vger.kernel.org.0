Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524E71AB3AA
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgDOWPo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43799 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgDOWP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id z90so14815774qtd.10;
        Wed, 15 Apr 2020 15:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adNtgtRMt64ieUnhMqRLF0a2CXsdZP572pPfrSALC+A=;
        b=UvkXnONCUl768unE2FEP2e8w4sMPqv2F0qZ4BO/hwfi/QHWb/DR42/rT8HtIO8HcmF
         mZ0ZkS4FDDhbQXt94SijCskTVbtpRnS+Z3Fihub5gUaaQjV8KNxKPToLJM1NBDQDb/Jb
         MvFtH9mTEJ140J3PzjcznQzIxHDCp7ZmttG/btQBa6ydzVTozTM5cxCUwn6gJTKbWN99
         bEPR8cVpnJThFGY35bFPyMHL+eFttpFOplsJHX3mi5FdbHgPJPrOLdTlD4/zvEVkCUTi
         9wvGHqEYBJWs2WeS3fJWlUPd6O+PxRzQh+IrgH0YOBA6po3Im1pPs7QO2Ud80PgVXeJF
         T30w==
X-Gm-Message-State: AGi0PuaUAsn6a/cOIkLZOrvRFahwEPAH0DdAteL4XxMrW3RcDEW7aC/F
        kHNNGh+vvDhC6Ro0eBuRZ7A=
X-Google-Smtp-Source: APiQypIiGk8iIa1+JSVxpWv0uJMYikPkp/8IVwwrjnBEyah7xM9Wi9/EuobLCnrWoEvEYpUZhSvCnA==
X-Received: by 2002:ac8:71d8:: with SMTP id i24mr20622652qtp.223.1586988925102;
        Wed, 15 Apr 2020 15:15:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] efi: Kill __efistub_global
Date:   Wed, 15 Apr 2020 18:15:19 -0400
Message-Id: <20200415221520.2692512-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415221520.2692512-1-nivedita@alum.mit.edu>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that both arm and x86 are using the linker script to place the EFI
stub's global variables in the correct section, remove __efistub_global.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/arm-stub.c        |  4 ++--
 drivers/firmware/efi/libstub/efi-stub-helper.c | 15 +++++++--------
 drivers/firmware/efi/libstub/efistub.h         |  2 --
 drivers/firmware/efi/libstub/gop.c             |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 99a5cde7c2d8..bf42d6c742a8 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -36,9 +36,9 @@
 #endif
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
-static bool __efistub_global flat_va_mapping;
+static bool flat_va_mapping;
 
-static efi_system_table_t *__efistub_global sys_table;
+static efi_system_table_t *sys_table;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
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
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 49651e20bb9f..f96c56596034 100644
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
index 7583e908852f..aedac3af4b5c 100644
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
2.24.1

