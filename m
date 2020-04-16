Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83D71AC8BC
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438646AbgDPPNu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 11:13:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43544 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395067AbgDPPMc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 11:12:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id z90so16606157qtd.10;
        Thu, 16 Apr 2020 08:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imM7gqSOmjnj0wLJRzezT2h41SI88XC5LjGCQYHrvNA=;
        b=AYjrBysu632X4CYN38xkeaCnbPj1dQEo0rNA+77p95vZQHenGv1jEfzaIyAGZNzGFc
         +akHzWEmHU8ZXwq4FwHFmfF+bYn4j2XJOZi+3JblObHPw5wib0kPReEHWu8JxpuSfCOI
         FxhHIhal8f54LasOYnRBYOZskYHuC+ggd+xQ/e0+rOoTtxl5hsbRU+AiZIrZWeJeb0ap
         2Au7IDoyfz20JLUvhVRO9GH3OzLwWpS3t4L5/nC847W2DB/bx1UFGWM2G8TTI0atMNKE
         STIw+HMd739MHkQrijslIwDa2ovj3SP3uYQUNRbQ8d/OnMknsrLCXSVUeZRP65ZBOCtc
         3aJQ==
X-Gm-Message-State: AGi0PuZdyb6FoBawFSND/j4dBI0dBio6spHCuv/qle57XCDHFZ6O+1Vh
        u0LWAZLYi5TJFlJgRLz9w24=
X-Google-Smtp-Source: APiQypICZD8HX0Ag/0fyyN0plcalNvAkwlqULHJHnrsXM4DNaQJR+ueS8IG2TsC0OBzxINWC7ELOiw==
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr27114418qto.21.1587049950302;
        Thu, 16 Apr 2020 08:12:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c207sm15252197qkb.7.2020.04.16.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:12:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] efi/arm: Remove __efistub_global annotation
Date:   Thu, 16 Apr 2020 11:12:25 -0400
Message-Id: <20200416151227.3360778-2-nivedita@alum.mit.edu>
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

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
 drivers/firmware/efi/libstub/Makefile  | 7 ++++---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index b247f399de71..b6793c7932a9 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -78,7 +78,7 @@ SECTIONS
      * The EFI stub always executes from RAM, and runs strictly before the
      * decompressor, so we can make an exception for its r/w data, and keep it
      */
-    *(.data.efistub)
+    *(.data.efistub .bss.efistub)
     __pecoff_data_end = .;
 
     /*
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 094eabdecfe6..45ffe0822df1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -100,8 +100,9 @@ quiet_cmd_stubcopy = STUBCPY $@
 
 #
 # ARM discards the .data section because it disallows r/w data in the
-# decompressor. So move our .data to .data.efistub, which is preserved
-# explicitly by the decompressor linker script.
+# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
+# which are preserved explicitly by the decompressor linker script.
 #
-STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub
+STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
+				   --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index bd0b86b63936..a92d42ffd9f7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#if defined(CONFIG_ARM) || defined(CONFIG_X86)
+#if defined(CONFIG_X86)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
-- 
2.25.3

