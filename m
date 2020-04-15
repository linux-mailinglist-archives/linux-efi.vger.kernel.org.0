Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6B1AB3A4
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgDOWP0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 18:15:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44186 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgDOWPY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 18:15:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id w24so14815942qts.11;
        Wed, 15 Apr 2020 15:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+WCTPxC8MtmwIEzjkAHtcw6Iyj7SzDEM2KrEeYU91g=;
        b=Cql9riM97qXFYt7vFVW6ugy0QOPzMXGYTsVFCXrDFWG29bbjF79bXbLGC2prPTjIuN
         QKWPDnAttsSWmaRRFLAu6IttBCoY+KCdCye26cmt2j1xlqsUh6hXKXCtsD577doYTLHG
         tWD/OvAebCWLRz7nLOlDdh5OO0OlWJHLaYQpbkjBkkr1l2pxNuXA4WPJLvU0KFQDGN9b
         FgQXrQlCapiJN8cI0Vl8CRIWuLhwz8Kn1yPhYd1kanxalyg3cs6HSW7tzfNgqJDRQYTf
         VkW6ehdJfZJ9YnV4Pha7XwlF56qoKXAVb80PeeAwFkz7K9gEvvpH+mux/kNfS0G/vb35
         tdUg==
X-Gm-Message-State: AGi0Pubn/SNU/wJupidCEKUY0/yMWTR8H6hKv5sLHFJqdANM9U2zh4k0
        1OE5V+2xjRZ8KdJPojyXefI=
X-Google-Smtp-Source: APiQypI8NnA5drqCjYaPuU0fFArVOFnxNmup6jrUOtP8oL8Xl04Ged6VBA6oue2ewi1z/QUYLxzymQ==
X-Received: by 2002:ac8:2272:: with SMTP id p47mr18126911qtp.297.1586988922280;
        Wed, 15 Apr 2020 15:15:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i20sm13264340qkl.135.2020.04.15.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:15:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] efi/arm: Remove __efistub_global annotation
Date:   Wed, 15 Apr 2020 18:15:16 -0400
Message-Id: <20200415221520.2692512-2-nivedita@alum.mit.edu>
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
2.24.1

