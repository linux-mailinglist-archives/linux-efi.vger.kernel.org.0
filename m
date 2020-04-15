Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94D1AB3A5
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgDOWP3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37966 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731102AbgDOWP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id f13so14732828qti.5;
        Wed, 15 Apr 2020 15:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/884Y4S8L6kS/iSrGalw7uxiGyhKVKiR3Ww6KT2GqZU=;
        b=saoxkQ4jJVC78vnE7dGC4IvxFpewAunuLSS1GBV2UU7+/aY8YP0ZUCxQSL9/NTjs3/
         StK1LsgBQ//j6tdvfWfyiTtfUuXY1Alu0suw1PiJCmsOqweAn+ibUuF8tbJDZaOu/YJi
         DIOM4AkkB/fywG7oHS4ZRh/j5Utkg5svGRmF/ocr5W92Zs9WQjZRyn8NtjQ10KsRJNau
         7sI0kNkPa1rYOeOWJKI/igqhCT6DEesKkiJItvAWGiyp6nOXgetrPwqMQLHtANmBBbbn
         4YF+30VfvY1u0iTUGpSa1Ro1MbZ4wPitGixqaDgvSWF7WDk7k90JEJ5m92AO+X7F1GaE
         MjxA==
X-Gm-Message-State: AGi0PubQkVoUDJ7TdHyqn55gCAR4+dko2Qe322/tCWI+Pix3b+gOMMD2
        eAC3jbe8Nai9oG+XRUTZ3g4=
X-Google-Smtp-Source: APiQypJlrUQQ2en4qUdzPOfXDNxDRWtBRRylqygI8Tcxmp3E2gsu+n70rOWANLLUxOh7H3FryRVBlg==
X-Received: by 2002:ac8:7309:: with SMTP id x9mr21688226qto.68.1586988924230;
        Wed, 15 Apr 2020 15:15:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] efi/x86: Remove __efistub_global annotation
Date:   Wed, 15 Apr 2020 18:15:18 -0400
Message-Id: <20200415221520.2692512-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415221520.2692512-1-nivedita@alum.mit.edu>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of using __efistub_global to force variables into the .data
section, leave them in the .bss but pull the EFI stub's .bss section
into .data in the linker script for the compressed kernel.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/vmlinux.lds.S |  1 +
 drivers/firmware/efi/libstub/Makefile  | 12 ++++++++++--
 drivers/firmware/efi/libstub/efistub.h |  4 ----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..0dc5c2b9614b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+		*(.bss.efistub)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e5e76677f2da..0bb2916eb12b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
-lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-y	:= $(lib-y)
+lib-y	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
@@ -89,6 +89,14 @@ STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
 				   --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 
+#
+# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
+# .bss section, so the .bss section of the EFI stub needs to be included in the
+# .data section of the compressed kernel to ensure initialization. Rename the
+# .bss section here so it's easy to pick out in the linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a92d42ffd9f7..49651e20bb9f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,11 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#if defined(CONFIG_X86)
-#define __efistub_global	__section(.data)
-#else
 #define __efistub_global
-#endif
 
 extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
-- 
2.24.1

