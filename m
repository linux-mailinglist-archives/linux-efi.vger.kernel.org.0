Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B801AC8AD
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395086AbgDPPMf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 11:12:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46394 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395080AbgDPPMc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 11:12:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id g74so21562647qke.13;
        Thu, 16 Apr 2020 08:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dyf4r03T42/Fy8x1nrv3/xsvgPjc2y6s6Z0vSeQSYSg=;
        b=pcC9rpeySHk3w+NjLlo6qNuB8XsZMgtE+AfteIHyR0pnxMX1kyI690eDiNL+lxJBm3
         VKCv7R97umCPM/AW9dSGq7m6r0Z4w7AzMrsYcHpRYexJUlD5KgSyNGW3SrD6ilLwwzR3
         lkjLhv2VxamOKkmP0kvJ8h4Z/IuOt93nHXTdbQwOvZUqEqVdf0aZC2Fxkfxz/MQDqH5P
         13+KH/2vq74cM96sas+AgkmMcI7lu2hYvZX5L+8K2KH5s9DgMpHKVBfBtTs9Uge0vOCg
         CAMkdmAHPibb0P+xcSgtErq7xTLpZvRgaZHCgVaRPMHnrblGDGagBQnKRz+7ulaF6wXd
         v1ag==
X-Gm-Message-State: AGi0PuYZpqzf2mpWngvswMGChSJ16bi32Jz9/BNykR18rSDlYkY7kIMB
        tCvUjUk9vf3Gf/rtigmGLow=
X-Google-Smtp-Source: APiQypKLdtvWPbVerN9afGD477FA7gKjijbQItkiMGN23vQW6YEg3e2VjR3oP6K+WdheuvtL1luyQQ==
X-Received: by 2002:a37:58a:: with SMTP id 132mr21979682qkf.303.1587049951094;
        Thu, 16 Apr 2020 08:12:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c207sm15252197qkb.7.2020.04.16.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:12:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] efi/x86: Remove __efistub_global and add relocation check
Date:   Thu, 16 Apr 2020 11:12:26 -0400
Message-Id: <20200416151227.3360778-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.25.3
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

Add relocation checking for x86 as well to catch non-PC-relative
relocations that require runtime processing, since the EFI stub does not
do any runtime relocation processing.

This will catch, for example, data relocations created by static
initializers of pointers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/vmlinux.lds.S |  1 +
 drivers/firmware/efi/libstub/Makefile  | 32 +++++++++++++++++---------
 drivers/firmware/efi/libstub/efistub.h |  4 ----
 3 files changed, 22 insertions(+), 15 deletions(-)

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
index 45ffe0822df1..069d117d5451 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -73,13 +73,32 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
-lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-y	:= $(lib-y)
+lib-y	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
+#
+# ARM discards the .data section because it disallows r/w data in the
+# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
+# which are preserved explicitly by the decompressor linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
+				   --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
+
+#
+# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
+# .bss section, so the .bss section of the EFI stub needs to be included in the
+# .data section of the compressed kernel to ensure initialization. Rename the
+# .bss section here so it's easy to pick out in the linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_X86_32) := R_386_32
+STUBCOPY_RELOC-$(CONFIG_X86_64) := R_X86_64_64
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
@@ -97,12 +116,3 @@ quiet_cmd_stubcopy = STUBCPY $@
 		/bin/false;						\
 	fi;								\
 	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
-
-#
-# ARM discards the .data section because it disallows r/w data in the
-# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
-# which are preserved explicitly by the decompressor linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
-				   --rename-section .bss=.bss.efistub,load,alloc
-STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
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
2.25.3

