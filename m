Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503191B766C
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDXNHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgDXNHJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:09 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D709721D7A;
        Fri, 24 Apr 2020 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733628;
        bh=p+IQwNbfDeLJQR+77NgodSuCuaqd1Jnu5YGcIuDiIUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl805xhFzHKUAJmo20ZVqxtpOpmjyxSr8/AbZtPrexCrvqcdOyN3phpQpvhFvr9MW
         DMJkpSOwmeqFl+fUO+h2y3uGVZ/QvcudwPyjqFbaobSExnfRDkV/wQBcwpTeNc5WLg
         vUN44RDohp6J49E9u6A2yNLro2YJIndNA2Bb7MkQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 26/33] efi/arm: Remove __efistub_global annotation
Date:   Fri, 24 Apr 2020 15:05:24 +0200
Message-Id: <20200424130531.30518-27-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Instead of using __efistub_global to force variables into the .data
section, leave them in the .bss but pull the EFI stub's .bss section
into .data in the linker script for the compressed kernel.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20200416151227.3360778-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
index 9a712a6e2f87..aa3ab9a4105e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -101,8 +101,9 @@ quiet_cmd_stubcopy = STUBCPY $@
 
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
index 2a0698d9dc78..96e25b17c88e 100644
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
2.17.1

