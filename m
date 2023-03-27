Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A76CA07E
	for <lists+linux-efi@lfdr.de>; Mon, 27 Mar 2023 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjC0Jvl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Mar 2023 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjC0Jvk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Mar 2023 05:51:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E01984
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 02:51:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so8202973pjb.0
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679910695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Axuo6xoCs4y+i1WqB0fWak8R/VsZip3pbayocnqRiYc=;
        b=TnVHtUoPjgPD7TV3OAx4AtsnR74EdlhH2K5/yPskX0i/uJWFgtkaGqkWp1CDyyt2yo
         5OCEyRfPT4MCloc+gTQSoqcBgoyLaDp7Fq7jleUV1PK0XdA7pvfpOH76Jc+FWoUyM7Su
         i29X5iXuyuaTuqzX3d8ZaweQ0wKCVggdRiOZqs5Oz3/bPi3b+zYfJA1NWdqhBFQypr35
         fGN/1XIFhbmug3E1xjCHj/6hg1fmRn1JALqEUI2TanfILW+35W5mk8QRRJegoGOQ32Bx
         7zntbM3iPsGjveMmclAf3zZBVLtIPTIKBhldV7zYuJQnEGx2Ey/BG1YSieV04lLwB5BW
         NFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Axuo6xoCs4y+i1WqB0fWak8R/VsZip3pbayocnqRiYc=;
        b=Oz8WewXcOWAvqNYoUcFwWxKqh08tiWkYhZpOeSc3xhRc3QQRZcRyM4rw7UABpcLiCL
         vvnncn0zfnyat409d6Olqq5tuzrY6sJkRTO+ERyEXCePkcPRC5rOLiMXXk5IkKuSP0fZ
         1ilSzDhuONvfgmTu4fP4PNdJihz/thlpLMbn38zcmukqACXQ030pOjkoosusmqc6dY49
         CQR15qqRunJ6xAYPotr8orYyLLjlTag0wd2t3ydzbvF5QBlYgNh0/kW12U/Qlm3N3c+u
         y7HEk1bkUt8ICuIxJm8ZmMhErrE23eT8LxiX0cTiFUB7YVvDRi3BQfpUF+nuSvJKRLAQ
         BkMg==
X-Gm-Message-State: AAQBX9dCUt/M+elxCQLKpTo+PFwmfRNbNP0l6T/1J53o/nw3Fj4HtgaT
        qd9ZGwA5X4E5Ku7qhLr6UXLPA7nd5A==
X-Google-Smtp-Source: AKy350bh0SzTC5Z7PfEeuC+iLQ2C+s3WdMcJ2jhuJHDDsQ0gQa91L2vC+CQaO/EnEnEoEeFEyx/NYg==
X-Received: by 2002:a17:90b:38c1:b0:23d:3761:6085 with SMTP id nn1-20020a17090b38c100b0023d37616085mr13299790pjb.34.1679910695612;
        Mon, 27 Mar 2023 02:51:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902789200b00185402cfedesm18815820pll.246.2023.03.27.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:51:35 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-efi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH] efi: zboot: Ensure zboot PIC
Date:   Mon, 27 Mar 2023 17:51:22 +0800
Message-Id: <20230327095123.20023-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not convey
any relocation information. That means vmlinuz.efi is expected to be
PIC.

At present, vmlinuz.efi is PIC. But it is better to adopt the same
solution used by the kernel to resolve the code relocation issue by
itself. That is to resolve R_AARCH64_RELATIVE at the runtime.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/Makefile       |  2 +-
 drivers/firmware/efi/libstub/Makefile.zboot |  2 +-
 drivers/firmware/efi/libstub/zboot-entry.S  | 35 +++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c        |  2 +-
 drivers/firmware/efi/libstub/zboot.lds      |  6 ++++
 5 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/zboot-entry.S

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 80d85a5169fb..4447395d7218 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -95,7 +95,7 @@ lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
-lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot-entry.o zboot.o $(zboot-obj-y)
 
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 43e9a4cab9f5..1ed948cee92f 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -36,7 +36,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FO
 
 ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
+LDFLAGS_vmlinuz.efi.elf :=  --no-undefined -X -shared -Bsymbolic -z notext --no-apply-dynamic-relocs -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
 $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
 	$(call if_changed,ld)
 
diff --git a/drivers/firmware/efi/libstub/zboot-entry.S b/drivers/firmware/efi/libstub/zboot-entry.S
new file mode 100644
index 000000000000..072207f2f6ba
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-entry.S
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/elf.h>
+#define ZBOOT_HEADER_BASE 0
+
+	.text
+/*
+ * x0: efi_handle_t
+ * x1: efi_system_table_t *
+ */
+	.global efi_zboot_entry
+efi_zboot_entry:
+	adrp	x2, efi_zboot_header
+	add	x2, x2, :lo12:efi_zboot_header
+	mov	x3, ZBOOT_HEADER_BASE
+	sub	x3, x2, x3		// delta between actual and linked address
+	adrp	x4, _rela_start
+	add	x4, x4, :lo12:_rela_start
+	adrp	x5, _rela_end
+	add	x5, x5, :lo12:_rela_end
+
+0:	cmp	x5, x4
+	b.hs	1f
+	ldp	x6, x7, [x4], #24
+	ldr	x8, [x4, #-8]
+	cmp	w7, #R_AARCH64_RELATIVE
+	b.ne	0b
+	add	x8, x8, x3
+	str	x8, [x6, x3]
+	b	0b
+
+1:
+	dsb	ishst
+	ic	iallu
+	b	efi_zboot_main
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index ba234e062a1a..7aa6b2e6d104 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -58,7 +58,7 @@ void __weak efi_cache_sync_image(unsigned long image_base,
 }
 
 asmlinkage efi_status_t __efiapi
-efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
+efi_zboot_main(efi_handle_t handle, efi_system_table_t *systab)
 {
 	unsigned long compressed_size = _gzdata_end - _gzdata_start;
 	unsigned long image_base, alloc_size, code_size;
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 93d33f68333b..631942604c3f 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -12,6 +12,12 @@ SECTIONS
 		*(.text* .init.text*)
 	}
 
+	.rela.dyn : ALIGN(8) {
+		__efistub__rela_start = .;
+		*(.rela .rela*)
+		__efistub__rela_end = .;
+	}
+
 	.rodata : ALIGN(8) {
 		__efistub__gzdata_start = .;
 		*(.gzdata)
-- 
2.31.1

