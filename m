Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29B1AC8AE
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395090AbgDPPMi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 11:12:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37786 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395081AbgDPPMe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 11:12:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id q17so16354754qtp.4;
        Thu, 16 Apr 2020 08:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KisqXFX2ulNUKz2440gS97HInTPJUxOKPLXnv3/3XBo=;
        b=ONRHzk98M6o5zKTEZKdr85THO+LJ157tF5YoA7aP/p4JUeasZdCWInDFMXFnNxf8JS
         iRmKGq2nLN23XqkspShEATxbh3cWf3ij7oaRqnQjNJPEDnmOlh4OpirHcwNJNZMKKiqz
         7+RAxXc4aMCJYDS9tycQi2aKT4eJyVFJPxUPOU1b5VLYFTfcOy0r1F4ZHiAcUnWZPqkn
         uap0IQM8QmCNWX0z/Rg4+tbiyCtdGlSmC/Po6OJZrPTPvT//Q0GzZ/LQdy4AB3b34EUs
         2O6n4ibrihLncMIb5QL2TY0XLnvChVU4/hf1Ltn20zPtXMq6cpc1Q9H/YLnZgrfQlYPB
         8qZw==
X-Gm-Message-State: AGi0PuZxq2Tx2hDsIGhpf4FjyGOdafqIdIbqEutFRie0VpyztAd4gdtX
        o0TtbiInIzVo8ssnIK9iXrg=
X-Google-Smtp-Source: APiQypIPRk5qt0xhHpWYN1+m32Md8N9+UiGMBo0eavOhuXfsoMRtmHqYSc4JoAekFfMxinNmOUXvzg==
X-Received: by 2002:ac8:6d2c:: with SMTP id r12mr19506468qtu.355.1587049952304;
        Thu, 16 Apr 2020 08:12:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c207sm15252197qkb.7.2020.04.16.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:12:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] efi: Kill __efistub_global
Date:   Thu, 16 Apr 2020 11:12:27 -0400
Message-Id: <20200416151227.3360778-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.25.3
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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
2.25.3

